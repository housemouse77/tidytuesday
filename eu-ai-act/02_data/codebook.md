# Codebook

## raw/
| File | Source | Produced by | Notes |
|---|---|---|---|
| `aiact_en.html` | S001 | `03_code/R/01_download_aiact.R` | EUR-Lex HTML, OJ version |
| `aiact_it.html` | S002 | same | Italian version |

## processed/
### `aiact_units_<lang>.csv`
One row per provision unit.

| Variable | Type | Description |
|---|---|---|
| `lang` | str | `EN` / `IT` |
| `unit_type` | str | `recital`, `article`, `annex` |
| `unit_no` | str | e.g. `5`, `III` |
| `unit_id` | str | EUR-Lex element id (e.g. `art_5`, `rct_12`, `anx_III`), or a generated id if the regex fallback was used |
| `chapter_no` | int | Chapter number 1–13 (articles only) |
| `chapter` | str | Chapter in Roman numerals (articles only) |
| `heading` | str | Article title (articles only) |
| `text` | strL | Full text of the unit |
| `n_words` | int | Word count |

Key for EN↔IT matching: `unit_type` + `unit_no`.
