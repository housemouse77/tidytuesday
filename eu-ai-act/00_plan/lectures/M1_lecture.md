# M1 Mini-lecture: what is an "AI system", and who is caught?

**Weeks 2–3 · 3 hours each**

| Week | Session A (1 h) | Session B (1 h) | Session C (1 h) |
|---|---|---|---|
| 2: definition | Lecture §1–3 + Art. 3(1), Recital 12 | Commission Guidelines on the AI system definition [S004], §2 | Meinel et al. [S017] intro + inference section; note on `04_notes/articles/art03_1.md` |
| 3: scope and roles | Lecture §4–6 + Art. 2, Art. 3(3)–(8), Art. 25 | Vogiatzoglou [S018] + Recital 24 | R exercise (§7) + self-test (§8) |

---

## 1. Why the definition is the gateway
Everything in the Act depends on Art. 3(1). If a system is not an "AI system", no tier applies: no prohibition, no high-risk regime, no Art. 50. For an empirical researcher this means **classification is the treatment assignment**. Any study of the Act's effects must first say which firms' systems are in scope, and that is often the weakest link.

## 2. Art. 3(1) broken into its elements
> "'AI system' means a machine-based system that is designed to operate with varying levels of autonomy and that may exhibit adaptiveness after deployment, and that, for explicit or implicit objectives, infers, from the input it receives, how to generate outputs such as predictions, content, recommendations, or decisions that can influence physical or virtual environments."

The Commission Guidelines [S004] split this into **seven elements**: (1) machine-based; (2) autonomy; (3) adaptiveness (note "*may*": it is not required); (4) objectives; (5) **inference**; (6) outputs; (7) influence on environments.

**The decisive element is (5), inference.** Recital 12 says the definition should distinguish AI from "simpler traditional software systems or programming approaches" and should not cover systems "based on the rules defined solely by natural persons to automatically execute operations."

## 3. The accounting hook: is a logistic-regression credit scorecard an AI system?
In §2.5, the part on systems *outside* the definition, the Guidelines describe categories excluded for limited inferential capacity: systems for improving mathematical optimisation, basic data processing, classical heuristics, and simple prediction systems. Commentary reads this as excluding some traditional statistical methods, and the logistic-regression example is contested. Search the Guidelines text for "logistic regression" and record the paragraph number in your note.

Why this matters to you:
- Annex III 5(b) makes **credit scoring of natural persons high-risk**. Many banks' scorecards are logit models.
- If they fall outside Art. 3(1), a large share of "high-risk" credit models may not be regulated at all, while a gradient-boosting model doing the same job is.
- **Research question candidate:** does the Act create an incentive to *choose simpler models* to stay out of scope? That would be classic regulatory arbitrage, testable with model-governance disclosures (Pillar 3, IRB documentation, ECB/Bank of Italy reports). Add it to `05_brainstorm/research_ideas.md`.

**Source discipline:** the Guidelines are **non-binding**. There are two documents: C(2025) 924 of 6 Feb 2025 (content approved) and C(2025) 5053 of 29 July 2025 (formal adoption). Use the later one and verify.

## 4. Scope: Art. 2, read as a set of switches
- **2(1), territorial reach:** EU providers, deployers established *or located* in the EU, and third-country providers and deployers **where the output is used in the Union** (2(1)(c)). This is the "Brussels effect" clause.
- **2(3), military, defence, national security:** excluded "regardless of the type of entity." Read with **Recital 24**: the exclusion covers systems used *exclusively* for these purposes. Dual use or later civilian use brings a system back in.
- **2(6), scientific research** solely for that purpose is excluded. This covers your own research tools.
- **2(8):** research and testing before placing on the market (real-world testing is not covered).
- **2(10):** purely personal, non-professional use.
- **2(12):** free and open-source components, *unless* high-risk, Art. 5 or Art. 50.

## 5. The intelligence lens: Art. 2(3)
Your career gives you an advantage here that most commentators lack.
- National security is a Member State competence (Art. 4(2) TEU), which is the stated rationale in Recital 24.
- But the CJEU construes national-security derogations **strictly** (e.g., the data-retention case law). Vogiatzoglou [S018] asks whether the AI Act exception leaves "room for manoeuvres."
- **Questions to work on:** Who decides that a use is *exclusively* national security? What happens when an intelligence service shares a tool with police (law enforcement is *in* scope, with Annex III 6 and the Art. 5(1)(h) rules)? Is a vendor selling the same OSINT platform to a service and to a bank's AML unit a provider for the second use only?

## 6. Roles: the value chain
- **Provider** (3(3)): develops, or has developed, and places on the market or puts into service **under its own name or trademark**, whether paid or free.
- **Deployer** (3(4)): uses an AI system **under its authority**, except for personal non-professional use.
- **Importer, distributor, authorised representative** (3(5)–(7)); **operator** (3(8)) is the umbrella term.
- **Art. 25, role switching:** a deployer or distributor *becomes the provider* of a high-risk system if it (a) puts its name or trademark on it, (b) makes a **substantial modification** (3(23)), or (c) changes the intended purpose so that the system becomes high-risk.

**Accounting relevance:** a bank that fine-tunes a vendor model, or an audit firm that rebrands a third-party analytics tool, may switch from deployer to provider and take on the full provider obligations.

## 7. R exercise (week 3)
```r
source("03_code/R/02_study_helpers.R")
art(2); recital(24); recital(12)
kwic("national security", type = c("article", "recital"))
kwic("exclusively")                 # where else does the Act use 'exclusively'?
kwic("substantial modification")
compare_lang("article", 25)         # how does the IT text render the role switches?
```
Interpret: how many times, and where, does "national security" appear? Is the carve-out reinforced or qualified elsewhere in the text?

## 8. Self-test (write answers in your note; I will critique)
1. Apply the seven elements to: (a) an Excel macro that flags journal entries over €10,000 posted on weekends; (b) a logit default model; (c) an isolation-forest anomaly detector for journal-entry testing. Which are AI systems, and why?
2. An Italian bank uses a US vendor's credit model, hosted in the US, to score applicants in Bologna. Which Art. 2(1) limb applies, and who is the provider?
3. A national intelligence service and a private bank both license the same entity-resolution tool. Map how the Act applies to each, using Art. 2(3) and Recital 24.
4. Write one research question that uses the definitional boundary (§3) as a source of variation.

## Readings
- [S004] European Commission, *Guidelines on the definition of an artificial intelligence system established by Regulation (EU) 2024/1689*. C(2025) 924 (6 Feb 2025) / C(2025) 5053 (29 July 2025). Non-binding.
- [S017] Meinel, P., Baum, K., Hermanns, H., Pöppelmann, E., Langer, M. & Lauber-Ronsberg, A. (2026). What are AI systems? Rethinking the core definition in the EU AI Act. *Computer Law & Security Review* 62, 106373.
- [S018] Vogiatzoglou, P. (2024, 9 Dec). The AI Act National Security Exception: room for manoeuvres? *Verfassungsblog*. doi:10.59704/292082becc7cc8e6. A short blog post, but well sourced.
- **Optional, for M3 later:** [S019] Mazzini, G. & Bagni, F. (2023). Considerations on the regulation of AI systems in the financial sector by the AI Act. *Frontiers in Artificial Intelligence*. doi:10.3389/frai.2023.1277544. Mazzini was a lead drafter of the Act at the Commission.
