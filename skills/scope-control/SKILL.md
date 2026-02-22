---
name: scope-control
description: Use when scope expansion is detected at any phase — enforces focus by quantifying risk and requiring explicit user approval before scope changes
---

# Scope Control (Meta-Control Layer)

## Overview

A focused paper with 1–2 strong contributions beats a scattered paper with 5 weak ones. This skill can trigger at ANY phase when scope expansion is detected.

**Core principle:** Focus is a feature. Scope creep is a bug.

**Violating the letter of this rule is violating the spirit of this rule.**

## Trigger Conditions

Any ONE of these activates this skill:

- Contribution points or innovation claims exceed 2
- Experiment matrix is exploding (too many method × dataset × setting combinations)
- Story line is splitting into unrelated threads
- Time or resource budget is being exceeded
- User adds "one more thing" that substantially changes project scope

## The Mandatory Response

When triggered, the agent MUST execute all four steps in order:

```
1. WARN:     "Current scope may be too large for [target venue] as a single paper."
2. QUANTIFY: "Current experiment plan requires ~X GPU-hours. Budget is Y. Excess: Z%."
             or "There are N contribution points. A focused paper typically has 1-2."
3. PROPOSE:  Reduction options, prioritized:
             a) Core contribution to keep
             b) Items to defer to future work
             c) Items to cut entirely
4. PRESENT:  User decides. Agent cannot decide scope reduction on its own.

Skip any step = scope creep enabled = paper quality at risk
```

## Rules

- The agent proposes reductions but never executes them without user approval.
- Deferred items go into an explicit "future work" log — they are not forgotten, just prioritized out.
- After user decides, update the plan and re-verify scope is within bounds.

## Red Flags — STOP

- Adding a third major contribution
- Experiment table exceeding one page
- Story line requiring two separate introductions
- "Just one more baseline" appearing more than twice
- Resource estimate exceeding budget by more than 30%

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "We can fit it all in" | Page limits exist. Reviewers penalize unfocused papers. |
| "Each piece is small" | Small pieces compound into confusion. |
| "We already did the work" | Sunk cost. Extra work that dilutes the paper hurts more than helps. |
| "The reviewer might ask for it" | Anticipate reviewers, but don't preemptively answer every possible question. |

## The Bottom Line

```
More contributions ≠ better paper
Focused contribution + strong evidence = acceptance
```

Detect expansion. Quantify risk. Propose cuts. Let the user decide.
