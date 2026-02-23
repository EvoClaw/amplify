---
name: results-integration
description: Use when core experiments or analyses are complete and results need to be organized into a coherent report for user review before paper writing
---

# Results Integration (Phase 5)

## Overview

Raw results are not a paper. This skill transforms completed experiments and analyses into a structured, evidence-backed content plan that the user reviews before any writing begins. It bridges execution (Phase 4) and paper writing (Phase 6).

**Core principle:** Organize, interpret, verify — then and only then, outline.

## Pre-Integration Verification (All Types)

<IRON-LAW>
RESULTS MUST BE REAL BEFORE THEY CAN BE INTEGRATED. Verify ALL of the following before proceeding to any integration step. If ANY check fails, RETURN to Phase 4 — do NOT proceed to paper writing with deficient results.
</IRON-LAW>

### Verification Checklist

- [ ] **[Type M] Methods ran to completion** — all models (method + baselines) executed their full intended procedure. For iterative methods (DL, optimization), this means trained to convergence. For non-iterative methods (RF, SVM), this means fitted with intended hyperparameters on full data. Partial or prematurely stopped runs are NOT valid results.
- [ ] **[Type M] Method is competitive** — method performance is within reasonable range of baselines on primary metric. If method is drastically worse than ALL baselines (e.g., 0.42 vs 0.95), results are NOT ready — return to Phase 4 for more iteration.
- [ ] **[Type M] Baselines actually ran** — baseline results come from actual runs with the same evaluation protocol, NOT copied from papers with different settings.
- [ ] **[Type D] Analysis is comprehensive** — all planned analyses from the storyboard have been executed, not just a subset.
- [ ] **[All] All seeds ran** — results reflect all seeds from `evaluation-protocol.yaml`, not cherry-picked subsets.
- [ ] **[All] Negative results recorded** — failures and unexpected outcomes are documented in `docs/05_execution/negative-results.md`.

If ANY check fails: **STOP. Return to Phase 4.** Do not attempt to "write around" deficient results.

---

## Type M Path — Method Development

### M-Step 1: Compile Full Experiment Results

Gather and structure all quantitative outputs:

- **Main results table** — all methods × all datasets × primary metrics (mean ± std, significance)
- **Ablation results table** — each component removed/replaced, impact on primary metric
- **Efficiency comparison** — wall-clock time, GPU memory, parameter count, FLOPs where applicable
- **Key visualizations** — t-SNE/UMAP embeddings, attention maps, learning curves, error distributions, or domain-appropriate plots

Every number must trace back to a logged experiment run. No manual transcription without verification.

### M-Step 2: Interpret Results

Answer three questions with specific evidence:

1. **WHY does the method work better?** Mechanism-level explanation grounded in ablation and visualization evidence — not hand-waving.
2. **WHERE does it excel and struggle?** Scenario analysis: dataset characteristics, data regimes, edge cases. Honest accounting of failure modes.
3. **WHAT does ablation reveal?** Rank components by contribution. Identify which are essential vs. marginal.

### M-Step 3: Claim-Evidence Alignment

**REQUIRED SUB-SKILL:** Invoke `amplify:claim-evidence-alignment`. Build the full claim-evidence mapping table before proceeding. Every intended claim must map to a specific figure, table, or statistical test. Unmapped claims are deleted.

---

## Type D Path — Discovery / Data Analysis

### D-Step 1: Organize Results Along Story Line

Structure findings around the narrative established in Phase 3:

- **Main finding** + all supporting evidence (figures, tables, statistics)
- **Each sub-line finding** + explicit connection to the main story
- **Excluded alternative explanations** — document which alternatives were tested and ruled out, with evidence

### D-Step 2: Build Narrative Chain

Assemble the evidence in this order:

> **Observation** → **Analysis** → **Finding** → **Mechanism** → **Validation**

Each link must be supported. A gap in the chain means the analysis is incomplete — return to Phase 4 and fill it.

### D-Step 3: Claim-Evidence Alignment

**REQUIRED SUB-SKILL:** Same as M-Step 3. Invoke `amplify:claim-evidence-alignment`. No exceptions for Type D.

---

## Common Steps (All Types)

### Step 4: Multi-Agent Results Discussion

Before generating the content outline, dispatch a structured multi-agent discussion to stress-test the results interpretation and story line. This is the most important quality gate before paper writing — a weak story here produces a weak paper.

**Round 1 — Independent assessment** (dispatch all three in the **same message** for parallel execution):

