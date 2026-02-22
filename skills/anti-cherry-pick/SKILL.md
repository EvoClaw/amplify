---
name: anti-cherry-pick
description: Use when Phase 4 (experiment execution) begins — enforces complete reporting of all seeds, all results, and all failures; remains active until project end; prevents selective reporting of favorable outcomes
---

# Anti-Cherry-Pick (Discipline Layer)

## Overview

Selective reporting is not curation — it is fabrication. This skill activates at Phase 4 start and remains active until project end. Every experimental result, favorable or not, is recorded and reported.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
NO SELECTIVE REPORTING. ALL SEEDS, ALL RESULTS, ALL FAILURES.
```

## Mandatory Reporting Rules

1. **All seeds, always.** Run ALL pre-defined seeds from `evaluation-protocol.yaml`. Report mean ± std or mean [95% CI]. Never report a single seed.

2. **Negative results are data.** Failed experiments and negative results go in `docs/05_execution/negative-results.md`. They cannot be silently dropped, deleted, or omitted from the final report.

3. **Fair baselines.** Baselines must use fair configurations: same compute budget, same data, same preprocessing pipeline, same hyperparameter search budget. No handicapping.

4. **Equivalent access.** If your method uses pretrained models, extra data, or external resources, baselines must have equivalent access. Asymmetric advantage is not a fair comparison.

5. **All datasets.** If a dataset is listed in `evaluation-protocol.yaml`, report results on it. You cannot include only favorable datasets and hide unfavorable ones.

6. **Equal tuning.** The same hyperparameter search budget applies to all methods. You cannot exhaustively tune your method while giving baselines default parameters.

## Red Flags — STOP

- Reporting only the best seed out of multiple runs
- Using different hyperparameter search budgets for own method vs. baselines
- Silently dropping a dataset where results are unfavorable
- Giving baselines a weaker configuration than your method
- Omitting a failed experiment from the record
- Reporting results before all seeds have completed

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "This seed gave bad results" | Report ALL seeds. One bad seed in five is expected variance, not grounds for exclusion. |
| "The baseline code didn't work well" | Your implementation may be unfair. Use official code or explicitly acknowledge the discrepancy. |
| "This dataset isn't standard" | If you included it in `evaluation-protocol.yaml`, you report it. Remove it only through the change request process. |
| "Our method needs more tuning" | Same tuning budget for all methods. Equal effort, equal opportunity. |
| "The failure was due to a bug" | Fix the bug, re-run ALL experiments from scratch, report the new results. Partial re-runs are not acceptable. |
| "Negative results aren't interesting" | They are data. Record them. They prevent others from repeating your mistakes. |
| "This variant isn't worth reporting" | If you ran it, you report it. Let the reader decide what's worth noting. |
| "We'll include it in the appendix" | Appendix is acceptable for space. Omission is not. Ensure it is referenced from the main text. |

## The Bottom Line

```
Favorable results only = fiction
Complete results = science
```

Report everything. Hide nothing. This is non-negotiable.
