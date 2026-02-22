---
name: reproducibility-driven-research
description: Use when implementing any experiment, analysis, or computational task — enforces the HYPOTHESIZE-BASELINE-EXPERIMENT-VERIFY-INTERPRET cycle and reproducibility requirements
---

# Reproducibility-Driven Research (Discipline Layer)

## The Iron Law

```
NO EXPERIMENT WITHOUT PREDEFINED SUCCESS CRITERIA AND BASELINE FIRST
```

This skill is active for every computational task — experiments, analyses, data processing, model training. No exceptions. No "quick checks."

## The HBEVI Cycle

Like RED-GREEN-REFACTOR for software, research follows HYPOTHESIZE-BASELINE-EXPERIMENT-VERIFY-INTERPRET. Every cycle produces one atomic, reproducible unit of evidence.

### 1. HYPOTHESIZE

Before running anything, write down:
- **Hypothesis:** what you expect to observe and why
- **Prediction:** specific, falsifiable outcome (e.g., "Method X improves F1 by ≥ 2 points over baseline Y on dataset Z")
- **Success criteria:** what result supports the hypothesis, what result refutes it

Write it down. If you cannot state the prediction, you do not understand the experiment.

### 2. BASELINE

Run the baseline or known result first.
- Reproduce the expected baseline number before testing your method
- If the baseline fails to reproduce within expected tolerance → **STOP**
- Investigate: environment mismatch, data issue, implementation bug
- Do NOT proceed until baseline reproduces

A method that "beats" an unreproduced baseline proves nothing.

### 3. EXPERIMENT

Execute the experiment with full controls:
- **One variable at a time.** If you change two things, you cannot attribute the result.
- **Fixed random seeds.** Use seeds from `evaluation-protocol.yaml`.
- **Logged environment.** Record library versions, hardware, OS, CUDA version.
- **Scripted execution.** No manual steps. If it is not in a script, it is not reproducible.

### 4. VERIFY

Statistical verification — not eyeballing:
- Run ALL pre-defined seeds
- Report mean ± std and/or 95% confidence intervals
- Apply the significance test specified in the evaluation protocol
- "It looks better" is not verification. Show the numbers.

If results are within noise of the baseline, that is a null result — record it as such.

### 5. INTERPRET

Whether the result supports or refutes the hypothesis:
- **Supports:** record the evidence and the magnitude of the effect
- **Refutes:** record what was learned and why the prediction was wrong
- **Ambiguous:** record what additional experiment would disambiguate

Both positive and negative results are data. Record both with equal care.

## Requirements Always in Effect

These are non-negotiable for every computational task:

- **All experiments fix random seeds** — no unseeded randomness
- **All experiments log complete environment** — library versions, hardware, OS
- **All data preprocessing is scripted** — no manual Excel edits, no copy-paste
- **Raw data is immutable** — never modify original data files
- **Every meaningful result gets a git commit** — with descriptive message
- **Experiment configs saved alongside results** — configs and outputs in the same directory
- **No manual steps in the pipeline** — if a human must intervene, script it

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Just a quick test, no need to log" | Quick tests become final results. Log everything. |
| "I'll set seeds later" | Later = never. Set them now. |
| "The baseline is well-known" | Reproduce it anyway. Your setup may differ. |
| "One run is enough to see the trend" | One run is anecdote. Multiple seeds are evidence. |
| "I'll clean up the code later" | Dirty code = unreproducible code. Clean as you go. |
| "Manual preprocessing is faster" | Faster now, unreproducible forever. Script it. |
| "The environment doesn't matter" | It does. Library version differences cause silent result changes. |
| "Git commits slow me down" | Losing results slows you down more. Commit after every meaningful run. |

## Red Flags — STOP

- Running experiments without stating a hypothesis first
- Skipping baseline reproduction ("it's a known number")
- Changing two variables simultaneously
- Reporting results from a single seed
- Manual data processing steps in the pipeline
- No environment logging
- Unseeded random operations
- Results without corresponding config files

## The Bottom Line

```
Unreproducible results are not results.
They are anecdotes with extra steps.
```

Follow the cycle. Log everything. Reproduce baselines. Fix seeds. Script all steps. This is the minimum standard for computational research.
