# =============================================================================
# 01_download_aiact.R
# Downloads Regulation (EU) 2024/1689 (AI Act) from EUR-Lex, in EN and IT,
# and splits it into recitals / articles / annexes.
#
# Input : internet (EUR-Lex)                      [sources S001, S002]
# Output: 02_data/raw/aiact_<lang>.html           (read-only after download)
#         02_data/processed/aiact_units_<lang>.csv (see 02_data/codebook.md)
#
# Run from the project root: open eu-ai-act.Rproj in RStudio first.
# =============================================================================

pkgs <- c("rvest", "xml2", "dplyr", "stringr", "readr", "purrr", "tibble")
missing <- setdiff(pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing)
suppressPackageStartupMessages({
  library(rvest); library(xml2); library(dplyr)
  library(stringr); library(readr); library(purrr); library(tibble)
})

if (!file.exists("eu-ai-act.Rproj")) {
  stop("Run this from the eu-ai-act/ folder (open eu-ai-act.Rproj).")
}
raw_dir  <- file.path("02_data", "raw")
proc_dir <- file.path("02_data", "processed")

LANGS <- c("EN", "IT")
CELEX <- "32024R1689"

# ---- 1. Download -------------------------------------------------------------
download_act <- function(lang, overwrite = FALSE) {
  dest <- file.path(raw_dir, sprintf("aiact_%s.html", tolower(lang)))
  if (file.exists(dest) && !overwrite) {
    message("Exists, skipping download: ", dest)
    return(dest)
  }
  url <- sprintf("https://eur-lex.europa.eu/legal-content/%s/TXT/HTML/?uri=CELEX:%s",
                 lang, CELEX)
  options(HTTPUserAgent = "Mozilla/5.0 (research script; R)")
  download.file(url, dest, mode = "wb", quiet = TRUE)
  # EUR-Lex sometimes serves a short bot-check page instead of the act.
  if (file.size(dest) < 300000) {
    warning("File ", dest, " is only ", file.size(dest), " bytes: probably not the act. ",
            "Open ", url, " in a browser, save the page as HTML to ", dest,
            " and re-run.")
  }
  dest
}

# ---- 2. Parse ----------------------------------------------------------------
# Expected EUR-Lex OJ structure: <div id="rct_1">, <div id="art_1">, <div id="anx_I">;
# article titles in <p class="oj-sti-art">.
top_level <- function(doc, prefix) {
  xml_find_all(doc, sprintf(
    "//div[starts-with(@id,'%s') and not(contains(@id,'.'))]", prefix))
}

clean <- function(x) str_squish(str_replace_all(x, " ", " "))

parse_structured <- function(doc, lang) {
  grab <- function(prefix, type) {
    nodes <- top_level(doc, prefix)
    if (!length(nodes)) return(NULL)
    tibble(
      lang      = lang,
      unit_type = type,
      unit_id   = xml_attr(nodes, "id"),
      unit_no   = str_remove(xml_attr(nodes, "id"), prefix),
      heading   = if (type == "article") {
        map_chr(nodes, ~ clean(html_text2(xml_find_first(.x, ".//p[contains(@class,'oj-sti-art')]"))))
      } else NA_character_,
      text      = clean(html_text2(nodes))
    )
  }
  bind_rows(grab("rct_", "recital"), grab("art_", "article"), grab("anx_", "annex"))
}

# Fallback if EUR-Lex changes its markup: split the plain text on "Article n" lines.
parse_fallback <- function(doc, lang) {
  word  <- if (lang == "IT") "Articolo" else "Article"
  lines <- str_split(html_text2(xml_find_first(doc, "//body")), "\n")[[1]] |> clean()
  lines <- lines[lines != ""]
  start <- which(str_detect(lines, sprintf("^%s \\d+$", word)))
  if (!length(start)) stop("Could not find any '", word, " n' headings.")
  end <- c(start[-1] - 1, length(lines))
  tibble(
    lang      = lang,
    unit_type = "article",
    unit_no   = str_extract(lines[start], "\\d+"),
    unit_id   = paste0("fb_art_", unit_no),
    heading   = lines[pmin(start + 1, length(lines))],
    text      = map2_chr(start, end, ~ paste(lines[.x:.y], collapse = " "))
  ) |>
    distinct(unit_no, .keep_all = TRUE)   # keep the first hit per article number
}

# Article -> chapter (OJ structure: I 1-4, II 5, III 6-49, IV 50, V 51-56, VI 57-63,
# VII 64-70, VIII 71, IX 72-94, X 95-96, XI 97-98, XII 99-101, XIII 102-113)
chapter_of <- function(art_no) {
  as.integer(cut(art_no, breaks = c(0, 4, 5, 49, 50, 56, 63, 70, 71, 94, 96, 98, 101, 113),
                 labels = FALSE))
}

parse_act <- function(path, lang) {
  doc   <- read_html(path, encoding = "UTF-8")
  units <- parse_structured(doc, lang)
  if (!"unit_type" %in% names(units) || !any(units$unit_type == "article")) {
    message("Structured parse found no articles; using text fallback (articles only).")
    units <- parse_fallback(doc, lang)
  }
  units |>
    mutate(n_words    = str_count(text, "\\S+"),
           chapter_no = if_else(unit_type == "article",
                                chapter_of(suppressWarnings(as.integer(unit_no))), NA_integer_),
           chapter    = as.character(as.roman(chapter_no))) |>
    select(lang, unit_type, unit_no, unit_id, chapter_no, chapter, heading, text, n_words)
}

# ---- 3. Run ------------------------------------------------------------------
if (sys.nframe() == 0L || interactive()) {
  for (lang in LANGS) {
    path  <- download_act(lang)
    units <- parse_act(path, lang)
    out   <- file.path(proc_dir, sprintf("aiact_units_%s.csv", tolower(lang)))
    write_csv(units, out)

    counts <- count(units, unit_type)
    message("\n", lang, ": wrote ", nrow(units), " rows to ", out)
    print(counts)
    # Sanity check against the OJ text: 180 recitals, 113 articles, 13 annexes.
    expected <- c(recital = 180, article = 113, annex = 13)
    got <- setNames(counts$n, counts$unit_type)[names(expected)]
    if (!identical(unname(got), unname(expected))) {
      warning(lang, ": counts differ from 180/113/13; inspect before using.")
    }
  }
}
