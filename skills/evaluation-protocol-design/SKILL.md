---
name: evaluation-protocol-design
description: Use when designing the evaluation protocol for a method development project — locks primary metrics, datasets, seeds, statistical tests, and baseline list into an immutable contract
---

# Evaluation Protocol Design (Sub-skill of Method Framework Design)

## Overview

Applies to **Type M** and **Type H** projects. The evaluation protocol is the contract between you and the scientific community. Once locked, it defines exactly how success is measured. Designing it after seeing results is not design — it is rationalization.

## Step-by-Step Protocol Design

For each item below, present the recommendation to the user as a multiple-choice question where possible. Justify every recommendation. Do NOT proceed to the next item until the user confirms the current one.

### 1. Select Primary Metrics

Propose 1–3 primary metrics. For each:
- **What it measures** (e.g., "F1 measures balanced precision-recall on imbalanced classes")
- **Why it is appropriate** for this task and venue
- **Known limitations** (no metric is perfect — name the gap)

Ask user to confirm or modify.

### 2. Select Evaluation Protocol

Present options with recommendation:
- □ K-fold cross-validation (recommend K=5 or K=10)
- □ Fixed train/val/test split
- □ Leave-one-out
- □ Episode-based evaluation
- □ Other (user specifies)

Justify the recommendation based on dataset size and domain convention.

### 3. Select Datasets

For each proposed dataset:
- **Name and source** (URL or citation)
- **Why included** (covers what aspect of the problem)
- **Size and characteristics** (samples, classes, difficulty)

Minimum: 2 datasets for Tier B venues, 3–5 for Tier A.

### 4. Define Seed Strategy

Recommend 5 seeds: `[42, 123, 456, 789, 1024]`

Present as default. User may modify but must keep ≥ 3 seeds. Fewer than 3 seeds is insufficient for statistical reporting and is not acceptable.

### 5. Define Statistical Reporting

Present options:
- □ mean ± std (minimum acceptable)
- □ mean ± std + 95% confidence interval (recommended)
- □ mean ± std + 95% CI + significance test (recommended for Tier A)

Significance test options: paired t-test, Wilcoxon signed-rank, bootstrap.

### 6. Define Baseline List

**6a. Import from earlier phases:**
- Check `docs/02_literature/baseline-collection.md` for baselines already specified in Phase 1
- Any baseline marked `user_specified` is automatically `must_include`

**6b. Three categories:**
1. **Must-include** — user-specified baselines (from Phase 1) + system-recommended essential comparisons (target: 3–5 total)
2. **Recommended** — strong recent methods the user should consider
3. **User additions** — ask: *"Are there additional methods you believe must be compared?"*

For each baseline, record: name, source (`official_repo` / `our_implementation` / `paper_reported`), configuration, official code URL.

**6c. Pre-computed results:**

For each baseline, ask: *"Do you already have results for this method?"*

If yes, record the pre-computed results and evaluate compatibility with the protocol being defined (see `method-framework-design` M-Step 3b for the full compatibility check). Set `pre_computed.status` in `evaluation-protocol.yaml` to `accepted`, `reference_only`, or `incompatible`.

### 7. Define Execution Completion Criteria

Specify when a method's execution is considered "complete." This depends on the method type:

**For iterative methods (deep learning, gradient descent, EM, etc.):**
- **Maximum iterations/epochs**: upper bound (e.g., 100, 200, 500 — based on domain norms)
- **Early stopping patience**: how many iterations without improvement before stopping (recommend: 5–10)
- **Convergence metric**: which metric to monitor (usually validation loss or primary metric on validation set)
- **Minimum iterations**: lower bound before early stopping can trigger (e.g., 20)

**For non-iterative methods (random forest, SVM, statistical tests, etc.):**
- **Hyperparameter selection**: how hyperparameters are chosen (grid search, random search, Bayesian optimization, domain default)
- **Full data requirement**: method must be fitted on the full training set, not a convenience subset

**For simulation / optimization methods:**
- **Convergence criterion**: what constitutes convergence (e.g., objective change < threshold, residual < tolerance)
- **Maximum compute budget**: wall-clock time or iteration cap

This prevents the critical failure mode of reporting results from an incomplete method execution (e.g., a model trained for 1 epoch, or a pipeline run on 10% of data) as if they were final results.

### 8. Define Fairness Constraints

Confirm each constraint explicitly:
- □ Equal compute budget across all methods
- □ Equal data access (same training data, same preprocessing)
- □ Equal hyperparameter tuning budget
- □ Same hardware and environment for timing comparisons
- □ Official baseline code used where available

## Finalization

After the user confirms **ALL eight items**:

1. Write the complete protocol to `docs/03_plan/evaluation-protocol.yaml`
2. Set `locked: true` in the YAML header
3. Announce: *"Evaluation protocol is now LOCKED. Changes require explicit user authorization through the change request process."*
4. **REQUIRED:** Activate `amplify:metric-lock` skill from this point forward

## Red Flags — STOP

- Selecting metrics without explaining what they measure
- Choosing datasets without rationale
- Using fewer than 3 random seeds
- Omitting fairness constraints for baseline comparison
- Proceeding before user confirms every item
- Locking the protocol without user sign-off

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Everyone uses this metric" | Convention is not justification. Explain why it fits YOUR problem. |
| "One dataset is enough" | One dataset is one perspective. Multiple datasets demonstrate generality. |
| "Three seeds save compute" | Three is the floor. Five is the standard. Budget accordingly. |
| "Baselines are obvious" | Obvious to you ≠ convincing to reviewers. Document every choice. |
| "We can add more baselines later" | You can add. You cannot remove. Lock the minimum set now. |
| "Fairness constraints are implicit" | Implicit = unenforced. Write them down. |
