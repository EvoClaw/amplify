---
name: results-integration
description: Use when core experiments or analyses are complete and results need to be organized into a coherent report for user review before paper writing
---

# Results Integration (Phase 5)

## Overview

Raw results are not a paper. This skill transforms completed experiments and analyses into a structured, evidence-backed content plan that the user reviews before any writing begins. It bridges execution (Phase 4) and paper writing (Phase 6).

## On-Demand Literature Search (Active Throughout Phase 5)

During results integration, you may need to find related work to contextualize unexpected findings, identify papers that support or contradict your claims, or locate comparison points. **Search immediately when needed.** Add new papers to `docs/02_literature/paper-list.md` with tag `[Found during Phase 5]`.

**If search fails or returns insufficient results:**
1. Try alternative search terms (synonyms, broader/narrower scope, different field terminology)
2. If still insufficient → note what was searched and what's missing in `docs/02_literature/paper-list.md`
3. Ask the user: "I need papers on [topic] but couldn't find them via [methods tried]. Can you point me to relevant work?"
4. Do NOT block on literature — proceed with available information and mark claims with `[citation needed]` in the argument blueprint

**Core principle:** Organize, interpret, verify — then and only then, outline.

<IRON-LAW>
### PUBLISHABILITY CHECK — Before ANY integration

Before organizing results, answer this question honestly:

**"Do these results contain at least one finding that a domain expert would NOT have predicted before seeing the data?"**

For **Type C (Tool)**, the equivalent question is: **"Does this tool demonstrably solve a real problem that existing tools cannot (or do significantly worse)?"** If the tool is merely "another option" with no clear advantage, it's not publishable.

If the answer is NO — if every finding confirms what was already known (e.g., "PBMC data contains T cells and B cells"), or the tool offers no clear advantage over existing tools — then the results are NOT ready for a research paper. Options:

1. **Deepen the analysis** — return to Phase 4 for additional analyses that might reveal unexpected patterns
2. **Change the angle** — re-examine the data for findings that ARE surprising or novel
3. **Honestly downgrade** — tell the user: "The current results would be better suited for a [lower tier venue / technical note / blog post] because they confirm known findings without adding new insight"

Do NOT proceed to write a paper about confirmatory results dressed up as discoveries. This produces "course report" papers that waste reviewer time and damage credibility.
</IRON-LAW>

## Pre-Integration Verification (All Types)

<IRON-LAW>
RESULTS MUST BE REAL BEFORE THEY CAN BE INTEGRATED. Verify ALL of the following before proceeding to any integration step. If ANY check fails, RETURN to Phase 4 — do NOT proceed to paper writing with deficient results.
</IRON-LAW>

### Verification Checklist

- [ ] **[Type M] Methods ran to completion** — all models (method + baselines) executed their full intended procedure. For iterative methods (DL, optimization), this means trained to convergence. For non-iterative methods (RF, SVM), this means fitted with intended hyperparameters on full data. Partial or prematurely stopped runs are NOT valid results.
- [ ] **[Type M] Method is competitive** — method performance is within reasonable range of baselines on primary metric. If method is drastically worse than ALL baselines (e.g., 0.42 vs 0.95), results are NOT ready — return to Phase 4 for more iteration.
- [ ] **[Type C] Tool correctness verified** — tool output matches reference/gold standard on all test cases.
- [ ] **[Type C] Benchmarks complete** — correctness, performance, and scalability benchmarks run against competing tools.
- [ ] **[Type C] Case studies executed** — at least 2 real-world use cases demonstrate the tool solving actual problems.
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

## Type C Path — Tool / Software

### C-Step 1: Compile Benchmark Results

Gather and structure all evaluation outputs:

- **Correctness table** — our tool vs reference/gold standard on all test cases
- **Performance comparison table** — our tool vs competing tools × benchmarks (runtime, memory, throughput)
- **Scalability curves** — performance at each scale point for our tool and competitors
- **Case study results** — outputs and workflow for each real-world use case

Every number must trace back to a logged benchmark run.

### C-Step 2: Interpret Advantages

Answer three questions with specific evidence:

