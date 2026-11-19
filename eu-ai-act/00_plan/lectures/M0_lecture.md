# M0 Mini-lecture: what kind of law is the AI Act?

**Week 1 · 3 hours** · Prerequisite: run `03_code/R/01_download_aiact.R` once.

| Session | Time | Do |
|---|---|---|
| A | 1 h | Read this lecture, then the primary text in §6 |
| B | 1 h | Read the core paper, Almada & Petit (2025) [S012] |
| C | 1 h | R exercise (§7), then a one-page note in `04_notes/concepts/M0_architecture.md` answering the self-test (§8) |

---

## 1. The single most important idea: the AI Act is product-safety law
The legal basis is **Art. 114 TFEU** (internal market harmonisation), with Art. 16 TFEU for the biometric and personal-data rules. Check the citations at the very top of the Regulation. The Act is built on the EU's **New Legislative Framework (NLF)**, the same machinery used for toys, lifts and medical devices:

> product → essential requirements → harmonised standards → conformity assessment → CE marking → market surveillance

Several consequences follow, and they recur in every later module:
- **Obligations attach to *roles in a supply chain*** (provider, importer, deployer), not to harms or victims. Individual rights are thin, with only Art. 85 (complaint) and Art. 86 (explanation).
- **Fundamental rights are protected *through* product requirements.** A risk to non-discrimination is handled like a risk of electric shock. This hybrid is exactly what Almada & Petit [S012] critique.
- **Technical standards do the real work.** Art. 40: complying with harmonised standards gives a *presumption of conformity*. The standards are written by CEN-CENELEC, private bodies, which raises a legitimacy question (Veale & Zuiderveen Borgesius [S013]).

## 2. An accountant's analogy (use it, then find where it breaks)
| Financial reporting | AI Act |
|---|---|
| Preparer / management | **Provider** (Art. 3(3), obligations in Art. 16) |
| User of the financial statements | **Deployer** (Art. 3(4), obligations in Art. 26) |
| Reporting framework (IFRS) | Requirements in Art. 8–15 + harmonised standards |
| Management assertion | **EU declaration of conformity** (Art. 47) |
| External audit | **Notified body** conformity assessment (Art. 43) |
| Enforcement (CONSOB/ESMA) | Market surveillance authorities (Art. 74) |

**Where it breaks, and why that is interesting:** for most Annex III high-risk systems (points 2–8: credit, employment, education…) the conformity assessment is **internal control under Annex VI, with no notified body** (Art. 43(2)). So in accounting terms, the regime is mostly *unaudited management assertions plus ex-post enforcement*. Keep this in mind for the assurance-market research ideas.

## 3. The risk-based architecture
Four tiers plus a separate track:
1. **Unacceptable**: prohibited (Art. 5)
2. **High-risk**: Art. 6 + Annex I (products) / Annex III (use cases); heavy requirements
3. **Transparency risk**: Art. 50 (chatbots, deepfakes)
4. **Minimal**: no new obligations (voluntary codes, Art. 95). Art. 4 AI literacy still applies to everyone.
5. **GPAI models**: Ch. V. These are regulated as *models*, not by use, which breaks the use-based logic above.

Recital 26 states the risk-based philosophy. **Analytical point:** the tiers are pre-defined *lists* of uses, not a case-by-case risk assessment. The only real filter is Art. 6(3). Ebers [S016] argues the Act is therefore not *truly* risk-based. Kaminski [S014] asks the prior question: what do we lose by framing AI harms as "risks" at all?

## 4. Maximum harmonisation
Recital 1: the Regulation prevents Member States "from imposing restrictions on the development, marketing and use of AI systems, unless explicitly authorised by this Regulation." This is the hook for M7. Italy's L. 132/2025 has to live inside that space. Any provision going beyond it is a candidate tension.

## 5. How to read the text (method)
- **180 recitals, 113 articles, 13 annexes, 68 definitions** (Art. 3).
- Recitals are **not binding** but are the CJEU's first interpretive aid. Read the recital *with* the article.
- Annexes can be amended by delegated acts (Art. 7 for Annex III; Art. 97 for the procedure). The lists move; the articles mostly don't.
- **English and Italian are equally authentic.** Where the English is ambiguous, `compare_lang()`.
- **Source grading (your intelligence habit, applied):** OJ text = A1. Commission guidelines = useful but non-binding (B2). Law-firm notes = advocacy (D). Peer-reviewed papers vary: **Ebers [S016] was commissioned by CCIA Europe, an industry association.** That doesn't make it wrong, but log it and read it accordingly.

## 6. Read (primary text, session A)
- **Art. 1** (subject matter): note the double objective in 1(1), internal market *and* protection of health, safety and fundamental rights.
- **Art. 113**: the application dates (compare with `00_plan/timeline.md`).
- **Table of contents**: chapter titles only.
- **Recitals 1–9**: purpose, legal basis, harmonisation, the NLF.
- **Recitals 26–27**: risk-based approach; the HLEG's 7 ethics principles.
- **Art. 43(2)** and **Annex VI** (one page): see for yourself that Annex III points 2–8 are self-assessed.

## 7. Read (paper, session B)
- **Core:** Almada, M. & Petit, N. (2025). The EU AI Act: Between the rock of product safety and the hard place of fundamental rights. *Common Market Law Review* 62(1), 85–120. doi:10.54648/COLA2025004. Open access on EUI Cadmus. [S012]
  *Read for:* the three lenses they use (pacing problem, regulatory lens, path dependence). Which one best fits an accountant's view of standard-setting?
- **If you have extra time:** Veale, M. & Zuiderveen Borgesius, F. (2021). Demystifying the Draft EU Artificial Intelligence Act. *Computer Law Review International* 22(4), 97–112. arXiv:2107.03721. [S013] It analyses the *2021 draft*, so check every article number against the final text. Its sections on standardisation and maximum harmonisation still hold.

## 8. R exercise (session C, textual and empirical)
```r
source("03_code/R/02_study_helpers.R")
library(dplyr)
# Where does the regulatory weight sit?
AI$EN |> filter(unit_type == "article") |>
  group_by(chapter_no, chapter) |> summarise(n_art = n(), words = sum(n_words)) |>
  mutate(share = round(words / sum(words), 2))
# Who carries the obligations? Mentions of each role, by chapter
term_map(c("provider", "deployer", "importer", "distributor")) |>
  left_join(select(filter(AI$EN, unit_type == "article"), unit_no, chapter_no), by = "unit_no") |>
  group_by(chapter_no) |> summarise(across(provider:distributor, sum))
```
Interpret: what share of the text is Chapter III (high-risk)? What is the provider-to-deployer mention ratio, and what does that tell you about *who the law is written for*?

## 9. Self-test (write answers in your note; I will critique)
1. In three sentences, why is the AI Act product-safety law, and what is one consequence for a person harmed by a biased credit model?
2. Where does the "conformity assessment ≈ audit" analogy fail, and what research question does that failure open?
3. Is the Act "risk-based"? Give one argument for and one against, citing [S016] or [S014].
4. Recital 1 vs Italy's national AI law: state the tension in one sentence, as a hypothesis to test in M7.
