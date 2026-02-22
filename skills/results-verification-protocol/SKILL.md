---
name: results-verification-protocol
description: Use when about to claim ANY research result status — requires running verification, reading full output, and providing evidence before making claims; always active, no exceptions
---

# Results Verification Protocol (Discipline Layer)

## Overview

Claiming a result without verification is fabrication, not efficiency. This skill is ALWAYS active.

**Core principle:** Evidence before claims, always.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
NO RESULT CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command in this message, you cannot claim the result.

## The Gate Function

```
BEFORE claiming ANY result status:

1. IDENTIFY: What command or check proves this claim?
2. RUN: Execute it now, fresh, complete
3. READ: Full output — every line, every number
4. VERIFY: Does the output actually support the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence attached
5. ONLY THEN: Make the claim

Skip any step = fabrication, not verification
```

## Research-Specific Verification Requirements

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| "Tests pass" | Test output showing 0 failures | "Should pass", previous run |
| "Method outperforms baseline" | Numbers from BOTH methods, statistical test result (p-value/CI) | One method's numbers, "looks better" |
| "Analysis complete" | All analysis outputs present and inspected | Script ran without errors |
| "Experiment finished" | Full results table, all seeds, all conditions | Partial results, single seed |
| "Paper ready" | Checklist of every claim mapped to supporting evidence | "All sections written" |
| "Results are significant" | Statistical test output with exact values | Eyeballing differences |
| "Reproducible" | Independent re-run producing same results | "Same code, should work" |

## Forbidden Phrases

Never use these without attached evidence:

- "should work"
- "looks correct"
- "probably fine"
- "seems good"
- "appears to outperform"
- "likely significant"

Replace with evidence. Every time.

## Red Flags — STOP

- Expressing satisfaction before running verification
- Citing numbers from memory instead of fresh output
- Reporting partial results as complete
- Claiming significance without a statistical test
- Trusting a previous run instead of re-running
- Summarizing results you haven't fully read

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "I'm confident it works" | Confidence ≠ evidence. Run verification. |
| "I just ran it" | Show the output. Fresh evidence for every claim. |
| "The previous run passed" | Previous ≠ current. Run again. |
| "It's just a small change" | Small changes break things. Verify. |
| "I'll verify after finishing everything" | Verify each step. Compound errors are harder to find. |
| "The numbers look right" | Looking ≠ checking. Show the exact output. |

## The Bottom Line

```
Claim without evidence = fabrication
Evidence without fresh run = assumption
```

Run the command. Read the output. Show the numbers. THEN claim the result.

This is non-negotiable.
