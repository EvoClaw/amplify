---
name: alternative-hypothesis-check
description: "Use when analyzing results in Type D or Type H projects before making mechanistic or causal claims — requires systematic exclusion of confounders, batch effects, technical noise, and other alternative explanations"
---

# Alternative Hypothesis Check

**Discipline layer skill.** Active during Phase 4–5 for Type D and Type H projects.

## Iron Law

`NO MECHANISM CLAIMS WITHOUT EXCLUDING ALTERNATIVE EXPLANATIONS`

## Systematic Check

For each major finding, systematically check:

- □ **Confounders** — variables that could explain the association independently of your proposed mechanism
- □ **Batch effects** [bioinformatics] — technical variation masquerading as biology (plate, lane, date, operator)
- □ **Technical noise** — measurement artifacts, instrument drift, reagent lot differences
- □ **Sample selection bias** — non-random inclusion criteria that correlate with the outcome
- □ **Multiple testing inflation** — testing many hypotheses means some will be significant by chance; confirm FDR/Bonferroni was applied
- □ **Correlation ≠ causation** — temporal precedence, dose-response, and intervention evidence must be present before causal language is used

## When an Alternative Explanation Cannot Be Excluded

If an alternative explanation **cannot** be excluded:

→ It **must** be stated as a limitation in the paper
→ Language **must** be weakened ("associated with" not "causes")
→ It **cannot** be presented as a mechanistic finding

## Checklist Format

For each finding, produce a table:

| Finding | Alternative checked | Excluded? | Evidence |
|---------|-------------------|-----------|----------|
| ... | Confounder X | Yes / No | ... |

## Rationalization Firewall

| You will hear yourself say... | Reality check |
|-------------------------------|---------------|
| "The effect is too strong to be confounding" | Strong effects can still be confounded. Check anyway. |
| "We controlled for the obvious variables" | Obvious to you. What about reviewer #2's favorite confounder? |
| "Correlation is enough for this paper" | Correlation is enough only if you DON'T claim mechanism. |
| "Batch correction was applied" | Did you verify it worked? Show before/after. |
