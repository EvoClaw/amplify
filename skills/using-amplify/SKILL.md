---
name: using-amplify
description: Use when starting any conversation - establishes how to find and use research skills, requiring Skill tool invocation before ANY response including clarifying questions
---

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

# ABSOLUTE RULE #1: ONE PHASE PER TURN

<IRON-LAW>
YOU MUST COMPLETE ONLY **ONE PHASE** PER RESPONSE. After completing a phase or reaching a gate, you MUST:

1. Present the phase deliverables and/or gate checklist to the user
2. **END YOUR RESPONSE AND WAIT FOR THE USER TO REPLY**
3. Only proceed to the next phase AFTER the user explicitly approves

**THIS IS THE SINGLE MOST IMPORTANT RULE IN THE ENTIRE SYSTEM.**

Violating this rule — even once — collapses the entire research workflow into a shallow one-shot demo. The phases exist because each one requires human judgment before the next can begin.

### What "end your response" means

- After Phase 0: present `research-anchor.yaml` summary → **STOP. Wait for user.**
- After Phase 1 + G1: present G1 checklist → **STOP. Wait for user.**
- After Phase 2: present feasibility assessment → **STOP. Wait for user.**
- After Phase 3 + G2: present frozen plan → **STOP. Wait for user.**
- After G3: present readiness check → **STOP. Wait for user.**
- After Phase 4: present results summary → **STOP. Ask: "Are results sufficient? Shall I proceed to results integration?"**
- After Phase 5 + G4: present content outline → **STOP. Ask: "Shall I proceed to paper writing?"**
- During Phase 6: present EACH SECTION individually → **STOP. Wait for user feedback on that section.**

### What counts as user approval

- Explicit: "approved", "yes", "proceed", "looks good, go ahead", "继续", "可以"
- NOT approval: silence, no response, "ok" (ambiguous), or your own judgment that "it looks fine"

### Rationalizations that WILL occur — reject them all

| Your thought | Why it's wrong |
|-------------|---------------|
| "The user said to write a paper, so I should do all phases" | The user said WHAT. The workflow says HOW. One phase at a time. |
| "This is a simple project, I can combine phases" | No project is simple enough to skip human checkpoints. |
| "The user will get annoyed if I stop too often" | The user will get a bad paper if you don't stop. |
| "I already know what the user will say" | You don't. That's why you ask. |
| "Let me just do the next phase quickly" | "Quickly" = cutting corners. Stop. |
| "Phase 2 isn't needed for Type D" | Phase 2 is ALWAYS required. See below. |
</IRON-LAW>

# ABSOLUTE RULE #2: NO PHASE IS OPTIONAL

<IRON-LAW>
ALL SEVEN PHASES (0 through 6) ARE MANDATORY FOR ALL RESEARCH TYPES.

Specifically:
- **Phase 2 (Problem Validation) is REQUIRED for Type D.** Data analysis without adversarial questioning produces shallow, undefendable findings. "It's just data analysis" is the #1 rationalization for skipping Phase 2.
- **Phase 3 (Method/Analysis Design) is REQUIRED** even if the analysis seems straightforward. Locking the evaluation protocol and story line prevents goalpost-moving later.
- **Phase 5 (Results Integration) requires the full multi-agent discussion.** Skipping the discussion panel and jumping to paper writing produces thin, report-like papers.

The ONLY exception: the user explicitly says "skip Phase X" — and even then, warn them of consequences.
</IRON-LAW>

## How to Access Skills

**In Cursor:** Use the `Read` tool on `~/.cursor/skills/amplify/skills/{skill-name}/SKILL.md`. When you read a skill, follow it directly.

**In other environments:** Check your platform's documentation for how skills are loaded.

# Using Research Skills

## The Rule

**Read and follow relevant skills BEFORE any response or action.** Even a 1% chance a skill might apply means you should read the skill.

## System Architecture

Amplify operates on three layers:

**Workflow Layer** — Phase-by-phase research flow (domain-anchoring → exploration → validation → design → execution → integration → paper). These tell you WHAT to do next.

**Discipline Layer** — Cross-phase scientific rigor (metric-lock, anti-cherry-pick, claim-evidence-alignment, figure-quality-standards, reproducibility, verification). These tell you WHAT RULES to follow at all times.

**Meta-Control Layer** — Project governance (novelty-classifier, scope-control, pivot-or-kill, venue-alignment). These tell you WHEN to stop, pivot, or escalate.

## Four Gates

Progress between phases requires passing gates:

- **G1 (Topic & Venue)** — Between exploration and method design
- **G2 (Plan Freeze)** — Between method design and execution
- **G3 (Execution Readiness)** — Before full-scale experiments
- **G4 (Write-Ready)** — Before paper writing

No gate may be skipped. Each gate has a checklist that must be fully satisfied.

## Research Workflow Priority

When a user describes research intent, skills apply in this order:

```dot
digraph skill_flow {
    "User describes research intent" [shape=doublecircle];
    "Domain anchored?" [shape=diamond];
    "Invoke domain-anchoring" [shape=box];
    "Direction explored?" [shape=diamond];
    "Invoke research-direction-exploration" [shape=box];
    "Problem validated?" [shape=diamond];
    "Invoke problem-validation" [shape=box];
    "Method designed?" [shape=diamond];
    "Invoke method-framework-design" [shape=box];
    "Executing experiments?" [shape=diamond];
    "Invoke experiment-execution" [shape=box];
    "Results ready?" [shape=diamond];
    "Invoke results-integration" [shape=box];
    "Writing paper?" [shape=diamond];
    "Invoke paper-writing" [shape=box];
    "Respond" [shape=doublecircle];

    "User describes research intent" -> "Domain anchored?";
    "Domain anchored?" -> "Invoke domain-anchoring" [label="no"];
    "Domain anchored?" -> "Direction explored?" [label="yes"];
    "Invoke domain-anchoring" -> "Direction explored?";
    "Direction explored?" -> "Invoke research-direction-exploration" [label="no"];
    "Direction explored?" -> "Problem validated?" [label="yes"];
    "Invoke research-direction-exploration" -> "Problem validated?";
    "Problem validated?" -> "Invoke problem-validation" [label="no"];
    "Problem validated?" -> "Method designed?" [label="yes"];
    "Invoke problem-validation" -> "Method designed?";
    "Method designed?" -> "Invoke method-framework-design" [label="no"];
    "Method designed?" -> "Executing experiments?" [label="yes"];
    "Invoke method-framework-design" -> "Executing experiments?";
    "Executing experiments?" -> "Invoke experiment-execution" [label="yes"];
    "Executing experiments?" -> "Respond" [label="not yet"];
    "Invoke experiment-execution" -> "Results ready?";
    "Results ready?" -> "Invoke results-integration" [label="yes"];
    "Results ready?" -> "Respond" [label="no"];
    "Invoke results-integration" -> "Writing paper?";
    "Writing paper?" -> "Invoke paper-writing" [label="user requests"];
    "Writing paper?" -> "Respond" [label="no"];
    "Invoke paper-writing" -> "Respond";
}
```

## Discipline Skills — Always Active

Once activated, these skills remain in effect for the rest of the project:

| Skill | Activates | What It Enforces |
|-------|-----------|-----------------|
| metric-lock | After G2 | Evaluation metrics cannot be changed without user permission |
| anti-cherry-pick | Phase 4 start | All seeds reported, failures recorded, no selective reporting |
| claim-evidence-alignment | Phase 5-6 | Every claim maps to evidence; unmapped claims deleted |
| figure-quality-standards | Phase 4-6 | Publication-quality figures: style template, colorblind-safe, vector format, consistent colors |
| reproducibility-driven-research | Phase 4 start | Seeds, environments, scripts all recorded |
| results-verification-protocol | Always | No completion claims without fresh verification |