1. **WHAT is the primary advantage?** Quantify: "X× faster", "handles Y× larger input", "Z% more accurate". Vague claims ("faster", "better") are not acceptable.
2. **WHERE does it excel and struggle?** Which benchmarks, which input sizes, which edge cases? Honest accounting of limitations.
3. **WHY does the advantage exist?** Architectural or algorithmic explanation — not just "we observed it's faster."

### C-Step 3: Claim-Evidence Alignment

**REQUIRED SUB-SKILL:** Invoke `amplify:claim-evidence-alignment`. Every utility claim must map to a specific benchmark result, scalability curve, or case study output.

---

## Type H Path — Hybrid

Type H integrates results from BOTH the method track (Type M) AND the discovery/analysis track (Type D).

1. **Execute M-Steps 1–3** for the method development results
2. **Execute D-Steps 1–3** for the scientific discovery results
3. **Cross-track integration**: Identify where method results enable or explain scientific findings, and where scientific findings validate the method's value
4. **Unified claim-evidence map**: Combine both tracks into a single claim-evidence table, marking each claim's source track (M, D, or both)

The primary track (from `research-anchor.yaml`) determines which results lead the narrative.

---

## Common Steps (All Types)

### Step 4: Multi-Agent Story Design (AUTOMATED — MANDATORY)

<IRON-LAW>
### THIS IS WHERE THE PAPER'S STORY IS DESIGNED — NOT IN PHASE 6

Phase 5 is where the DEEP thinking about story, argument structure, claims, and interpretations happens. Phase 6 (paper writing) should ONLY execute the story designed here — it should NOT be discovering the story while writing.

This multi-agent discussion is:
- NOT optional and NOT deferred
- NOT just "positioning" — it must design the full ARGUMENT structure
- NOT just about content points — it must specify claims, evidence, interpretations, and connections to prior work for EACH point

The user should NOT need to ask for this — it happens automatically as part of Phase 5.
</IRON-LAW>

Before generating the content outline, dispatch a structured multi-agent discussion to **DESIGN the paper's argument structure** — not just list topics, but work out the full story with claims, evidence chains, and interpretations.

**Key question for the panel:** "Would a senior researcher in this field read this paper and learn something they didn't already know? Or would they say 'this is a nice exercise but I already knew all of this'?"

**Round 1 — Independent story design** (dispatch all three in the **same message** for parallel execution):

**Preparation:** Before dispatching, compile context for EACH agent. The key to effective multi-agent discussion is giving each agent **different reference material** — not just different role descriptions.

Read all of these:
- `docs/05_execution/baseline-results.md` (experiment log, results)
- `docs/05_execution/experiment-log.md`
- `docs/05_execution/negative-results.md`
- `docs/02_literature/literature-review.md` (what the field knows)
- `docs/02_literature/gap-analysis.md` (what gaps we identified)
- `docs/01_intake/research-anchor.yaml` (venue, value proposition)
- `docs/03_plan/evaluation-protocol.yaml` or `analysis-storyboard.md`
- All results tables and key figure descriptions

**Generate a Dynamic Expert Persona** from `research-anchor.yaml` (same mechanism as paper-writing Step 1b):

```
Read research-anchor.yaml and generate:

EXPERT PERSONA:
"You are a tenured professor specializing in [subdomain] within [domain].
You have 20+ years of experience and have published extensively in 
[GENERATE 4-6 real top venues for this domain+subdomain]. Your expertise 
covers [reviewer_focus items]. You are preparing a paper for [target_venue]
and this is YOUR work — your reputation depends on its quality."
```

Then dispatch with **this persona + differentiated context** (each agent gets different materials):

