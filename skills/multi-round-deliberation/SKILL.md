---
name: multi-round-deliberation
description: Reusable protocol for multi-agent discussions that iterate until convergence. Used by results-integration (Phase 5) and paper-writing (Phase 6) to ensure discussions actually resolve issues rather than just noting them.
---

# Multi-Round Deliberation Protocol

## Overview

A single round of feedback is NOT a discussion. Real deliberation requires iteration: agents identify issues → someone fixes them → agents verify the fix → repeat until resolved. This protocol standardizes this loop across all phases.

## The Problem with Single-Round Feedback

```
WRONG (current anti-pattern):
  3 agents give opinions → main agent "synthesizes" → done
  → Issues may be noted but never actually resolved
  → No verification that fixes addressed the concerns

RIGHT (this protocol):
  3 agents give opinions → main agent modifies artifact → 
  agents re-check → if unresolved, modify again → 
  repeat until convergence or max rounds
```

## Core Protocol

### Shared Value Framework (prevents divergence)

All agents in a deliberation share these values, injected into every prompt:

```
SHARED VALUES (inject into every agent prompt in this deliberation):
═══════════════════════════════════════════════════════════════════
Target venue: [from research-anchor.yaml]
Value proposition: [from research-anchor.yaml]
Research type: [from research-anchor.yaml]

OPTIMIZATION TARGET: "Would this survive peer review at [target venue]?"

SCORING RUBRIC (default — phases may override; see phase-specific sections):
  - PASS: No fatal or major issues. Ready to proceed.
  - CONDITIONAL: Major issues exist but are addressable. Needs another round.
  - FAIL: Fatal issues. Fundamental rethinking needed.

CONVERGENCE RULE: Deliberation ends when ALL agents score PASS, 
or when max rounds are reached and remaining issues are presented to user.

ANTI-DIVERGENCE: If you disagree with another agent's feedback, 
state specifically WHY and propose a CONCRETE alternative. 
"I disagree" without a counter-proposal is not constructive.
═══════════════════════════════════════════════════════════════════
```

### Deliberation Loop

```
┌─────────────────────────────────────────────────────┐
│  ROUND N                                            │
│                                                     │
│  1. ASSESS (parallel)                               │
│     Dispatch ALL agents with current artifact        │
│     Each returns: issues + verdict (PASS/COND/FAIL) │
│                                                     │
│  2. CHECK CONVERGENCE                               │
│     All PASS? → END (consensus reached)             │
│     Any FAIL or COND + round < max? → go to step 3  │
│     Max rounds (5) reached? → END (present to user) │
│                                                     │
│  3. MODIFY                                          │
│     Main agent (you) incorporates feedback:          │
│     - Fix all issues marked as addressable           │
│     - For disagreements: choose the stronger argument│
│     - Update the artifact                            │
│                                                     │
│  4. FULL RE-ASSESS (next round)                     │
│     Dispatch ALL agents again with:                  │
│     - The complete modified artifact                 │
│     - Summary of changes made since last round       │
│     - Previous round's issues for reference          │
│     All agents review the full artifact — not just   │
│     their own previous concerns — because            │
│     modifications can introduce new issues.          │
│                                                     │
│  → Back to step 2                                   │
└─────────────────────────────────────────────────────┘
```

### Round Limits (non-negotiable)

| Context | Max Rounds | Rationale |
|---------|-----------|-----------|
| Phase 5 story design | 5 | High-stakes — the story determines the paper's quality |
| Phase 6 per-section polishing | 5 | Each section must be thoroughly vetted |
| Phase 6 full-paper review | 5 | Full-paper coherence is critical |

### Convergence Criteria

Deliberation ends (consensus) when ALL of:
- No agent gives verdict "FAIL"
- No remaining issues tagged "fatal" or "critical"
- All agents explicitly state their concerns from previous rounds are addressed

### Non-Convergence Handling

If max rounds reached and agents still disagree:

