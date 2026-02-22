---
name: metric-lock
description: Use when evaluation metrics, protocol, datasets, or splits have been confirmed in the research plan — enforces immutability of locked evaluation components without explicit user authorization
---

# Metric Lock (Discipline Layer)

## Overview

Changing evaluation metrics after confirmation is not optimization — it is goalpost-moving. This skill activates after plan freeze (G2) and remains in effect until project end.

**Core principle:** Locked means locked. No silent modifications.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
EVALUATION METRICS, ONCE CONFIRMED, ARE IMMUTABLE WITHOUT USER PERMISSION
```

## What Is Locked

After G2 plan freeze, the following are immutable:

- **Primary metrics** (e.g., F1, BLEU, AUC)
- **Evaluation protocol** (e.g., k-fold, held-out test, leave-one-out)
- **Datasets and splits** (train/val/test partitions, exact files)
- **Random seeds**
- **Baseline list and their configurations**

## What Is Allowed

Secondary/supplementary metrics may be **added** for additional analysis. They **cannot replace** primary metrics and **cannot** be used to override primary metric conclusions.

## Change Request Process

```
IF you believe a locked item must change:

1. EXPLAIN: What exactly needs to change?
2. JUSTIFY: Why is the current version flawed?
3. PROVE: Show evidence the locked version is defective (not just suboptimal)
4. WAIT: User decides — not you
5. LOG: Record old value, new value, reason in change_log

Skip any step = unauthorized modification = academic misconduct
```

## Red Flags — STOP

- Quietly changing evaluation script parameters
- Reporting a different metric than the one locked
- Weakening baseline configuration after seeing results
- Using a different data split than specified
- Rounding, clipping, or post-processing metrics differently than protocol
- "Forgetting" a baseline that was performing well

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "This metric isn't quite right" | You argued for it in Phase 3. To change, go through the change request process. |
| "A different metric shows better results" | That's exactly why changing is forbidden. |
| "The community now prefers X" | If true, convince the user. Don't change silently. |
| "Just adding a supplementary metric" | Adding secondary is fine. Replacing primary is not. |
| "The baseline used a different metric" | Adapt the baseline, don't change your protocol. |
| "It's a minor adjustment" | Minor adjustments to locked items require user approval. Always. |
| "The metric has a known limitation" | All metrics do. Document the limitation; don't swap the metric. |

## The Bottom Line

```
Locked item + no user approval = do not touch
```

Unauthorized modification of evaluation components is academic misconduct. No exceptions.