**Preparation:** Before dispatching, compile all results into a single text block. Read:
- `docs/05_execution/baseline-results.md`
- `docs/05_execution/experiment-log.md`
- All results tables and key figures descriptions
- `research-anchor.yaml` (for venue, research type, value proposition)

Then dispatch:

```
Call Task tool with:
  description: "Story architecture for results"
  prompt: |
    You are a senior researcher reviewing experimental results before paper writing.

    Research type: [from research-anchor.yaml]
    Target venue: [from research-anchor.yaml]
    Value proposition: [from research-anchor.yaml]

    Results:
    [Paste compiled results — main tables, ablation, key figures, baseline comparison]

    Questions:
    1. What is the strongest narrative these results support?
    2. What are the 4-6 key content points, ranked by impact?
    3. What figures and tables would best communicate each point?
    4. Is the story coherent? Does each piece of evidence connect logically to the next?
    5. What is the "elevator pitch" — one sentence that captures the paper's contribution?

    Return: a ranked content outline with narrative arc.
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Devil's advocate review of results"
  prompt: |
    You are a skeptical reviewer examining research results BEFORE they become a paper.
    Your job is to find every weakness and gap.

    Research type: [from research-anchor.yaml]
    Evaluation protocol: [paste evaluation-protocol.yaml content]

    Results:
    [Paste same compiled results]

    Questions:
    1. What alternative explanations exist for each key finding?
    2. Which claims are weakly supported? What additional evidence would strengthen them?
    3. Are there gaps in the analysis? What experiments or analyses are MISSING?
    4. Could the results be an artifact of the experimental setup (overfitting, data leakage, selection bias)?
    5. If you had to REJECT a paper based on these results, what would your reason be?

    Return: a list of vulnerabilities, each with:
    - Severity: fatal / major / minor
    - Specific suggestion to address it
    - Whether it requires new experiments (tag: EXPERIMENT NEEDED) or can be addressed in writing
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Venue-specific assessment"
  prompt: |
    You are an expert on [target venue]'s reviewing standards and audience expectations.

    Target venue: [venue name and tier]
    Research type: [from research-anchor.yaml]

    Results:
    [Paste same compiled results]

    Questions:
    1. Are these results sufficient for [target venue]? What's the expected bar?
    2. What would reviewers at this venue specifically look for?
    3. Are there standard analyses/experiments this venue's reviewers expect that are missing?
    4. How does this work compare in scope to recent accepted papers at [venue]?
    5. Suggest the positioning strategy: what angle would be most compelling for this audience?

    Return: a venue-specific assessment with concrete recommendations.
  subagent_type: "generalPurpose"
```

**Round 2 — Synthesis and iteration:**

After all three subagents return:

1. **Merge insights** — combine the story architect's outline with the devil's advocate's vulnerabilities and the audience specialist's positioning
2. **Identify action items:**

| Issue | Source | Action |
|-------|--------|--------|
| Missing experiment | Devil's Advocate | Return to Phase 4 for supplement |
| Weak evidence for claim X | Devil's Advocate | Check if evidence exists but wasn't highlighted, or run additional analysis |
| Better story angle | Story Architect / Audience Specialist | Restructure content outline |
| Missing standard analysis for venue | Audience Specialist | Add to analysis plan |

3. **Present synthesized plan to user:**

```
Results Discussion Panel Summary:
═════════════════════════════════

Story Architect's top narrative: [one sentence]
Devil's Advocate found: N vulnerabilities (K fatal, M major, J minor)
Audience Specialist assessment: [sufficient / needs work] for [venue]

Recommended actions before proceeding:
  ✅ Ready: [list items that are solid]
  ⚠️ Strengthen: [list items that need more evidence — can be done now]
  🔬 New experiments needed: [list items requiring return to Phase 4]

Proposed content outline (after addressing above):
  1. [Point] — evidence: [figure/table]
  2. ...
```

4. **If new experiments are needed** — get user approval, return to Phase 4 `experiment-execution` for the specific additions, then come back here and re-run the discussion panel on updated results

5. **Iterate until stable** — repeat the discussion if substantial changes were made. The panel does NOT need to re-run for minor tweaks, only for structural changes to the story or new results.

### Step 5: Generate Content Outline

<IRON-LAW>
MINIMUM DELIVERABLES — non-negotiable for ANY research paper:
- At least **3 figures** (e.g., main comparison plot, ablation visualization, qualitative/analysis figure)
- At least **2 tables** (e.g., main quantitative comparison, ablation/efficiency table)
- At least **4 substantive content points** (each backed by evidence)

For a GOOD paper at a competitive venue, aim for 5-8 figures/tables total.
</IRON-LAW>