```
DELIBERATION SUMMARY (presented to user):
══════════════════════════════════════════

Rounds completed: N / max N
Final verdicts: Agent A: [PASS/COND/FAIL], Agent B: [...], Agent C: [...]

RESOLVED issues (N):
  ✅ [issue] — addressed in round [N] by [change]

UNRESOLVED issues (N):
  ⚠️ [issue] — Agent [X] says: "[position]"
              — Agent [Y] says: "[counter-position]"
              — My recommendation: [your judgment]

DECISION NEEDED from you:
  1. [Option A — side with Agent X]
  2. [Option B — side with Agent Y]
  3. [Option C — compromise you propose]
  4. Run one more round of discussion
```

### Full Re-Assessment Every Round

Every round, dispatch ALL agents with the complete modified artifact. Do NOT skip any agent — modifications to address one agent's concerns can introduce new issues that another agent would catch.

**Re-assessment prompt template (used for Round 2+):**

```
Call Task tool with:
  description: "[agent role] — round [N] review"
  prompt: |
    [SHARED VALUES block]
    
    This is round [N] of deliberation. In the previous round, 
    you and other agents raised these concerns:
    ===
    YOUR previous concerns:
    [paste this agent's issues from last round]
    
    OTHER agents' concerns (for context):
    [paste summary of other agents' issues]
    ===
    
    Changes made since last round:
    ===
    [paste summary of what changed and why]
    ===
    
    COMPLETE MODIFIED ARTIFACT:
    [paste the full updated artifact]
    
    Review the COMPLETE artifact (not just the changes). Modifications 
    can introduce new issues. Answer:
    
    1. For EACH of your previous concerns: RESOLVED / PARTIALLY / NOT ADDRESSED
    2. Any NEW issues introduced by the modifications?
    3. Any issues with how OTHER agents' concerns were addressed?
    4. Overall verdict: PASS / CONDITIONAL / FAIL
    
    If CONDITIONAL or FAIL: state exactly what remains to be fixed.
  subagent_type: "generalPurpose"
```

### Agent Disagreements

When agents directly contradict each other (e.g., Story Architect says "lead with stability" but Audience Specialist says "lead with monocyte substructure"):

1. **Present both positions** with their reasoning
2. **Evaluate evidence**: which position is better supported by the actual results and venue expectations?
3. **Choose the stronger argument** for the modification
4. **In re-assessment**: tell the overruled agent what you chose and why — they may accept or push back with new arguments
5. **If persistent disagreement after 2 rounds**: present to user as a strategic choice

### Anti-Patterns to Avoid

| Anti-pattern | Why it's wrong | What to do instead |
|-------------|---------------|-------------------|
| Accepting "CONDITIONAL" without asking what's needed | "Conditional" means there ARE remaining issues | Ask the agent to specify exactly what remains |
| Running max rounds mechanically even when consensus reached in round 1 | Wastes time and tokens | Check convergence after every round; stop early if PASS |
| Ignoring one agent's feedback because the other two disagree | Minority opinion may be right | Address the concern or explain why it's overruled |
| "Synthesizing" by averaging opinions | Synthesis is not averaging | Choose the strongest argument for each issue |
| Skipping agents in later rounds to "save cost" | Fixes can introduce new issues that other agents would catch | Dispatch ALL agents every round |

## Integration with Phases

### Phase 1 — Idea Brainstorming

