# =============================================================================
# 02_study_helpers.R: tools for reading the Act from the R console
# Requires the output of 01_download_aiact.R.
#
#   source("03_code/R/02_study_helpers.R")
#   art(5)                       # print Article 5 (EN)
#   art(5, "IT")                 # Italian version
#   compare_lang("article", 27)  # EN and IT side by side
#   recital(53)
#   annex("III")
#   kwic("deployer")             # which articles use a term, with context
#   term_map(c("deployer", "provider", "financial institution", "national security"))
# =============================================================================

suppressPackageStartupMessages({ library(dplyr); library(stringr); library(readr) })

.load_units <- function(lang) {
  f <- file.path("02_data", "processed", sprintf("aiact_units_%s.csv", tolower(lang)))
  if (!file.exists(f)) stop("Missing ", f, ". Run 01_download_aiact.R first.")
  read_csv(f, col_types = cols(.default = "c", n_words = "i"))
}
AI <- list(EN = .load_units("EN"),
           IT = if (file.exists(file.path("02_data", "processed", "aiact_units_it.csv")))
                  .load_units("IT") else NULL)

.show <- function(type, no, lang = "EN", width = 100) {
  u <- filter(AI[[lang]], unit_type == type, unit_no == as.character(no))
  if (!nrow(u)) return(invisible(message("Not found: ", type, " ", no)))
  cat(strwrap(u$text, width = width), sep = "\n")
  invisible(u)
}
art     <- function(no, lang = "EN") .show("article", no, lang)
recital <- function(no, lang = "EN") .show("recital", no, lang)
annex   <- function(no, lang = "EN") .show("annex",   no, lang)

compare_lang <- function(type, no) {
  for (l in c("EN", "IT")) { cat("\n====", l, "====\n"); .show(type, no, l) }
}

# Keyword-in-context: every occurrence of a term, with `window` characters around it.
kwic <- function(term, lang = "EN", type = "article", window = 80) {
  pat  <- regex(term, ignore_case = TRUE)
  base <- filter(AI[[lang]], unit_type %in% type, str_detect(text, pat))
  if (!nrow(base)) return(tibble())
  starts <- str_locate_all(base$text, pat)
  bind_rows(lapply(seq_len(nrow(base)), function(i) {
    s <- starts[[i]][, "start"]
    tibble(unit_type = base$unit_type[i], unit_no = base$unit_no[i],
           context = str_sub(base$text[i], pmax(1, s - window), s + window))
  }))
}

# Which articles mention which terms (counts): a quick map of where concepts live.
term_map <- function(terms, lang = "EN", type = "article") {
  base <- filter(AI[[lang]], unit_type %in% type)
  res  <- sapply(terms, function(t) str_count(base$text, regex(t, ignore_case = TRUE)))
  res  <- matrix(res, nrow = nrow(base), dimnames = list(NULL, terms))
  out  <- bind_cols(select(base, unit_type, unit_no, heading), as_tibble(res))
  out[rowSums(res) > 0, ]
}
