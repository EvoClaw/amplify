---
name: paper-writing
description: Use when and ONLY when the user explicitly requests paper writing and G4 (write-ready) gate has passed — handles LaTeX structure, senior-level writing, reference verification, and iterative refinement
---

<HARD-GATE>
Do NOT begin paper writing until user explicitly requests it AND G4 checklist is fully satisfied. If G4 has not passed, invoke `amplify:results-integration` first. No exceptions.
</HARD-GATE>

# Paper Writing (Phase 6)

## Overview

A paper is not a results dump — it is an argument. This skill enforces structured, senior-level academic writing with verified references, modular LaTeX, and adversarial self-review. Every section is drafted, reviewed, and revised before the paper is assembled.

## Step 1 — Confirm Venue and Template

```
"Your confirmed target is [venue]. Is this still correct?"
```

After confirmation:
1. Obtain the official LaTeX template for the venue
2. Confirm page limit, format requirements, reference style (e.g., numbered vs. author-year)
3. Record in `research-anchor.yaml` field `venue_confirmed_phase6`

Do not proceed until venue is locked.

## Step 2 — LaTeX Modular Structure

<IRON-LAW>
EVERY SECTION MUST BE IN ITS OWN .tex FILE. Writing the entire paper in a single file is FORBIDDEN. The modular structure enables targeted iteration on individual sections without risking regressions in other sections.
</IRON-LAW>

Set up the project with one file per concern:

```
paper/
├── main.tex              (only \input{} references — no prose here)
├── preamble.tex          (packages, macros, theorem environments)
├── sections/
│   ├── abstract.tex
│   ├── introduction.tex
│   ├── related-work.tex
│   ├── method.tex
│   ├── experiments.tex
│   ├── results.tex
│   ├── discussion.tex
│   └── conclusion.tex
├── figures/
├── tables/
├── references.bib
└── supplementary/
```

Each section is an independent file. Modify one section without touching others. `main.tex` contains only `\input{}` commands and document-level structure.

**Before writing any section:** Verify this directory structure exists and `main.tex` uses `\input{}` for each section. If it doesn't, set it up first.

## Step 3 — Section-Level Outline

Before writing any prose, produce an outline for each section:

- **Core argument** (1–2 sentences): what this section must establish
- **Paragraph plan**: ordered list of topic sentences
- **Figure/table references**: which visuals appear in this section
- **Estimated word count**: calibrated to venue page limit

Present the full outline to the user. Get explicit approval before writing begins.

## Step 4 — Writing Standards

Inject this system prompt into the writing context for every section:

> You are a senior professor in [domain] with 50+ publications at top venues. Write with:
> - Flowing prose — NOT bullet-point lists converted to sentences
> - Clear topic sentences and logical transitions between paragraphs
> - Precise, consistent terminology throughout the paper
> - Quantitative claims backed by numbers — not "significantly better" without a number
> - Honest limitations discussion — acknowledge what doesn't work
> - Word count matching [venue] conventions for each section
>
> **FORBIDDEN:**
> - "In this paper, we propose a novel..." cliché openings
> - "To the best of our knowledge" unless independently verified
> - "Groundbreaking", "revolutionary", and similar hype words
> - Omitting negative results or known limitations
> - Listing related work without positioning against or comparing to our approach

## Step 4b — Minimum Quality Standards

<IRON-LAW>
EVERY SECTION MUST MEET MINIMUM STANDARDS. A paper with thin sections, few references, and no figures will be desk-rejected. These minimums are calibrated for a standard conference paper. For journals, multiply by 1.5–2×.
</IRON-LAW>

### Minimum Section Word Counts (conference paper)

| Section | Minimum Words | Minimum Citations | Notes |
|---------|:------------:|:-----------------:|-------|
| Abstract | 150 | 0 | 150–250 words; state problem, method, key result, significance |
| Introduction | 600 | 10 | Must motivate the problem, survey context, state contributions |
| Related Work | 500 | 10 | Must POSITION against prior work, not just list it |
| Method | 600 | 3 | Must be self-contained; a reader should reproduce from this section |
| Experiments / Results | 800 | 3 | Must include experimental setup, main results, ablation, analysis |
| Discussion | 400 | 3 | Must address limitations honestly, broader impact, future directions |
| Conclusion | 200 | 0 | Summarize contributions, restate key finding |

