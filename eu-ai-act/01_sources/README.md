# Source log conventions

`source_log.csv` has one row per source. Cite sources everywhere as `[S012]` or `[S012, p. 4]`.

| Column | Values |
|---|---|
| `type` | legislation, proposal, guidance, standard, case_law, academic, practitioner, news, dataset |
| `reliability` | Admiralty-style **source** reliability. A = completely reliable (OJ, official text), B = usually reliable (Commission/AI Office, supervisors), C = fairly reliable (peer-reviewed academic), D = not usually reliable (law-firm/vendor marketing), E = unreliable, F = cannot judge |
| `credibility` | **information** credibility. 1 = confirmed by other sources/primary text, 2 = probably true, 3 = possibly true, 4 = doubtful, 5 = improbable, 6 = cannot judge |
| `binding` | yes = legally binding. no = soft law or opinion. Keep the distinction sharp. |
| `status` | to_collect, collected, read, noted (note written in `04_notes/`) |
| `module` | M0–M9 from `00_plan/learning_plan.md` |

File naming for PDFs: `S012_issuer_year_shorttitle.pdf`, for example `S003_EC_2025_guidelines_prohibited.pdf`.
