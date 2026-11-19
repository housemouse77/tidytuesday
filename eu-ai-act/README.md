# EU AI Act: deep-learning workspace

The goal is fast, research-grade mastery of **Regulation (EU) 2024/1689 (the AI Act)**, read through three lenses:
accounting/audit research, consulting/policy, and the intelligence/national-security background.
Italian implementation is covered too.

## Layout

| Folder | What goes in it |
|---|---|
| `00_plan/` | `learning_plan.md` (modules, pace), `lectures/` (one mini-lecture per module, **start with `M0_lecture.md`**), `timeline.md` (application dates) |
| `01_sources/` | `source_log.csv` is the registry of every source. Put downloaded PDFs in `primary/` (law, guidelines) and `secondary/` (commentary). **Paywalled papers go in `private_not_in_git/`**, which git ignores. |
| `02_data/` | `raw/` holds files exactly as downloaded and is never edited. `processed/` holds cleaned or derived files, produced only by code. `codebook.md` describes each dataset. |
| `03_code/R/` | `01_download_aiact.R` downloads the Act (EN + IT) from EUR-Lex and splits it into articles, recitals and annexes |
| `03_code/stata/` | `master.do` runs everything. `01_import_articles.do` reads the R output. |
| `04_notes/` | `articles/`: one note per article or cluster (copy `_TEMPLATE_article.md`). `concepts/`: cross-cutting notes. `glossary.md`: Art. 3 definitions. |
| `05_brainstorm/` | `questions_log.md` (open questions), `research_ideas.md` (paper ideas), `consulting_angles.md` |
| `06_output/` | Drafts, slides, memos |

## Workflow rules
1. **Log every source first** in `01_sources/source_log.csv` and give it an ID (`S001`…). Notes cite that ID.
2. **Grade sources** with the Admiralty-style columns (`reliability` A–F, `credibility` 1–6). Commission guidelines are not binding, a law-firm memo is advocacy, and only the CJEU interprets authoritatively.
3. **Raw is read-only.** Every processed file must be reproducible from `raw/` plus code.
4. **Questions before answers.** When something is unclear, add it to `questions_log.md` with the article reference. Close it later with a source ID.
5. **Version check.** The Act is being amended (Digital Omnibus). Every note states which text version it relies on (OJ original 12.07.2024 or a consolidated version with a date).

## Running the code (on your own computer)
- R: open `eu-ai-act.Rproj` in RStudio, then run `03_code/R/01_download_aiact.R`. It needs the `rvest`, `xml2`, `dplyr`, `stringr` and `readr` packages.
- Stata: set the root path at the top of `03_code/stata/master.do`, then `do master.do`.