**Total paper:** at least 3,300 words of body text (excluding references, appendix).

For **journal papers**, target 6,000+ words.

### Minimum Reference Count

| Venue Type | Minimum References |
|-----------|:-----------------:|
| Workshop paper | 10 |
| Conference paper | 20 |
| Journal paper | 35 |

References must include:
- Foundational works in the field (not only recent papers)
- Directly competing methods (all baselines should be cited)
- The dataset source paper(s)
- Methodological inspirations cited in the method section

### Minimum Figure and Table Count

| Content | Minimum | Examples |
|---------|:-------:|---------|
| Figures | 3 | Main comparison plot, ablation visualization, qualitative examples or analysis figure |
| Tables | 2 | Main quantitative results, ablation results or efficiency comparison |

**Every figure and table must be referenced in the text.** Orphaned figures (present but never discussed) are worse than no figure at all.

### Section Length Self-Check

After writing each section, perform this check:

```
Section: [name]
Word count: [N] (minimum: [M])
Citation count: [N] (minimum: [M])
Figures referenced: [list]
Tables referenced: [list]
Status: [PASS / BELOW MINIMUM — expand before proceeding]
```

If ANY section is below minimum, expand it before moving to the next section. Do NOT defer "I'll expand it later" — later never comes.

## Step 5 — Reference Verification

```
IRON LAW: EVERY CITATION MUST BE VERIFIED. NO EXCEPTIONS.
```

<IMPORTANT>
AI agents are prone to fabricating references — generating plausible-sounding but non-existent papers. This is a known failure mode and constitutes academic fraud. The verification steps below are MANDATORY, not optional.
</IMPORTANT>

### 5a. Autonomous verification (try first)

For each reference in `references.bib`:

1. **Exists** — search for the exact title in quotes via web search. Cross-check against Google Scholar, DBLP, Semantic Scholar, or the venue's official proceedings page.
2. **Metadata** — verify authors, title, year, venue match the real publication. If a BibTeX entry is available online, use it directly instead of writing it manually.
3. **Content** — if the paper was already downloaded in `docs/02_literature/papers/` during Phase 1, re-read the relevant section to confirm the cited claim. If not downloaded, try to access the paper now (same retrieval strategy as Phase 1 Step 2).

Classify each reference:
- `[VERIFIED]` — paper exists, metadata correct, cited claim confirmed against full text
- `[METADATA VERIFIED]` — paper exists and metadata correct, but cited claim not independently confirmed (no full text access)
- `[UNVERIFIABLE]` — cannot confirm existence — **likely fabricated, remove or flag**

### 5b. User assistance (only for unresolved)

Present the verification report:

```
Reference verification report:
  [VERIFIED]: K references ✅
  [METADATA VERIFIED]: M references (exist but claim not confirmed against full text)
  [UNVERIFIABLE]: J references ❌ — likely fabricated or incorrect

Unverifiable references:
  1. \cite{key1} — "Title..." — could not find this paper anywhere
  2. \cite{key2} — "Title..." — found similar but metadata doesn't match

Action needed:
  - I will REMOVE unverifiable references and rewrite affected sentences
  - For [METADATA VERIFIED] refs: no action needed unless you want to verify claims
  - If any removed reference was real, please provide the correct BibTeX
```

**Never keep an unverifiable reference in the paper.** Remove it proactively and rewrite the sentence to either cite a verified alternative or remove the claim.

## Step 6 — Multi-Round Iteration

### Per-Section Cycle

For each section, execute this loop:

1. **Draft** — write following Step 4 standards, in the section's own `.tex` file
2. **Length and citation check** — verify word count ≥ minimum, citation count ≥ minimum (from Step 4b table). If below, expand BEFORE continuing.
3. **Self-review** — check against claim-evidence alignment, writing standards, and section outline
4. **Cross-review** — re-read as a hostile reviewer: what would you attack?
5. **User review** — present section to user, incorporate feedback
6. **Revise** — update and re-verify

