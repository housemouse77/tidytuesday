# Learning plan: EU AI Act to research depth

**Strategy.** Read the operative text first and commentary second. For each module, write a one-page note in `04_notes/`
*before* reading secondary sources, then compare your note with the commentary. Article numbers refer to Reg. (EU) 2024/1689
as published in the OJ. Re-check any article the Digital Omnibus touches (see `timeline.md`).

Pace is set by you. Each module is roughly one focused week at about 5–6 h. Modules 0–3 are the core, and the rest can be reordered.

---

## M0. Architecture and orientation
- **Read:** Art. 1, 2, 3 (skim all 68 definitions), 113; the Table of Contents; Recitals 1–8.
- **Map:** the 13 chapters and 13 annexes on one page. The risk tiers are prohibited → high-risk → transparency → minimal, with GPAI as a separate track.
- **Self-test:** Explain to a colleague, in 3 minutes, why the Act is *product-safety law* (New Legislative Framework) rather than a rights statute like the GDPR, and what follows from that.

## M1. Scope, actors, definitions
- **Read:** Art. 2 (territorial reach; exclusions in 2(3) military/defence/**national security**, 2(6) research); Art. 3(1) "AI system" + the Commission Guidelines on the AI system definition (Feb 2025); Art. 3(3)–(8) operator roles; Art. 25 (when a deployer *becomes* a provider).
- **Intel lens:** How far does the 2(3) national-security carve-out reach, and how does it interact with Art. 4(2) TEU? Who decides what counts as "national security"?
- **Self-test:** A Milan bank fine-tunes a vendor's credit model and rebrands it. Which role(s) does it hold? Argue it under Art. 25.

## M2. Prohibitions and AI literacy (applicable since 2 Feb 2025)
- **Read:** Art. 5 in full, the Commission Guidelines on prohibited practices (Feb 2025), and Art. 4 (AI literacy).
- **Focus:** 5(1)(c) social scoring; 5(1)(d) predictive policing based on profiling; 5(1)(f) emotion recognition at work; 5(1)(h) with 5(2)–(7), the law-enforcement exceptions for real-time remote biometric identification.
- **Self-test:** For each Art. 5 prohibition, write one real-world case that is in scope and one that is just outside.

## M3. High-risk systems (the core of the Act)
- **Classification:** Art. 6 (two routes: Annex I products, Annex III use cases), the Art. 6(3) "no significant risk" filter, Art. 7 (Commission can amend Annex III), and Annex III in full.
- **Requirements (providers):** Art. 8–15. These cover risk management, data governance, technical documentation (Annex IV), logging, transparency to deployers, human oversight, and accuracy/robustness/cybersecurity.
- **Obligations:** Art. 16–22 (providers, QMS Art. 17), Art. 23–24 (importers/distributors), Art. 26 (deployers), Art. 27 (**fundamental rights impact assessment**).
- **Conformity:** Art. 40–49 (standards, common specs, conformity assessment, CE marking, registration in the EU database Art. 71), Annexes VI–VII.
- **Accounting lens:** Annex III 5(b) (creditworthiness/credit scoring of natural persons) and 5(c) (life/health insurance pricing); Annex III 4 (employment, HR analytics); Art. 17(4) and 26(5) (financial institutions can satisfy obligations through existing internal-governance rules); Art. 27(1) (FRIA explicitly covers 5(b)/(c) deployers).
- **Self-test:** Draft the Annex IV technical documentation table of contents for a loan-default model, and say which items an auditor could actually verify.

## M4. Transparency obligations
- **Read:** Art. 50 (chatbots, synthetic content marking, deepfakes, emotion recognition/biometric categorisation disclosure).
- **Self-test:** Does an AI-generated section of an annual report or ESG report trigger Art. 50(4)? Note the "human review / editorial responsibility" exception.

## M5. General-purpose AI models (applicable since 2 Aug 2025)
- **Read:** Art. 51–56, Annexes XI–XIII, the GPAI Code of Practice (July 2025), the Commission GPAI guidelines, and the training-data summary template.
- **Focus:** The systemic-risk presumption at 10^25 FLOPs (Art. 51(2)), the downstream-provider concept, and the copyright policy in Art. 53(1)(c).
- **Self-test:** An Italian SME builds an audit-analytics tool on top of a frontier model. What does it need from the model provider, and why?

## M6. Governance, enforcement, sandboxes
- **Read:** Art. 57–63 (sandboxes, real-world testing), Art. 64–70 (AI Office, Board, scientific panel, national authorities), Art. 72–73 (post-market monitoring, serious incidents), Art. 74 (market surveillance; **74(6)**: financial supervisors for financial institutions), Art. 85–86 (complaints, right to explanation), and Art. 99–101 (penalties: €35m/7%, €15m/3%, €7.5m/1%).
- **Self-test:** Trace an enforcement case from a complaint by a rejected loan applicant in Turin through to a fine. Which Italian authority acts at each step?

## M7. Italy
- **Read:** Legge 23 settembre 2025, n. 132 (national AI law) and its delegations to the Government; the designation of **AgID** (notifying authority) and **ACN** (market surveillance/inspection); the role of Banca d'Italia, CONSOB and IVASS for the financial sector; the Garante privacy's position.
- **Self-test:** Where does L. 132/2025 *add* to the AI Act (e.g., professions, labour, criminal provisions) and where does it only implement it? Is any part arguably in tension with maximum harmonisation?

## M8. Interfaces with other regimes (where research gaps live)
- GDPR (Art. 22 automated decisions, DPIA vs FRIA), DORA (ICT risk for financial entities), CRD/CRR and the EBA guidelines on loan origination, CSRD/ESRS (AI-risk disclosure), NIS2, the Product Liability Directive (2024/2853), and the Cyber Resilience Act.
- **Assurance:** ISO/IEC 42001 (AI management system), ISO/IEC 42006, ISAE 3000 engagements on AI, and the CEN-CENELEC JTC 21 harmonised standards. Who will audit AI, and is it a new market for audit firms?

## M9. The moving target
- Digital Omnibus on AI (Commission proposal, Nov 2025): delay and simplification of the high-risk timeline, plus changes to AI literacy and SME relief. **Check the current legislative status** and record it in `timeline.md`.
- Delegated and implementing acts, Commission guidelines on Art. 6 classification, and the harmonised standards publication pipeline.

---

## Deliverables that prove mastery
1. One-page notes for M0–M9 (`04_notes/`).
2. A 2-page "AI Act for accounting researchers" briefing (`06_output/`).
3. Three ranked research ideas with identification strategies and data (`05_brainstorm/research_ideas.md`).
4. A closed `questions_log.md`, with every question answered with a source ID or marked as genuinely unsettled. Unsettled questions are paper material.