```
Call Task tool with:
  description: "Story architecture for results"
  prompt: |
    [INSERT DYNAMIC EXPERT PERSONA]
    
    You are now deciding the narrative for YOUR next paper. Your job is 
    not just to list findings — it is to DESIGN THE ARGUMENT STRUCTURE 
    that will convince reviewers this work is publishable.
    
    YOUR KNOWLEDGE BASE — what the field knows and what's new:
    ===
    Literature review (prior work):
    [Paste docs/02_literature/literature-review.md]
    
    Gap analysis (what's missing in the field):
    [Paste docs/02_literature/gap-analysis.md]
    
    Value proposition:
    [from research-anchor.yaml]
    ===
    
    RESULTS TO INTERPRET:
    Research type: [from research-anchor.yaml]
    Target venue: [from research-anchor.yaml]
    
    [Paste compiled results — main tables, ablation, key figures, baseline comparison]

    DESIGN THE FULL ARGUMENT STRUCTURE:
    
    1. ELEVATOR PITCH: One sentence — what do we now know that we didn't know before?
    
    2. CORE ARGUMENT: In 3-5 sentences, what is the paper's thesis? This is NOT 
       "we ran analysis X" — it is "our analysis reveals Y, which matters because Z."
    
    3. FOR EACH KEY CONTENT POINT (aim for 4-6), provide ALL of:
       a. THE CLAIM: What specific statement are we making?
       b. THE EVIDENCE: Which figure, table, or statistic supports it?
       c. THE INTERPRETATION: Why does this evidence support the claim? 
          What is the reasoning chain? (This is where legitimate scientific 
          interpretation happens — connecting data to meaning.)
       d. THE CONNECTION: How does this relate to or extend prior work? 
          Cite specific papers from the literature review.
       e. THE SIGNIFICANCE: Why should the reader care about this point?
    
    4. NARRATIVE ARC: What is the reader's journey through the paper?
       - What question does the reader start with?
       - What is the "aha moment"?
       - What does the reader believe by the end that they didn't before?
    
    5. LIMITATIONS & HONEST FRAMING: What can we NOT claim? Where must we 
       be careful with language?
    
    6. PUBLISHABILITY at [venue]: YES / NO / CONDITIONAL (if conditional, 
       what's missing?)

    Return: a COMPLETE argument design document with all of the above.
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Devil's advocate review of results"
  prompt: |
    [INSERT DYNAMIC EXPERT PERSONA — but as a reviewer, not author]
    
    You are reviewing someone else's results before they write a paper.
    You are skeptical and thorough. Your job is to find every weakness 
    AND to identify what additional experiments would make the paper stronger.

    YOUR REFERENCE — what was PLANNED vs what was DONE:
    ===
    Original plan:
    [paste evaluation-protocol.yaml OR analysis-storyboard.md]
    
    Negative results and failures:
    [paste docs/05_execution/negative-results.md]
    ===

    Research type: [from research-anchor.yaml]
    
    RESULTS TO SCRUTINIZE:
    [Paste compiled results]

    PART A — Vulnerability analysis:
    1. What alternative explanations exist for each key finding?
    2. Which claims are weakly supported? What additional evidence would strengthen them?
    3. Compare results against the original plan — are there planned analyses that were NOT done?
    4. Could the results be an artifact of the experimental setup (overfitting, data leakage, selection bias)?
    5. If you had to REJECT a paper based on these results, what would your reason be?
    6. CRITICAL NOVELTY CHECK: Do these results contain ANY finding that a domain expert would NOT have predicted? If every finding just confirms known facts, say so explicitly — this means the paper is not ready.
    7. Are the negative results (failures) properly accounted for, or were they swept under the rug?
    
    PART B — Experiment supplement recommendations:
    For each weakness that CANNOT be addressed by writing alone, specify:
    8. What SPECIFIC additional experiment or analysis would address this weakness?
    9. How critical is it? (REQUIRED for publication / STRONGLY RECOMMENDED / nice to have)
    10. Estimated scope: small (hours) / medium (days) / large (weeks)

    Return: a structured report with:
    - Vulnerabilities (severity: fatal / major / minor)
    - For each: whether it needs WRITING FIX or EXPERIMENT SUPPLEMENT
    - Specific experiment supplement recommendations with priority and scope
  subagent_type: "generalPurpose"

Call Task tool with:
  description: "Venue-specific assessment"
  prompt: |
    [INSERT DYNAMIC EXPERT PERSONA]
    
    You have published at [target venue] multiple times and served as 
    a reviewer there. You know exactly what gets accepted and rejected.

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
    6. SPECIFIC EXPERIMENT GAPS: List any analyses/experiments that this venue's 
       reviewers would REQUIRE but that are currently missing from the results.

    Return: a venue-specific assessment with concrete recommendations, 
    especially flagging any missing experiments that would be deal-breakers.
  subagent_type: "generalPurpose"
```