**Present each section to the user individually.** Do NOT write all sections silently and present the full paper at once. Section-by-section review catches problems early.

### Full-Paper Assembly

After all sections are drafted and individually approved:

**a) Consistency check:**
- Terminology consistent across all sections
- Symbols and notation uniform (no redefinitions)
- Figure/table numbers sequential and correctly cross-referenced
- No dangling references or undefined labels

**b) Word count / page limit check:**
- Compile and verify total page count against venue limit
- If over limit, identify sections to tighten (never cut evidence — cut exposition)

**c) Figure and table quality audit:**

**REQUIRED SUB-SKILL:** Invoke `amplify:figure-quality-standards` and run the per-figure checklist on every figure and table in the paper.

**Figure image files** (`paper/figures/`):
- [ ] Venue style profile applied (CNS / CS / IEEE / etc. from `src/plot_style.py`)
- [ ] Readable at final print size (scale to venue column width)
- [ ] No figure titles on the image (title goes in LaTeX `\caption{}`)
- [ ] Panel labels present for multi-panel figures (**a**, **b**, **c**)
- [ ] Axis labels with units present
- [ ] Color consistent across all figures (same method = same color)
- [ ] Colorblind-safe (distinguishable in grayscale)
- [ ] Error bars / variance shown
- [ ] Vector format (PDF/SVG, not PNG for line plots)

**LaTeX figure integration** (in `.tex` files):
- [ ] `\caption{}` is self-contained (understandable without body text)
- [ ] `\caption{}` describes each panel for multi-panel figures
- [ ] `\caption{}` includes key takeaway and statistical notes
- [ ] `\label{fig:xxx}` present and descriptive
- [ ] `\includegraphics` width matches venue column width
- [ ] Every figure is `\ref{}`'d in body text — no orphaned figures

**Tables** (in `.tex` files):
- [ ] `booktabs` style (no vertical lines)
- [ ] Best result bolded, second best underlined (if ≥4 methods)
- [ ] All values include mean ± std
- [ ] Decimal-aligned, consistent decimal places
- [ ] `\caption{}` self-contained with notation explanation

If ANY figure or table fails, fix it before proceeding to the review panel.

### Multi-Agent Review Panel

After assembly and consistency check, dispatch **three independent reviewer subagents** using the Task tool. Call all three in the **same message** so they run in parallel.

**How to invoke:** Read each section file (`paper/sections/*.tex`) and concatenate them into a single paper text. Include figure/table descriptions. Pass this as context in each Task prompt.

**Dispatch all three simultaneously:**

```
Call Task tool with:
  description: "Proofread paper draft"
  prompt: |
    You are a professional academic proofreader. Review the following paper draft.

    [Paste concatenated paper text here]

    Review for:
    - Grammar, spelling, punctuation
    - Sentence flow and readability
    - Consistency of terminology, notation, abbreviations
    - Proper use of tense (present for claims, past for experiments)
    - Figure/table caption quality (self-contained? descriptive?)
    - Redundancy across sections (same sentence appearing twice)

    Return: a list of issues, each with:
    - Location (section name + paragraph number)
    - Issue type: typo / style / clarity / structural
    - Current text (quote the problematic text)
    - Suggested fix
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Domain expert review of paper"
  prompt: |
    You are a senior researcher in [domain] reviewing a paper draft before submission to [venue].

    [Paste concatenated paper text here]

    Also read the evaluation protocol: [paste evaluation-protocol.yaml content]
    And the baseline results: [paste docs/05_execution/baseline-results.md content]

    Review for:
    - Are the claims supported by the evidence presented?
    - Are there missing experiments that a reviewer would request?
    - Is the method description sufficient to reproduce?
    - Are baselines fairly compared? Any missing obvious baselines?
    - Is the related work comprehensive and well-positioned?
    - Are limitations honestly discussed?

    Return a structured report with issues classified as:
      CRITICAL: must fix before submission (e.g., missing key experiment, unsupported claim)
      IMPORTANT: should fix (e.g., weak baseline comparison, thin discussion)
      MINOR: nice to fix (e.g., could add a figure for clarity)

    For CRITICAL issues requiring new experiments, explicitly state:
      "EXPERIMENT NEEDED: [description of what experiment to run and why]"
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Adversarial reviewer simulation"
  prompt: |
    You are Reviewer #2 at [target venue], known for thorough and critical reviews.
    Your job is to find every weakness. Be specific, harsh, but fair.

    [Paste concatenated paper text here]

    Write a full review:
    1. Summary (2-3 sentences)
    2. Strengths (3-5 points)
    3. Weaknesses (5-8 points, be specific)
    4. Questions for the authors (3-5 specific questions)
    5. Missing references (any important work not cited?)
    6. Overall recommendation: accept / weak accept / borderline / weak reject / reject
    7. Confidence: high / medium / low

    For each weakness, classify:
      [FATAL] — paper should not be accepted without addressing this
      [MAJOR] — significant weakness, likely leads to rejection if not addressed
      [MINOR] — should be fixed but not a dealbreaker
  subagent_type: "generalPurpose"
```