```
Artifact being deliberated: 5 candidate research ideas (idea cards from Step 5c)
Agents: Visionary Researcher, Pragmatic Advisor, Field Scout
Max rounds: 5

SCORING RUBRIC (Phase 1 override — ideas are not pass/fail):
  - STRONG: High-potential idea. Clearly novel, feasible, and well-positioned.
  - VIABLE: Promising but needs refinement. Addressable concerns exist.
  - WEAK: Significant issues (novelty, feasibility, or positioning). Salvageable only 
    if combined with another idea or substantially reworked.
  - KILL: Fatal flaw (already done, infeasible, or no clear contribution). Remove.

  Mapping to core protocol: STRONG = PASS, VIABLE = CONDITIONAL, WEAK/KILL = FAIL.
  Convergence uses Phase 1 rubric (STRONG/VIABLE), not core rubric (PASS/CONDITIONAL).

Convergence: Agents agree on a ranking of top 2-3 ideas (all rated STRONG or VIABLE)
Modifier: Main agent merges, splits, refines, or eliminates ideas between rounds
Re-assessment: ALL 3 agents review complete modified idea set every round
Special rules:
  - Ideas can die, merge, or be born during brainstorming
  - Visionary can propose new combinations of existing ideas
  - If ALL ideas rated WEAK or KILL by majority → trigger "Idea Rescue" (see below)
  - On-demand literature search allowed mid-deliberation (e.g., Scout needs to check competition)

Idea Rescue (when all ideas fail):
  1. Agents identify WHY all ideas failed — common root cause?
  2. Trigger broadened literature search targeting the identified gap
  3. Main agent generates 3 new idea cards based on rescue search results
  4. Resume deliberation with new ideas (round counter does NOT reset)
  5. If still no STRONG/VIABLE after max rounds → present situation to user with 
     explanation of what was tried and why it failed. User decides next steps.
```

### Phase 2 — Research Question Deliberation

```
Artifact being deliberated: Research Question

Type M/D/H agents: Senior Professor, Journal/Conference Editor, Research Scientist (PhD/Postdoc)
Type C agents: Target User Representative, Journal/Conference Editor, Software Architect

Max rounds: 5
Convergence: All 3 give PASS on the research question
Modifier: Main agent refines question between rounds
Re-assessment: ALL 3 agents review complete refined question every round
Special rule (Type M/D/H): Professor "FAIL — not novel" persistent for 2+ rounds → present to user immediately
Special rule (Type C): Target User "FAIL — no real pain point" persistent for 2+ rounds → present to user immediately
```

### Phase 3 — Method/Framework Design Deliberation

```
Type M artifact: Method design (innovation point, architecture, baselines, ablations)
Type M agents: Innovation Advisor, Technical Architect, Baseline Devil's Advocate

Type D artifact: Analysis framework (analysis plan, sufficiency criteria, alternatives)
Type D agents: Domain Scientist, Methodology Consultant, Statistical Rigor Advisor

Type C artifact: Tool design (utility claim, evaluation framework, competing tools, case studies)
Type C agents: Target User, Competing Tool Expert, Software Quality Advisor

Max rounds: 5
Convergence: All 3 give PASS on the design
Modifier: Main agent refines design between rounds (may search additional literature)
Re-assessment: ALL 3 agents review complete refined design every round
Special rule: If any agent flags missing literature → search before next round
```

### Phase 5 — Story Design Deliberation

```
Artifact being deliberated: Argument Blueprint
Agents: Story Architect, Devil's Advocate, Audience Specialist
Max rounds: 5
Convergence: All 3 give PASS on the blueprint
Modifier: Main agent rewrites blueprint between rounds
Re-assessment: ALL 3 agents review complete blueprint every round
Special rule: Devil's Advocate "fatal" on novelty → HARD BLOCK (no amount of rounds fixes missing novelty)
```

### Phase 6 Per-Section — Writing Polishing Deliberation

```
Artifact being deliberated: One LaTeX section
Agents: Domain Expert, Writing Editor, Adversarial Reviewer
Max rounds: 5
Convergence: All 3 give PASS; authority score ≥ 7
Modifier: Main agent rewrites section between rounds
Re-assessment: ALL 3 agents review complete section every round
Special rule: If Adversarial Reviewer verdict "NO" after final round → trigger Cross-Critique (Phase B2)
```

### Phase 6 Full-Paper — Final Review Deliberation

```
Artifact being deliberated: Complete paper
Agents: Proofreader, Domain Expert, Adversarial Reviewer #2
Max rounds: 5
Convergence: No FATAL/CRITICAL issues remaining
Modifier: Main agent fixes specific sections between rounds
Re-assessment: ALL 3 agents review complete paper every round
Special rule: "EXPERIMENT NEEDED" from any agent → return to Phase 4 (not fixable by more rounds)
```