## Meta-Control Skills — Triggered by Conditions

| Skill | Trigger | What It Does |
|-------|---------|-------------|
| novelty-classifier | Phase 1, 3 | Assesses innovation level, warns if just engineering |
| scope-control | Anytime scope expands | Forces scope reduction when contributions > 2 or story splits |
| pivot-or-kill | 3 consecutive failures | Presents pivot/downgrade/kill options to user |
| venue-alignment | Every gate | Checks progress matches venue requirements |

## Critical Enforcement Rules

These rules are NON-NEGOTIABLE:

1. **ONE PHASE PER TURN** (see Absolute Rule #1 above): Complete one phase, present deliverables, STOP, wait for user approval. Never chain phases.
2. **NO PHASE IS OPTIONAL** (see Absolute Rule #2 above): All 7 phases required. Phase 2 required for Type D. Phase 5 multi-agent discussion required.
3. **Run to completion (Type M)**: Every method must execute its full procedure before results are valid. For iterative methods (DL), train to convergence; for non-iterative methods (RF, SVM), fit fully. Partial runs are NOT experiments.
4. **Iterate before moving on (Type M)**: Minimum 3 rounds of diagnose-hypothesize-fix-measure before declaring failure.
5. **Performance bar**: Method must be competitive with baselines before proceeding to results integration.
6. **Explicit user confirmation for paper writing**: User must say "ready for paper" — do NOT auto-proceed. ASK and WAIT.
7. **Minimum paper quality**: ≥3 figures, ≥2 tables, ≥20 references (conference), substantive sections (600+ word intro, 500+ word related work, 400+ word discussion).
8. **Modular LaTeX**: One `.tex` file per section. Present each section to user individually, wait for feedback, revise, then proceed.
9. **Figure quality**: Every figure must pass the per-figure checklist (readable at print size, axis labels with units, colorblind-safe palette, error bars, self-contained caption, vector format). Apply the style template from the first plot onward. Same method = same color in all figures.

## Red Flags

These thoughts mean STOP—you're rationalizing:

| Thought | Reality |
|---------|---------|
| "Let me do the next phase too" | ONE PHASE PER TURN. Stop and wait for user. |
| "Phase 2 isn't needed for this project" | Phase 2 is ALWAYS needed. Type D especially needs adversarial questioning. |
| "The results are done, let me start the paper" | User must say "ready for paper." Ask and wait. |
| "Let me just start coding" | Method design and evaluation protocol come first. |
| "This is a simple analysis" | Simple analyses still need a story line and sufficiency criteria. |
| "I know what metric to use" | Metrics must be discussed, locked, and documented. |
| "Let me run a quick experiment" | No experiments before G2 (plan freeze). |
| "The results look good enough" | Run verification. Show numbers. Evidence before claims. |
| "I'll add more baselines later" | Baselines are locked in G2. Define them now. |
| "This negative result isn't useful" | Negative results ARE results. Record them. |
| "Let me adjust the evaluation" | Metric changes require user authorization. Always. |
| "I remember this skill" | Skills evolve. Read current version. |

## Skill Types

**Rigid** (metric-lock, anti-cherry-pick, verification): Follow exactly. No adaptation.

**Flexible** (exploration, method design): Adapt principles to context and research type.

The skill itself tells you which.

## Research Type Awareness

Every decision must account for the project's research type (from research-anchor.yaml):

- **Type M (Method)**: Performance-driven. Needs baselines, ablations, statistical significance.
- **Type D (Discovery)**: Story-driven. Needs analysis breadth, mechanism exploration, alternative hypothesis exclusion.
- **Type C (Tool)**: Utility-driven. Needs usability, benchmarks, documentation.
- **Type H (Hybrid)**: Dual-track. Needs elements from both M and D.

## User Instructions

User instructions say WHAT, not HOW. "Analyze this data" or "Build a model" doesn't mean skip the research workflow. The workflow tells you HOW.