**Round 2+ — Multi-Round Deliberation (up to 5 rounds total)**

**REQUIRED SUB-SKILL:** Follow `amplify:multi-round-deliberation` protocol. The deliberation loop below implements it for Phase 5.

After Round 1 agents return:

**Step A — Synthesize and build initial Argument Blueprint:**

1. **Merge insights** — combine the story architect's argument design with the devil's advocate's vulnerabilities and the audience specialist's positioning
2. **Build the initial Argument Blueprint** (see blueprint format below)
3. **Triage experiment supplements** (see triage section below)

**Step B — Re-assess (Round 2):**

Re-dispatch ALL three agents with the complete modified blueprint (not just agents whose concerns were addressed — modifications can introduce new issues):

```
Call Task tool with:
  description: "[agent role] — round [N] review of blueprint"
  prompt: |
    SHARED VALUES:
    Target venue: [venue]. Optimization target: "Would this survive peer review?"
    Scoring: PASS (no fatal/major issues) / CONDITIONAL (major issues, addressable) / FAIL (fatal)
    
    This is round [N] of deliberation. Previous round concerns:
    ===
    YOUR previous concerns:
    [paste this agent's issues from last round]
    
    OTHER agents' concerns:
    [paste summary of other agents' issues]
    ===
    
    Changes made since last round:
    [list specific changes and why]
    
    COMPLETE ARGUMENT BLUEPRINT:
    [paste the full blueprint]
    
    Review the COMPLETE blueprint (not just changes). Answer:
    1. For EACH of your previous concerns: RESOLVED / PARTIALLY / NOT ADDRESSED?
    2. Any NEW issues introduced by the modifications?
    3. Any issues with how other agents' concerns were addressed?
    4. Overall verdict: PASS / CONDITIONAL / FAIL
    
    If CONDITIONAL or FAIL: state EXACTLY what remains to be fixed.
  subagent_type: "generalPurpose"
```

**Step C — Check convergence:**

| Outcome | Action |
|---------|--------|
| All agents: PASS | Deliberation complete → present blueprint to user |
| Any agent: CONDITIONAL + round < 5 | Modify blueprint → re-assess (next round, all agents) |
| Any agent: FAIL (fatal novelty issue) | HARD BLOCK → present options to user (cannot be fixed by more rounds) |
| Round 5 reached, still CONDITIONAL | Present unresolved disagreements to user for decision |

**Steps D, E, F... — Continue as needed (up to round 5):**

Each round: modify blueprint → dispatch ALL three agents with the complete blueprint → check convergence. All agents see the full artifact every time because fixes can introduce new problems.

**Non-convergence after 5 rounds:**

If agents still disagree after 5 rounds, present to user:

```
DELIBERATION SUMMARY:
═════════════════════
Rounds completed: N / 5
Final verdicts: Story Architect: [X], Devil's Advocate: [X], Audience Specialist: [X]

RESOLVED (N issues):
  ✅ [issue] — addressed in round [N]

UNRESOLVED (N issues):
  ⚠️ [issue] — Agent A says: "[position]" / Agent B says: "[counter-position]"
  → My recommendation: [your judgment]

Your decision needed:
  1. [Option A]
  2. [Option B]  
  3. [Compromise]
```

---

**Experiment supplement triage (done after Round 1, before Round 2):**

<IRON-LAW>
### EXPERIMENT SUPPLEMENT TRIAGE — MUST be done before proceeding

Collect ALL experiment supplement recommendations from ALL three agents. Classify each:

| Supplement | Source | Priority | Action |
|-----------|--------|----------|--------|
| [analysis X] | Devil's Advocate | REQUIRED | → Return to Phase 4 BEFORE proceeding |
| [analysis Y] | Audience Specialist | REQUIRED | → Return to Phase 4 BEFORE proceeding |
| [analysis Z] | Devil's Advocate | STRONGLY RECOMMENDED | → Present to user for decision |
| [analysis W] | Audience Specialist | Nice to have | → Note as future work |

