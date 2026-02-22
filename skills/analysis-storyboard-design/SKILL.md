---
name: analysis-storyboard-design
description: Use when designing the analysis framework for a discovery or data analysis project — defines story line, analysis dimensions, sufficiency criteria, and alternative explanations to check
---

# Analysis Storyboard Design (Sub-skill of Method Framework Design)

## Overview

Applies to **Type D** and **Type H** projects. A discovery project without a storyboard produces scattered, shallow analyses that fail to tell a coherent scientific story. Design the narrative arc before running the first analysis.

## Step-by-Step Storyboard Design

### 1. Define Main Story Line

Articulate the core narrative:
- **Scientific question:** What are we trying to understand?
- **Expected finding:** What do we predict the data will show?
- **Why it matters:** What changes if this finding holds?

Write as a single paragraph: *"We investigate [question]. We expect to find [prediction] because [reasoning]. This matters because [impact]."*

### 2. Define Supporting Lines

Design 2–4 supporting story lines. Each must validate, extend, or contextualize the main line:

| Line | Purpose | Relationship to Main |
|------|---------|---------------------|
| Supporting Line 1 | *(validates main finding from different angle)* | Validation |
| Supporting Line 2 | *(explores mechanism or cause)* | Explanation |
| Supporting Line 3 | *(tests boundary conditions)* | Robustness |
| Supporting Line 4 | *(reveals unexpected patterns)* | Extension |

Minimum 2 supporting lines. Fewer produces an incomplete story.

### 3. Plan Figures, Tests, and Conclusions per Line

For each story line (main + supporting), specify:

- **Planned figures/tables** — what visualization, what it shows
- **Statistical tests** — what test, what hypothesis it evaluates
- **Expected conclusion** — what result supports the line, what result refutes it

Present to user for confirmation.

### 4. Define Sufficiency Criteria

**IRON LAW: ANALYSIS MUST BE COMPREHENSIVE. NO SHORTCUTS.**

Every box must be checked before the analysis plan is approved:

- □ Descriptive analysis covers complete data overview?
- □ Main hypothesis tested from multiple angles?
- □ Exploratory analysis planned for unexpected patterns?
- □ All supporting lines connect back to main story?
- □ At least 4–6 content points with planned figures/tables?
- □ Confounders identified and addressed?
- □ Statistical support sufficient for each claim?

Any unchecked box → resolve before proceeding.

### 5. Pre-Identify Alternative Explanations

For each expected finding, list plausible alternative explanations that the analysis must rule out:

| Expected Finding | Alternative Explanation | How to Rule Out |
|-----------------|----------------------|-----------------|
| *(fill)* | *(fill)* | *(specific analysis, control, or test)* |

Minimum 2 alternative explanations per major finding. Fewer suggests insufficient critical thinking.

### 6. Define "Done"

State concrete completion criteria:
- All story lines have executed analyses with results
- All sufficiency boxes checked with evidence
- All alternative explanations addressed
- Narrative arc holds or has been revised with justification
- Figures and tables are publication-ready

## Finalization

After user confirms ALL items:

1. Save the complete storyboard to `docs/03_plan/analysis-storyboard.md`
2. Announce: *"Analysis storyboard confirmed. All subsequent analysis work must reference this storyboard. Unplanned analyses are exploratory and must be flagged as such."*

## Red Flags — STOP

- Starting analysis without a defined story line
- Fewer than 2 supporting lines
- No sufficiency criteria defined
- Skipping alternative explanations ("the finding will be obvious")
- No planned figures — analysis without visualization plan produces ad-hoc charts
- Proceeding without user confirmation

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "The data will tell us the story" | Data tells many stories. Choose yours before looking, or you'll hallucinate patterns. |
| "Alternative explanations are premature" | If you can't think of alternatives now, you can't defend against reviewers later. |
| "4–6 content points is too many" | Shallow analysis is the #1 reason discovery papers get rejected. Depth wins. |
| "I'll add supporting lines as I go" | Ad-hoc additions lack coherence. Plan the structure, then fill it. |
| "Sufficiency criteria constrain creativity" | They prevent laziness. Creative insights still emerge within a structured framework. |