**REQUIRED SUB-SKILL:** Before producing any figure, invoke `amplify:figure-quality-standards`. Apply the style template, method-color mapping, and per-figure checklist to every figure generated in this phase.

Using the synthesized output from the multi-agent discussion, produce the final structured outline with 4–6 key content points:

```
Key content points:
1. [Point] — Fig.1: [description] — Table 1: [description]
2. [Point] — Fig.2: [description]
3. [Point] — Table 2: [description] — Fig.3: [description]
4. [Point] — Fig.4: [description]
...

Figure count: N (minimum 3)
Table count: N (minimum 2)
Target venue: [venue]
Vulnerabilities addressed: [list from devil's advocate]
Is this sufficient for [target venue]? Need additions?
```

**Self-check before presenting to user:**
- Count figures: ≥ 3? If not, identify what additional figures are needed.
- Count tables: ≥ 2? If not, identify what additional tables are needed.
- Each point backed by specific evidence? If not, the point is a claim without support — remove or generate evidence.
- All fatal/major vulnerabilities from devil's advocate addressed? If not, do NOT proceed.

Present to user for review. Each point must have at least one supporting figure or table.

### Step 6: User Iteration

The user may request additions, re-analyses, or new experiments. For each request:
1. Run the additional experiment/analysis
2. Integrate into the results compilation
3. Re-run claim-evidence alignment on affected claims
4. Regenerate the content outline

Repeat until the user is satisfied.

### Step 7: User Confirmation

The user must explicitly state **"ready for paper"** (or equivalent). Do not infer readiness. Do not suggest skipping iteration.

---

## G4 Gate Checklist — Write-Ready

ALL applicable items must be satisfied. Present to the user for sign-off.

**Results quality:**
- [ ] Core experiments/analyses complete (no planned runs remaining)
- [ ] [Type M] All methods ran to **completion** (NOT partial/prematurely-stopped runs)
- [ ] [Type M] Method outperforms at least one baseline on primary metric with statistical support (p-values, CIs reported)
- [ ] [Type M] Ablation study complete — every key component tested
- [ ] [Type D] Story line evidence chain complete — no narrative gaps
- [ ] [Type D] Alternative explanations addressed with evidence

**Verification:**
- [ ] `claim-evidence-alignment` passed — full mapping table reviewed
- [ ] All seeds from `evaluation-protocol.yaml` ran and reported (no cherry-picking)
- [ ] Negative results documented

**Content readiness:**
- [ ] 4–6+ content points, each with supporting figures/tables
- [ ] At least **3 figures** produced and ready
- [ ] At least **2 tables** produced and ready
- [ ] Content outline presented to user and **explicitly approved**

**User confirmation:**
- [ ] User confirmed: "ready to write paper" (exact phrase or clear equivalent)
- [ ] Venue target final confirmation: "[venue] — still correct?"

Only after ALL applicable items pass: set G4 status to `passed` and proceed to `paper-writing`.

<IRON-LAW>
If the user has NOT explicitly said "ready to write paper" or equivalent, G4 CANNOT pass. Do NOT infer readiness from silence, from "okay", or from "looks good" (which may refer to results, not write-readiness). ASK EXPLICITLY: "Shall I proceed to paper writing now?"

## ⛔ MANDATORY STOP — This is the LAST checkpoint before paper writing

After presenting the G4 checklist, **END YOUR RESPONSE IMMEDIATELY.**

Do NOT invoke `paper-writing` in this same response.
Do NOT begin writing any LaTeX.
Do NOT set up the paper directory structure.

**STOP. WAIT.** The user must explicitly say "ready to write paper" or equivalent.

If you find yourself writing LaTeX without the user having said these words,
**YOU ARE VIOLATING A CRITICAL RULE.** Stop immediately.
</IRON-LAW>

## Red Flags — STOP

- Declaring results "complete" without statistical verification
- Missing ablation study for a Type M project
- Story line gaps in a Type D project (findings that don't connect)
- Content outline with fewer than 4 substantive points
- Proceeding to paper writing without explicit user confirmation
- Claim-evidence alignment not run or not passed

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "The results speak for themselves" | Results need interpretation, not just presentation. Explain the mechanism. |
| "Ablation isn't necessary — the main result is strong" | Reviewers will ask. Missing ablation is a guaranteed major revision. |
| "The story is obvious from the data" | Obvious to you ≠ coherent to a reader. Build the chain explicitly. |
| "We have enough figures already" | Enough for what venue? Check against the content outline. |
| "Let's just start writing and fill gaps later" | Gaps found during writing cost 3× more to fill. Verify completeness now. |
