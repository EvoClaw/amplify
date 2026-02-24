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

## On-Demand Literature Search (Active Throughout Phase 6)

During paper writing — especially Related Work, Introduction, and Discussion — you will need additional references. **Search immediately when needed.** Do not write "studies have shown..." without a real citation. Add new papers to `docs/02_literature/paper-list.md` with tag `[Found during Phase 6]`.

**If search fails or returns insufficient results:**
1. Try alternative search terms (synonyms, broader/narrower scope, different field terminology)
2. If still insufficient → note what was searched and what's missing in `docs/02_literature/paper-list.md`
3. Ask the user: "I need a citation for [claim] but couldn't find a suitable reference. Can you suggest one?"
4. Do NOT fabricate citations — use `\textcolor{red}{[CITATION NEEDED]}` as a placeholder and flag it in the writing review

## Step 1 — Confirm Venue and Template

```
"Your confirmed target is [venue]. Is this still correct?"
```

After confirmation:
1. Obtain the official LaTeX template for the venue
2. Confirm page limit, format requirements, reference style (e.g., numbered vs. author-year)
3. Record in `research-anchor.yaml` field `venue_confirmed_phase6`

Do not proceed until venue is locked.

## Step 1b — Generate Dynamic Expert Persona

<IRON-LAW>
The expert persona is NOT a fixed template. It is DYNAMICALLY GENERATED from the project's `research-anchor.yaml` for every project. A generic "You are a senior professor" is insufficient — the persona must be specific enough that someone reading it would know exactly which researcher it describes.
</IRON-LAW>

**Read `docs/01_intake/research-anchor.yaml`** and generate the persona using this template:

```
EXPERT PERSONA (auto-generated for this project):
===
You are a tenured professor at a top research university, specializing
in [subdomain] within [domain]. You have [20+] years of active research
experience, with a focus on [specific expertise derived from reviewer_focus
fields in research-anchor.yaml].

You have published extensively in top venues in this field, including
[GENERATE: 4-6 specific journal/conference names that are realistic
top venues for this domain+subdomain — e.g., if bioinformatics+single-cell:
"Nature Methods, Genome Biology, Cell Systems, Bioinformatics, and
Nucleic Acids Research"; if ML+few-shot: "NeurIPS, ICML, ICLR, JMLR,
and TPAMI"]. Your most recent work focuses on [value_proposition area
from research-anchor.yaml].

You are now writing a paper for [target_venue from research-anchor.yaml].
You have published in this venue before and know its standards intimately.
Write as if this is YOUR paper — your name and reputation are on it.
A sloppy paper embarrasses you personally.

Your specific expertise relevant to this paper:
- [reviewer_focus[0] from research-anchor.yaml]
- [reviewer_focus[1] from research-anchor.yaml]
- [reviewer_focus[2] from research-anchor.yaml]
===
```

**How to fill the template:**

| Field | Source | Example |
|-------|--------|---------|
| `[domain]` | `research-anchor.yaml → domain` | "bioinformatics" |
| `[subdomain]` | `research-anchor.yaml → subdomain` | "single-cell genomics" |
| `[specific expertise]` | Derived from `reviewer_focus` list | "cell type annotation, batch effect correction, and trajectory analysis" |
| `[top venues]` | **Generate based on domain+subdomain** — use your knowledge of the field to list 4-6 real, prestigious venues | "Nature Methods, Genome Biology, Cell Systems" |
| `[target_venue]` | `research-anchor.yaml → target_venue.primary` | "Communications Biology" |
| `[value_proposition area]` | `research-anchor.yaml → value_proposition` | "reproducible discovery-oriented analysis of single-cell data" |

**Save the generated persona** as a string — it will be reused in:
- Step 4 (writing each section)
- Phase B (all three multi-agent polishing prompts)
- Full-paper review panel

**Example of a well-generated persona:**

