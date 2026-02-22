# Reproducibility Reviewer Subagent Prompt Template

Use this template when dispatching a subagent to verify that experimental results can be independently reproduced. Run this before declaring any results final.

```yaml
Task tool:
  description: "Review reproducibility for [task]"
  prompt: |
    You are verifying that results can be reproduced by an independent party.

    ## Claimed Results
    [From experiment report — include exact numbers, datasets, and conditions]

    ## Your Checklist

    **Randomness Control:**
    - [ ] Random seeds explicitly set and recorded for all sources of randomness
    - [ ] Seeds match those specified in evaluation-protocol.yaml
    - [ ] No uncontrolled randomness (e.g., data loading order, GPU non-determinism documented)

    **Environment Specification:**
    - [ ] Environment fully specified (Python version, library versions, CUDA version)
    - [ ] Hardware documented (GPU model, CPU, RAM)
    - [ ] environment.yml or requirements.txt is complete and pinned

    **Data Pipeline:**
    - [ ] Data preprocessing is fully scripted (no manual steps)
    - [ ] Raw data untouched — all processing creates new files in data/processed/
    - [ ] Data download/acquisition is scripted
    - [ ] Train/val/test splits are deterministic and saved

    **Experiment Execution:**
    - [ ] All experiment configs saved in experiments/configs/
    - [ ] Run scripts exist that reproduce each experiment end-to-end
    - [ ] Results match what scripts would produce if re-run
    - [ ] Git commit hash recorded for each experiment run

    **Documentation:**
    - [ ] repro/README.md contains step-by-step reproduction instructions
    - [ ] repro/run_all.sh exists and is functional
    - [ ] Expected results documented in repro/expected_results/

    ## Verification

    If possible:
    1. Re-run the key experiment using saved configs and scripts
    2. Compare output with claimed results
    3. Report any discrepancies with exact numbers

    If re-run is not possible (resource/time constraints):
    1. Verify all scripts exist and are syntactically complete
    2. Verify configs match what was reported
    3. Verify environment spec is complete
    4. Flag this as "verified-by-inspection" (not "verified-by-rerun")

    ## Your Report

    For each checklist item, provide:
    - ✅ Verified — with specific evidence
    - ❌ Gap — with specific missing element and how to fix it

    ## Summary
    - Reproducibility status: REPRODUCIBLE / GAPS FOUND / NOT VERIFIABLE
    - Verification method: re-run / inspection
    - Critical gaps (must fix): [list]
    - Recommendations: [list]
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] Experiment report with claimed results is attached
- [ ] The reviewer has access to the code repository
- [ ] Sufficient resources are available if re-run verification is expected