**If ANY supplement is tagged REQUIRED:**
- The system MUST present these to the user with a clear recommendation to return to Phase 4
- Do NOT proceed to paper writing with REQUIRED supplements outstanding
- The user can override (e.g., "proceed without GO enrichment"), but the decision must be explicit and documented

**If REQUIRED supplements exist but user chooses to skip:**
- Document in `docs/06_integration/acknowledged-gaps.md`
- These MUST appear in the paper's Limitations section
- The G4 gate checklist will flag these as acknowledged-but-unresolved
</IRON-LAW>

3. **Build the argument blueprint** (initial version — refined through deliberation rounds):

Using the story architect's design as the base, incorporating the devil's advocate's corrections and the audience specialist's positioning, produce:

```
ARGUMENT BLUEPRINT (saved to docs/06_integration/argument-blueprint.md):
═══════════════════════════════════════════════════════════════════════

ELEVATOR PITCH: [one sentence]

CORE ARGUMENT: [3-5 sentences]

CONTENT POINTS (each fully specified):

Point 1: [TITLE]
  CLAIM: [specific statement]
  EVIDENCE: [figure/table/statistic with exact reference]
  INTERPRETATION: [why this evidence supports the claim — the reasoning]
  PRIOR WORK: [connection to literature]
  SIGNIFICANCE: [why this matters]
  KNOWN WEAKNESS: [from devil's advocate, if any]
  
Point 2: ...

NARRATIVE ARC:
  Opening question: [what the reader wonders]
  Build-up: [how evidence accumulates]
  Key insight: [the "aha moment"]
  Resolution: [what the reader now believes]

LIMITATIONS (honest):
  - [limitation 1 — how acknowledged in the paper]
  - [limitation 2]

ACKNOWLEDGED GAPS (experiments skipped by user choice):
  - [gap 1 — appears in Discussion as future work]
```

**This blueprint is refined through deliberation rounds (Step B–E above).** The version that achieves consensus (or survives max rounds) becomes the foundation for Phase 6.

4. **Present the converged blueprint to user:**

```
Results Discussion Panel Summary:
═════════════════════════════════

Story Architect's top narrative: [one sentence]
Devil's Advocate found: N vulnerabilities (K fatal, M major, J minor)
Audience Specialist assessment: [sufficient / needs work] for [venue]

EXPERIMENT SUPPLEMENTS:
  🔬 REQUIRED (must do before paper): [list, or "none"]
  ⚠️ RECOMMENDED (user decides): [list, or "none"]
  📝 Nice to have (future work): [list, or "none"]

Argument blueprint: [summary of the 4-6 points with claims]

Recommended actions before proceeding:
  ✅ Ready: [list items that are solid]
  ⚠️ Strengthen in writing: [items addressable without new experiments]
  🔬 New experiments needed: [items requiring return to Phase 4]
```

5. **HARD BLOCK on "fatal" findings:**

<IRON-LAW>
If the Devil's Advocate marks ANY vulnerability as **"fatal"** — especially a novelty failure ("no finding a domain expert wouldn't have predicted") — you MUST NOT proceed to paper writing. This is the most important quality gate in the entire workflow.

**When a fatal finding is detected:**

```
⛔ FATAL VULNERABILITY DETECTED

The Devil's Advocate identified a fatal issue:
"[quote the fatal finding]"

This means the current results are NOT ready for a research paper.
Proceeding to write a paper now would produce a "course report" 
that reviewers will reject.

Options:
1. DEEPEN — Return to Phase 4 for additional analyses that might 
   reveal genuinely novel findings (e.g., [specific suggestions])
2. PIVOT — Re-examine the data from a different angle that could 
   produce unexpected insights
3. DOWNGRADE — Honestly reframe as a technical note / benchmark / 
   tutorial (lower venue tier, different paper type)
4. STOP — The data may not support a publishable paper with this 
   approach

Which option do you prefer?
```