> You are a tenured professor at a top research university, specializing in single-cell genomics within bioinformatics. You have 20+ years of active research experience, with a focus on mechanism chains and biological interpretation, alternative hypothesis exclusion including batch effects and sequencing depth confounds, and analysis sufficiency and reproducibility.
>
> You have published extensively in top venues in this field, including Nature Methods, Genome Biology, Cell Systems, Bioinformatics, Nucleic Acids Research, and Communications Biology. Your most recent work focuses on reproducible discovery-oriented analysis of public single-cell datasets.
>
> You are now writing a paper for Communications Biology. You have published in this venue before and know its standards intimately. Write as if this is YOUR paper — your name and reputation are on it. A sloppy paper embarrasses you personally.

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
│   ├── theoretical.tex   (if project has theoretical analysis)
│   ├── experiments.tex
│   ├── results.tex
│   ├── discussion.tex
│   └── conclusion.tex
├── figures/
├── tables/
├── references.bib
└── supplementary/
    └── proofs.tex        (full proof details if space-limited in main paper)
```

Each section is an independent file. Modify one section without touching others. `main.tex` contains only `\input{}` commands and document-level structure.

**Before writing any section:** Verify this directory structure exists and `main.tex` uses `\input{}` for each section. If it doesn't, set it up first.

### Theorem/Proof Formatting (if project includes theoretical analysis)

If the project has theoretical claims (from `docs/03_plan/theoretical-analysis-plan.md` or `docs/05_execution/theoretical-analysis.md`), ensure `preamble.tex` includes proper environments:

```latex
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{definition}{Definition}[section]
\newtheorem{remark}{Remark}[section]
```

**Writing guidelines for theoretical sections:**

| Element | Format | Example |
|---------|--------|---------|
| Theorem statement | `\begin{theorem}[Name]...\end{theorem}` | Theorem 1 (Convergence Rate) |
| Proof | `\begin{proof}...\end{proof}` | Full derivation with clear steps |
| Assumptions | Numbered list before the theorem | Assumption 1: f is L-smooth |
| Proof sketch in main paper | Brief outline with "Full proof in Appendix X" | Key insight + reference |
| Full proof in supplementary | Complete, self-contained derivation | All details, no hand-waving |

**Common pitfalls to avoid:**
- Stating a theorem without proof (unless citing another paper)
- Saying "it can be shown that..." without showing it anywhere
- Assumptions that are unrealistic for the practical setting
- Mixing informal intuition with formal claims — keep them separate

## Step 3 — Section-Level Outline (starting from Phase 5 Argument Blueprint)

<IRON-LAW>
### THE ARGUMENT BLUEPRINT IS THE STARTING POINT — NOT A STRAITJACKET

The argument blueprint (`docs/06_integration/argument-blueprint.md`) from Phase 5 provides a solid foundation: the core claims, evidence chains, interpretations, and narrative arc that were stress-tested by the multi-agent panel.

**Phase 6 starts from this blueprint**, but writing is a creative process that naturally generates new insights. It is NORMAL and ENCOURAGED to:

- **Refine** claims to be more precise as you write them out in full
- **Deepen** interpretations — especially in Discussion, where reflection often produces better framing than initial planning
- **Discover** better connections to prior work while writing Related Work or Introduction
- **Sharpen** the narrative arc — sometimes the best "aha moment" only crystallizes after you've written Results and see the full picture
- **Add** a new insight in Discussion that emerged from the writing process itself

What Phase 6 should NOT do:
- **Start from scratch** with no blueprint — if no blueprint exists, return to Phase 5
- **Contradict** the blueprint's evidence base (the data is what it is)
- **Fabricate** new results that weren't in the experiment logs (see Step 3b)
- **Silently abandon** the blueprint's core argument without noting the change

When writing generates a substantial improvement to the story, update `argument-blueprint.md` to keep it in sync. This is healthy iteration, not a violation.
</IRON-LAW>

**Read `docs/06_integration/argument-blueprint.md`** and produce a section-by-section writing plan:

For each section:
- **Core argument** (1–2 sentences): what this section must establish — use the blueprint as starting point, refine as needed
- **Paragraph plan**: ordered list of topic sentences — grounded in the blueprint's claim-evidence structure
- **Interpretations to include**: from the blueprint's INTERPRETATION field — these are the initial interpretations; writing may deepen them
- **Figure/table references**: which visuals appear in this section
- **Estimated word count**: calibrated to venue page limit

Present the full outline to the user. Get explicit approval before writing begins.

## Step 3b — Proactive Fidelity and the Interpretation/Fabrication Boundary

<IRON-LAW>
### THE FIDELITY RULE: AUTOMATIC — NOT USER-POLICED

The user should NEVER need to ask "did you make things up?" Fidelity to experimental results must be AUTOMATICALLY verified by the system, not manually policed by the user.

**Before writing EACH section**, perform this automatic check:
1. Read `docs/05_execution/experiment-log.md` and `docs/05_execution/run_results.json` (or equivalent results files)
2. Read `docs/06_integration/claim-evidence-mapping.md`
3. For EVERY quantitative claim in the section, verify it traces to a specific logged result
4. For EVERY methodological statement ("we did X"), verify X actually appears in the scripts/logs

**After writing EACH section**, perform this automatic self-audit:
```
FIDELITY AUDIT for [section name]:
- Quantitative claims: [N] total, [N] verified against logs ✅, [N] unverifiable ❌
- Method descriptions: [N] total, [N] verified against scripts ✅
- Interpretive claims: [N] total (these are LEGITIMATE — see below)
- Status: PASS / FAIL
```

If ANY quantitative claim or method description is unverifiable, FIX IT before presenting to user. Do NOT present the section with a disclaimer like "please check if this is correct."
</IRON-LAW>

<IRON-LAW>
### INTERPRETATION vs. FABRICATION — Know the Difference

Scientific writing REQUIRES interpretation. Connecting results to prior knowledge, proposing mechanisms, drawing insights — this is the CORE of a research paper, not fabrication. The user should NOT feel anxious about whether legitimate interpretations are "made up."

**LEGITIMATE (encouraged — this is what makes a paper publishable):**
- Interpreting results in light of prior work: "The high ARI suggests the partition is robust, consistent with [ref]'s finding that..."
- Proposing mechanisms grounded in data: "The marker profile of subcluster 3 (high S100A8, low CD14) is consistent with an intermediate monocyte state..."
- Drawing connections: "This pattern mirrors what [ref] observed in a different tissue, suggesting a conserved mechanism"
- Offering qualified speculation in Discussion: "One possible explanation is that... though this would require validation by..."

**FABRICATION (forbidden — this is scientific misconduct):**
- Claiming experiments that were not run: "We performed GO enrichment analysis..." (when no GO analysis was done)
- Reporting numbers not in the logs: "The accuracy was 0.95" (when the log shows 0.87)
- Inventing references: Citing papers that don't exist
- Describing analysis steps that weren't executed: "We removed doublets using DoubletFinder" (when no doublet removal was done)
- Presenting speculation as established fact: "This proves that mechanism X causes Y" (when the data only shows correlation)

**The test:** Can this claim be traced to (a) a specific experimental result, (b) a cited prior work, or (c) a clearly marked interpretation of (a) or (b)? If yes → legitimate. If none of the three → potential fabrication, remove or rewrite.

Do NOT suppress legitimate interpretation out of fear of fabrication. A paper that only states raw numbers without interpretation is a course report, not a research paper.
</IRON-LAW>

## Step 4 — Writing Standards

<IRON-LAW>
### THE FUNDAMENTAL DISTINCTION: RESEARCH PAPER vs. COURSE REPORT

A **course report** describes what you did: "We applied method X, we got result Y, we used tool Z."
A **research paper** argues why it matters: "Result Y reveals that mechanism Z operates differently than assumed, because evidence W contradicts the prevailing model."

Every paragraph must advance an ARGUMENT, not just describe a PROCEDURE.

**Report writing** (FORBIDDEN):
> "We applied Leiden clustering with resolution 0.5 and obtained 7 clusters. We then annotated them using canonical markers."

**Research writing** (REQUIRED):
> "Graph-based clustering resolved seven transcriptionally distinct populations, each defined by a coherent marker program. The separation of CD14+ and FCGR3A+ monocytes at this resolution is consistent with the classical/non-classical monocyte dichotomy first described by [ref], suggesting that even this modest dataset captures functionally relevant heterogeneity within the myeloid compartment."

The difference: the second version connects the result to biological meaning, cites prior knowledge, and makes an interpretive claim. The first just states what happened.
</IRON-LAW>

### Writing Persona

**Use the dynamic persona generated in Step 1b.** Inject it into the writing context for every section, combined with these writing instructions:

> [INSERT DYNAMIC PERSONA FROM STEP 1b HERE]
>
> **Your writing voice:**
> - You have DEEP domain knowledge and it shows in every paragraph — you connect results to mechanisms in your field, cite the right prior work at the right moment, and anticipate what your peers are thinking
> - You write with AUTHORITY — not "we believe" or "it seems" but "these data demonstrate" or "this pattern is consistent with"
> - You write with INSIGHT — every paragraph contains at least one non-obvious observation, interpretation, or connection that a student or junior researcher would miss
> - You contextualize every finding — "This is interesting because..." / "This contrasts with..." / "This extends the observation by [ref] that..."
> - Your prose FLOWS — each paragraph follows logically from the previous one; transitions are organic, not mechanical ("Next, we..." is mechanical; leading with the scientific question is organic)
>
> **The quality bar:** After writing each section, ask yourself: "Would I be comfortable presenting this at a Gordon Conference / keystone symposium in my field?" If the answer is no — if a colleague would think "this reads like a student report" — rewrite before showing the user.
>
> **FORBIDDEN:**
> - Descriptive "we did X, then Y, then Z" writing without interpretation
> - "In this paper, we propose a novel..." cliché openings
> - "To the best of our knowledge" unless independently verified
> - "Groundbreaking", "revolutionary", and similar hype words
> - Omitting negative results or known limitations
> - Listing related work without positioning against or comparing to our approach
> - Generic statements that could apply to any paper ("This is an important problem")
> - Results sections that only state numbers without explaining what they mean in the context of the field

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

**"Close enough" is NOT a pass.** If the minimum is 600 words and the section has 560, it is a FAIL. Expand to meet the minimum before presenting to the user. Do NOT report "略低于 minimum，可接受" — it is NOT acceptable. The minimums exist for a reason: thin sections get desk-rejected.

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

## Step 6 — Multi-Round Iteration with Automated Multi-Agent Polishing

<IRON-LAW>
## ONE SECTION PER TURN — but the user sees the POLISHED version

Write one section → run automated multi-agent polishing (3 agents, at least 2 rounds) → present the polished version to user → wait for feedback → next section.

The user should NOT see first drafts. The multi-agent polishing is AUTOMATED — it happens within a single turn before presenting to the user. Do NOT ask the user to review raw drafts.

Do NOT write 2+ sections in one response.
</IRON-LAW>

### Per-Section Cycle

For each section, execute ALL of the following steps **within one turn** before presenting to the user:

#### Phase A: Draft (you do this)

1. **Write the initial draft** following Step 4 standards, in the section's own `.tex` file
2. **Length and citation check** — verify minimums from Step 4b. If below, expand first.

#### Phase B: Automated Multi-Agent Polishing (3 agents, run in parallel)

The argument blueprint from Phase 5 is the foundation, but writing naturally deepens and refines the story. Phase 6 polishing agents serve TWO purposes:

1. **Writing quality**: Is the prose clear, authoritative, well-structured? Does it read like a senior researcher wrote it?
2. **Content refinement**: Do polishing agents spot opportunities to sharpen an interpretation, deepen a connection to prior work, or improve the narrative flow? These refinements are WELCOME — they make the paper better.

What polishing agents should NOT do:
- Invent claims with no evidence basis
- Contradict the experimental results
- Fundamentally change the paper's contribution without flagging it

If agents suggest improvements that substantially change the story (not just refine it), note the change and update `argument-blueprint.md` to stay in sync.

If agents identify that additional experiments are needed (e.g., a claim has weaker evidence than expected), this triggers a RETURN TO PHASE 4 — see "Return to Phase 4" section below.

Dispatch THREE specialist agents simultaneously using the Task tool. Each agent gets **different context material** (not just a different role description) — this is what makes them genuinely different, not just "prompt wishing."

**Before dispatching, prepare context for each agent:**

1. **For Domain Expert** — read and include:
   - `docs/02_literature/literature-review.md` (what the field knows)
   - `docs/02_literature/gap-analysis.md` (what the field doesn't know)
   - `docs/01_intake/research-anchor.yaml` (domain, venue, value proposition)
   - Key findings from downloaded papers if available

2. **For Writing Editor** — read and include:
   - The section outline from Step 3 (intended argument structure)
   - Target venue name and tier (for calibrating expectations)
   - One example of what GOOD writing looks like vs BAD writing (use the examples from Step 4 above)

3. **For Adversarial Reviewer** — read and include:
   - `docs/03_plan/evaluation-protocol.yaml` or `analysis-storyboard.md` (what was planned)
   - `docs/05_execution/claim-evidence-alignment.md` (claim-evidence mapping)
   - `docs/05_execution/baseline-results.md` (actual numbers to verify against)

**Dispatch all three with their differentiated context:**

**All three agents share the same dynamic persona base** (from Step 1b), but each gets a **different specialist lens and different reference materials:**

```
Call Task tool with:
  description: "Domain expert review of [section name]"
  prompt: |
    [INSERT DYNAMIC PERSONA FROM STEP 1b]
    
    You are now reviewing a draft section of YOUR OWN paper before 
    submission. You want this to reflect your expertise and reputation.
    
    YOUR KNOWLEDGE OF THE FIELD (use this to evaluate the section):
    ===
    Literature review you compiled:
    [paste docs/02_literature/literature-review.md]
    
    Gap analysis you identified:
    [paste docs/02_literature/gap-analysis.md]
    
    Your value proposition for this paper:
    [from research-anchor.yaml → value_proposition]
    ===
    
    SECTION TO REVIEW:
    [paste full section LaTeX]
    
    As the domain expert and lead author, evaluate this draft:
    
    1. SCIENTIFIC DEPTH: Does every paragraph reflect your years of 
       expertise? Compare claims against your literature review.
       Would your colleagues at [top venues from persona] find this 
       insightful or trivial?
    2. MISSED CONNECTIONS: Based on your literature review, what 
       prior work should be cited or compared to but isn't? Which 
       papers from your gap analysis are relevant here?
    3. INSIGHT DENSITY: For each paragraph, is there at least one
       observation that only an expert like you would make?
    4. VENUE FIT: You've published at [target_venue] before. Is this 
       section at the depth [target_venue] expects?
    
    OUTPUT FORMAT (strictly follow):
    For each issue:
    ```
    ISSUE [N]:
    Location: [paragraph number or quote]
    Problem: [specific description]
    Evidence: [why this falls short, citing your literature review]
    Rewrite: [concrete suggested text — write as YOU would write it]
    Severity: CRITICAL / MAJOR / MINOR
    ```
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Writing quality review of [section name]"
  prompt: |
    [INSERT DYNAMIC PERSONA FROM STEP 1b]
    
    You are now editing a draft section of your paper. You are 
    reviewing specifically for WRITING QUALITY — does this read 
    like a paper from a leading lab, or like a student's first draft?
    
    YOUR REFERENCE:
    The intended argument structure for this section:
    [paste the section outline from Step 3]
    
    Target venue: [venue] (tier: [tier])
    
    CALIBRATION — here is what GOOD vs BAD writing looks like 
    in your field:
    
    BAD (course report style — would embarrass you):
    "We applied Leiden clustering with resolution 0.5 and obtained 
    7 clusters. We then annotated them using canonical markers."
    → This just describes what was done. No insight. No connection 
      to the field. A technician could write this.
    
    GOOD (how you actually write your papers):
    "Graph-based clustering resolved seven transcriptionally distinct 
    populations, each defined by a coherent marker program. The 
    separation of CD14+ and FCGR3A+ monocytes at this resolution is 
    consistent with the classical/non-classical dichotomy first 
    described by [ref], suggesting that even this modest dataset 
    captures functionally relevant heterogeneity."
    → Connects results to biology, cites prior work, makes a claim.
    
    SECTION TO REVIEW:
    [paste full section LaTeX]
    
    REVIEW INSTRUCTIONS:
    1. For EACH paragraph, classify: BAD, MIXED, or GOOD (using 
       the calibration above)? Quote the first sentence and rate it.
    2. ARGUMENT FLOW: Does the section follow the intended outline?
       Are transitions organic or mechanical?
    3. SPECIFICITY: Find every vague claim ("significantly", 
       "substantially", "notably") — demand a specific number.
    4. REDUNDANCY: Flag anything said twice.
    5. AUTHORITY SCORE: Rate 1-10. You, as a professor who has 
       published in [top venues from persona], would you put your 
       name on this section as-is?
    
    OUTPUT FORMAT:
    ```
    PARAGRAPH [N] (first sentence: "..."):
    Style: BAD/MIXED/GOOD
    Issues: [list]
    Rewrite of first 2 sentences: [as you would write them]
    ```
    
    OVERALL AUTHORITY SCORE: [1-10]
    If score < 7: what specific changes would make this sound like 
    it came from your lab?
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Adversarial review of [section name]"
  prompt: |
    You are an expert reviewer for [target_venue]. You have the same
    domain background as the authors:
    [INSERT DYNAMIC PERSONA FROM STEP 1b — but change perspective 
     to "reviewer" not "author"]
    
    However, you are reviewing SOMEONE ELSE'S paper, not your own.
    You are thorough, critical, and fair. Your reviews are known for
    catching unsupported claims and logical gaps.
    
    YOUR EVIDENCE BASE (use this to fact-check every claim):
    ===
    Claim-evidence alignment table:
    [paste docs/05_execution/claim-evidence-alignment.md]
    
    Actual experimental results:
    [paste docs/05_execution/baseline-results.md or experiment-log.md]
    
    Analysis plan / evaluation protocol:
    [paste docs/03_plan/evaluation-protocol.yaml or analysis-storyboard.md]
    ===
    
    SECTION TO REVIEW:
    [paste full section LaTeX]
    
    Using the evidence base above, write a detailed review:
    
    1. UNSUPPORTED CLAIMS: Check every claim against the evidence base.
       If a claim has no matching evidence, flag it.
    2. EXAGGERATED CLAIMS: Flag claims that overstate the evidence.
    3. LOGICAL GAPS: Where does the argument skip a step?
    4. MISSING COMPARISONS: Results discussed without comparison to 
       prior work or baselines.
    5. REVIEWER QUESTIONS: Write 3 specific questions the authors 
       CANNOT currently answer from the text.
    6. VERDICT: Would this section survive review at [target_venue]?
    
    OUTPUT FORMAT:
    ```
    CLAIM: "[quoted text]"
    Evidence status: SUPPORTED / PARTIALLY / UNSUPPORTED / EXAGGERATED
    Action needed: [specific fix]
    ```
    
    VERDICT: [YES/MOSTLY/NO]
    TOP 3 QUESTIONS FOR AUTHORS:
    1. ...
    2. ...
    3. ...
  subagent_type: "generalPurpose"