### Processing Review Panel Results

After all three subagents return, synthesize their feedback:

1. **Merge and deduplicate** — combine issues from all three reviewers
2. **Prioritize** — rank by severity: FATAL > CRITICAL > MAJOR > IMPORTANT > MINOR
3. **Classify required actions:**

| Action Type | Trigger | What to do |
|-------------|---------|-----------|
| Text fix | Proofreader or style issues | Fix directly in the relevant `.tex` file |
| Content expansion | "Section too thin" / "claim unsupported" | Expand the section, add evidence |
| **New experiment needed** | Domain critic or adversarial reviewer says "EXPERIMENT NEEDED" or flags missing analysis | → **Trigger Return to Phase 4** (see below) |
| New figure/table needed | "Would benefit from visualization of X" | Generate and add |
| Reference additions | "Missing important work by X" | Search, verify, and add |

4. **Present consolidated review to user:**

```
Multi-Agent Review Panel Results:
═══════════════════════════════

Proofreader: N issues (K typos, M style, J clarity)
Domain Critic: N issues (K critical, M important, J minor)
Adversarial Reviewer: recommendation = [X], confidence = [Y]

FATAL / CRITICAL issues requiring action:
  1. [Source: adversarial reviewer] ...
  2. [Source: domain critic] ...

Issues requiring new experiments (if any):
  1. [EXPERIMENT NEEDED] ...

Proposed action plan:
  - Text fixes: N items (can fix immediately)
  - Content expansion: M items
  - New experiments: J items (requires return to Phase 4)
  - New figures/tables: K items

Shall I proceed with fixes? If new experiments are needed,
I will return to Phase 4 for those, then come back to update the paper.
```

### Return to Phase 4 (Experiment Supplement)

<IMPORTANT>
If the review panel (or the user, at any point during paper writing) identifies that **new experiments are needed**, this is a formal return to Phase 4. This is NORMAL and EXPECTED — it happens in real research. Do NOT try to "write around" missing experiments.
</IMPORTANT>

**When to trigger:**
- Domain critic flags "EXPERIMENT NEEDED"
- Adversarial reviewer flags a FATAL weakness that requires new evidence
- User requests additional experiments during section review
- Writing reveals a claim that has no supporting experiment

**Return procedure:**

1. **Document what's needed** — create `docs/05_execution/supplement-request.md`:
   ```
   Supplement Request (from Phase 6 review)
   =========================================
   Requested by: [review panel / user / writing process]
   
   Experiments to add:
   1. [Description] — why needed: [reason from reviewer]
   2. [Description] — why needed: [reason from reviewer]
   
   Impact on paper:
   - Sections affected: [list]
   - New figures/tables expected: [list]
   
   Estimated scope: [small: 1-2 runs / medium: new baseline + comparison / large: new analysis track]
   ```

2. **Get user approval** — "The review panel identified N experiments that would strengthen the paper. Here's what's needed and why. Shall I run these?"

3. **Execute supplements** — return to `experiment-execution` Stage D/E for the specific additions. Follow ALL Phase 4 discipline (seeds, completion, etc.)

4. **Update results integration** — incorporate new results into `docs/06_report/`