Do NOT silently reframe the paper as a "benchmark" to work around a novelty failure. This is the most common way the system produces course-report-quality papers. If the contribution has shifted from "discovery" to "benchmark," the user must explicitly acknowledge and approve this change.

**"Reframing as benchmark" is a downgrade, not a solution.** It must be presented as Option 3, not done silently.
</IRON-LAW>

6. **If experiments needed** — handle supplements:

   a. **REQUIRED supplements**: Present to user, recommend returning to Phase 4. If user agrees, return to Phase 4 for the specific additions, then come back and re-run the discussion panel on updated results.
   
   b. **RECOMMENDED supplements**: Present to user for decision. User can approve (→ Phase 4) or defer (→ document in acknowledged-gaps.md).
   
   c. After supplements are done: re-run ONLY the devil's advocate and audience specialist on the updated results (story architect's structure typically doesn't need to change unless results are dramatically different).

7. **Iterate until stable** — repeat the discussion if substantial changes were made. The panel does NOT need to re-run for minor tweaks, only for structural changes to the story or new results.

### Step 5: Finalize Argument Blueprint and Content Outline

<IRON-LAW>
MINIMUM DELIVERABLES — non-negotiable for ANY research paper:
- At least **3 figures** (e.g., main comparison plot, ablation visualization, qualitative/analysis figure)
- At least **2 tables** (e.g., main quantitative comparison, ablation/efficiency table)
- At least **4 substantive content points** (each backed by evidence AND interpretation)

For a GOOD paper at a competitive venue, aim for 5-8 figures/tables total.
</IRON-LAW>

**REQUIRED SUB-SKILL:** Before producing any figure, invoke `amplify:figure-quality-standards`. Apply the style template, method-color mapping, and per-figure checklist to every figure generated in this phase.

The argument blueprint from Step 4 is the DEFINITIVE story design. Convert it into a production-ready content outline that Phase 6 can directly execute:

```
ARGUMENT BLUEPRINT → CONTENT OUTLINE
═════════════════════════════════════

Elevator pitch: [from blueprint]
Core argument: [from blueprint]

Section-by-section plan:

INTRODUCTION will argue:
  - Opening context: [from blueprint narrative arc → opening question]
  - Gap statement: [from blueprint → prior work connections]
  - Our contribution: [from blueprint → core argument]

RESULTS will present (in this order):
  1. [Point] — CLAIM: [...] — EVIDENCE: Fig.1 + Table 1 — INTERPRETATION: [...]
  2. [Point] — CLAIM: [...] — EVIDENCE: Fig.2 — INTERPRETATION: [...]
  3. [Point] — CLAIM: [...] — EVIDENCE: Table 2 + Fig.3 — INTERPRETATION: [...]
  4. [Point] — CLAIM: [...] — EVIDENCE: Fig.4 — INTERPRETATION: [...]

DISCUSSION will address:
  - Key insight and its implications: [from blueprint → significance]
  - Connections to prior work: [from blueprint → prior work connections]
  - Limitations: [from blueprint → known weaknesses + acknowledged gaps]
  - Future directions: [from blueprint → acknowledged gaps]

Figure count: N (minimum 3)
Table count: N (minimum 2)
Target venue: [venue]
```

**Self-check before presenting to user:**
- Count figures: ≥ 3? If not, identify what additional figures are needed.
- Count tables: ≥ 2? If not, identify what additional tables are needed.
- Each point has CLAIM + EVIDENCE + INTERPRETATION? If interpretation is missing, the paper will read like a report — add it now.
- All fatal/major vulnerabilities from devil's advocate addressed? If not, do NOT proceed.
- Argument blueprint saved to `docs/06_integration/argument-blueprint.md`? Phase 6 depends on it.

Present to user for review.

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

**Novelty gate:**
- [ ] Multi-agent discussion completed (Step 4)
- [ ] Devil's Advocate found ZERO "fatal" vulnerabilities (if any fatal found, they were resolved via deepening, pivoting, or user-approved downgrade — NOT silently worked around)
- [ ] At least one finding that a domain expert would NOT have predicted before seeing the data

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