```

#### Phase B2: Optional Cross-Critique Round

If the adversarial reviewer's verdict is "NO" (would not survive review), run a second round:

1. Take the adversarial reviewer's top 3 concerns
2. Dispatch the domain expert agent again with these concerns as input:

```
Call Task tool with:
  description: "Domain expert response to reviewer concerns"
  prompt: |
    A reviewer raised these concerns about a paper section:
    [paste adversarial reviewer's top concerns]
    
    Original section:
    [paste section text]
    
    Literature context:
    [paste literature review]
    
    For each concern, provide:
    1. Is the reviewer right? (YES/PARTIALLY/NO)
    2. If yes: what specific changes to the text would address it?
    3. If no: what rebuttal text should be added to preempt this concern?
    
    Provide concrete rewrite suggestions for each.
  subagent_type: "generalPurpose"
```

This cross-critique ensures concerns are addressed with domain knowledge, not just generic fixes.

#### Phase C: Synthesize, Rewrite, and Verify (multi-round, up to 5 rounds)

**REQUIRED SUB-SKILL:** Follow `amplify:multi-round-deliberation` protocol (max 5 rounds).

**Round 1 synthesis (after Phase B agents return):**

1. **Merge feedback** — combine all three reviews, deduplicate, prioritize by severity
2. **Rewrite the section** incorporating ALL substantive feedback:
   - Replace every "report-style" paragraph flagged by the domain expert
   - Fix argument structure issues flagged by the writing expert
   - Address weak claims and logical gaps flagged by the adversarial reviewer
   - Add missing citations and comparisons
3. **Verify the rewrite** meets minimum word count and citation count

**Convergence check:**
- All agents PASS (Writing Editor authority score ≥ 7, Adversarial Reviewer verdict ≥ "MOSTLY")? → go to Phase D
- Any agent CONDITIONAL or FAIL + round < 5? → next round

**Subsequent rounds (2–5) — full re-assessment:**

Dispatch ALL three agents with the complete rewritten section (not just the agents with issues — fixes can introduce new problems):

```
Call Task tool with:
  description: "[agent role] — round [N] review of [section name]"
  prompt: |
    This is round [N] of deliberation on the [section name] section.
    
    Previous round concerns:
    YOUR concerns: [paste this agent's issues]
    OTHER agents' concerns: [summary]
    
    Changes made since last round:
    [summary of changes and why]
    
    COMPLETE REVISED SECTION:
    [paste full revised LaTeX]
    
    Review the COMPLETE section (not just changes — fixes can introduce 
    new issues). Answer:
    1. Previous concerns: RESOLVED / PARTIALLY / NOT ADDRESSED (each)
    2. NEW issues introduced by modifications?
    3. Issues with how other agents' concerns were addressed?
    4. Overall verdict: PASS / CONDITIONAL / FAIL
    
    If CONDITIONAL or FAIL: state exactly what remains.
  subagent_type: "generalPurpose"
```

Repeat: modify → dispatch all agents → check convergence, until all PASS or round 5 reached.

If round 5 reached with unresolved issues: note them in the presentation to user (Phase E). The user can decide whether to iterate further or accept.

#### Phase D: Quality Gate (you do this)

Before presenting to user, verify:
- [ ] Every paragraph advances an argument (not just describes a procedure)
- [ ] At least one non-obvious insight per paragraph in Results/Discussion
- [ ] All findings connected to prior work
- [ ] No vague claims without specific numbers
- [ ] Word count ≥ minimum, citation count ≥ minimum
- [ ] Reads like a senior researcher wrote it, not a student

If ANY check fails → rewrite the failing paragraphs. Do NOT present sub-standard work.

#### Phase E: Present to User

Present the POLISHED section (after multi-round deliberation) with:

```
Section: [name]
Word count: [N] / minimum [M] — [PASS/FAIL]
Citation count: [N] / minimum [M] — [PASS/FAIL]
Figures referenced: [list]
Tables referenced: [list]

Multi-agent deliberation:
  Rounds: [N] / max 5
  - Domain expert: [N] issues raised, [N] resolved — final verdict: [PASS/COND/FAIL]
  - Writing editor: authority score [N]/10 — final verdict: [PASS/COND/FAIL]
  - Adversarial reviewer: [N] issues raised, [N] resolved — final verdict: [PASS/COND/FAIL]
  Consensus: [reached in round N / unresolved items: ...]
```

**STOP and wait for user feedback.**

Only after user approves this section → proceed to write the next section.

### Section Order

Write sections in this order. **EVERY section goes through the FULL Phase A–E cycle — no exceptions, no shortcuts, no "brief review."**

1. Methods (most objective, sets the stage)
2. Results (evidence presentation)
3. Introduction (now that you know the full story)
4. Discussion (interpretation and broader context)
5. Related Work (positioning against the field)
6. Abstract (summary of everything)
7. Conclusion (final wrap-up)

<IRON-LAW>
ALL SECTIONS GET EQUAL TREATMENT. It is a common failure mode to give Methods and Results full multi-agent polishing but then rush Discussion, Related Work, Abstract, and Conclusion with only a "brief review" or no review at all. This produces uneven quality that reviewers notice immediately.

Every single section — including Discussion, Related Work, Abstract, and Conclusion — MUST go through:
- Phase A: Full draft meeting minimum word/citation counts
- Phase B: Three-agent parallel review (domain expert + writing editor + adversarial reviewer)
- Phase C: Synthesize and rewrite incorporating ALL feedback
- Phase D: Quality gate self-check
- Phase E: Present polished version with stats to user

If you catch yourself writing "简要审阅" or "brief review" for any section, STOP — you are cutting corners. Run the full three-agent panel.
</IRON-LAW>

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

### Full-Paper Multi-Agent Review Panel

After assembly and consistency check, dispatch **three independent reviewer subagents** for a FULL-PAPER review. This is different from the per-section polishing — this looks at the paper AS A WHOLE: cross-section coherence, overall narrative arc, and whether the paper works as a complete unit.

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

### Processing Review Panel Results (multi-round, up to 5 rounds)

**REQUIRED SUB-SKILL:** Follow `amplify:multi-round-deliberation` protocol (max 5 rounds for full-paper).

**Round 1 — after all three subagents return:**

1. **Merge and deduplicate** — combine issues from all three reviewers
2. **Prioritize** — rank by severity: FATAL > CRITICAL > MAJOR > IMPORTANT > MINOR
3. **Classify and execute fixes:**

| Action Type | Trigger | What to do |
|-------------|---------|-----------|
| Text fix | Proofreader or style issues | Fix directly in the relevant `.tex` file |
| Content expansion | "Section too thin" / "claim unsupported" | Expand the section, add evidence |
| **New experiment needed** | Domain critic or adversarial reviewer says "EXPERIMENT NEEDED" | → **Trigger Return to Phase 4** (see below) |
| New figure/table needed | "Would benefit from visualization of X" | Generate and add |
| Reference additions | "Missing important work by X" | Search, verify, and add |

4. **Apply all non-experiment fixes** to the paper
5. **Re-dispatch ALL three agents** (Round 2) with the complete revised paper — not just agents with issues, because fixes can introduce new problems:

```
Call Task tool with:
  description: "[agent role] — round [N] full-paper review"
  prompt: |
    This is round [N] of the full-paper review.
    
    Previous round concerns:
    YOUR concerns: [paste this agent's issues]
    OTHER agents' concerns: [summary]
    
    Changes made since last round:
    [summary of fixes]
    
    COMPLETE REVISED PAPER:
    [paste full paper text]
    
    Review the COMPLETE paper (fixes can introduce new issues). Answer:
    1. Previous concerns: RESOLVED / PARTIALLY / NOT ADDRESSED (each)
    2. NEW issues introduced by modifications?
    3. Overall verdict: PASS / CONDITIONAL / FAIL
  subagent_type: "generalPurpose"
```

6. **Repeat** (modify → dispatch all agents → check convergence) until all PASS or round 5 reached.

7. **Present final results to user:**

```
Full-Paper Review Panel Results:
════════════════════════════════

Deliberation: [N] rounds completed / max 5
Proofreader: [N] issues total → [N] resolved — final verdict: [PASS/COND]
Domain Critic: [N] issues total → [N] resolved — final verdict: [PASS/COND]
Adversarial Reviewer: 
  Round 1 recommendation: [X]
  Final recommendation: [Y], confidence = [Z]

Consensus: [reached in round N / unresolved after 5 rounds]
RESOLVED issues: [N]
REMAINING issues: [N] (if any — for your decision)

Issues requiring new experiments (if any):
  1. [EXPERIMENT NEEDED] ...

Shall I proceed? If new experiments are needed,
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