5. **Resume paper writing** — update affected sections, re-run the review panel on modified sections only

**Guard against scope creep:** Each return should be scoped and approved by the user. Do NOT turn a "add one ablation" into a full re-do of Phase 4.

### Final Steps After Review

**c) Resolve all non-experiment issues** — fix text, expand sections, add references

**d) Re-run review on modified sections** — if substantial changes were made, dispatch the domain critic and adversarial reviewer again on the modified sections only (not the full paper again, unless the user requests it)

**e) Final user confirmation:**
Present the complete paper for final approval. Do not submit or declare complete without explicit user sign-off.

## Step 7 — Reproducibility Packager (Required Before Final Completion)

```
IRON LAW: A PAPER IS NOT COMPLETE WITHOUT A REPRODUCIBILITY PACKAGE.
```

After manuscript approval, produce a complete reproducibility bundle:

```
repro/
├── README.md
├── environment.yml
├── download_data.sh
├── run_all.sh
├── configs/
├── scripts/
└── expected_results/
```

Requirements:
1. `README.md` explains exact reproduction steps, expected runtime, and hardware assumptions
2. `environment.yml` (or equivalent lock file) pins dependencies
3. `download_data.sh` fetches data deterministically and verifies checksums when available
4. `run_all.sh` reproduces the key paper tables/figures end-to-end
5. `configs/` stores exact settings used for reported experiments
6. `scripts/` contains all preprocessing/training/evaluation scripts
7. `expected_results/` documents expected metric ranges and tolerance bands

If any item is missing, the project remains in "draft complete" state, not "research complete."

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "The introduction is good enough" | Good enough for a workshop, not [venue]. Revise to venue standard. |
| "References are probably correct" | Probably ≠ verified. Check each one. A single fabricated citation is retraction-level. |
| "Reviewer attack simulation is overkill" | Anticipating attacks saves a rejection cycle. Three hours now vs. three months later. |
| "The related work section can be brief" | Shallow related work signals ignorance of the field. Position thoroughly. |
| "Negative results will weaken the paper" | Omitting them is dishonest. Discussing them honestly builds reviewer trust. |
| "We can fix formatting issues later" | Formatting errors signal carelessness. Reviewers notice. Fix now. |

## Red Flags — STOP

- Beginning to write without G4 gate passed
- Citing a paper without verifying it exists
- Skipping the section outline and writing directly
- Using bullet-point lists as paper prose
- Ignoring page limits until the final draft
- Proceeding past reviewer attack simulation without resolving fatal criticisms
- Declaring the paper "done" without user sign-off

## Final Quality Gate

Before declaring the paper draft complete, verify ALL of the following:

- [ ] Every section is in its own `.tex` file (modular structure)
- [ ] Total body word count ≥ 3,300 (conference) or ≥ 6,000 (journal)
- [ ] Introduction word count ≥ 600, with ≥ 10 citations
- [ ] Related Work word count ≥ 500, with ≥ 10 citations
- [ ] Discussion word count ≥ 400, covering limitations and future work
- [ ] Total references ≥ 20 (conference) or ≥ 35 (journal)
- [ ] At least 3 figures included and referenced in text
- [ ] At least 2 tables included and referenced in text
- [ ] Every `\cite{}` has a matching verified `references.bib` entry
- [ ] No `[NEED VERIFICATION]` markers remain
- [ ] Reviewer attack simulation completed, fatal issues resolved
- [ ] User approved each section individually
- [ ] User approved the assembled full paper

If ANY check fails, fix it before proceeding.

## Checklist

1. Confirm venue and obtain template
2. Set up modular LaTeX structure (one `.tex` per section)
3. Produce section-level outline with estimated word counts → user approval
4. Write each section with senior-level standards (Step 4 + Step 4b minimums)
5. Verify every reference independently
6. Per-section review cycle (draft → length check → self → cross → user → revise)
7. Full-paper assembly: consistency, page limit, reviewer simulation
8. Final quality gate: all minimums met, all sections individually approved
9. Final user confirmation on manuscript
10. Build and validate reproducibility package (`repro/`)
11. Final user confirmation on reproducibility package → paper complete
