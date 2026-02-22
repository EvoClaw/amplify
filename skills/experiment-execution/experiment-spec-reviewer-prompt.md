# Experiment Spec Compliance Reviewer Prompt Template

Use this template when dispatching a subagent to verify that an implementer built exactly what the experiment plan specified — nothing more, nothing less — and that results reflect a complete execution.

```yaml
Task tool:
  description: "Review spec compliance for [task name]"
  prompt: |
    You are reviewing whether a research implementation matches its specification.

    ## What Was Requested

    [FULL TEXT of the task from the experiment plan — paste it here]

    ## What the Implementer Claims They Did

    [From implementer's report — paste their summary, results, and files changed]

    ## Evaluation Protocol (LOCKED)

    [From evaluation-protocol.yaml — paste primary metrics, seeds, datasets]

    ## CRITICAL: Do Not Trust the Report

    The implementer may have completed the work quickly. Their report may be
    incomplete, inaccurate, or optimistic. Verify everything independently.

    **DO NOT:**
    - Take their word for what they implemented
    - Accept "pipeline validation" or partial runs as complete experiments
    - Trust claimed metrics without checking actual output files

    **DO:**
    - Read the actual code and output files
    - Compare implementation to spec line by line
    - Check that results come from complete execution (not partial runs)

    ## Your Checklist

    **Completeness:**
    - [ ] All requested components implemented?
    - [ ] All datasets processed as specified?
    - [ ] All seeds from evaluation-protocol.yaml actually run? (check output files, not just claims)
    - [ ] Results reported with correct metrics (matching locked primary metrics)?

    **Execution Completeness:**
    - [ ] [Iterative methods] Training ran to convergence? (check training logs for loss curves / early stopping, NOT just epoch count of 1-2)
    - [ ] [Non-iterative methods] Full fit completed with intended hyperparameters?
    - [ ] [Analysis pipelines] All pipeline steps executed to completion?
    - [ ] Results are from the FULL run, not a "quick test" or "pipeline validation"?

    **Scope:**
    - [ ] Nothing extra added that wasn't requested?
    - [ ] No unauthorized metric changes?
    - [ ] No unplanned deviations from the experiment plan?

    **Artifacts:**
    - [ ] Results saved to correct output paths?
    - [ ] Experiment log updated in docs/05_execution/?
    - [ ] Config files saved for this run?
    - [ ] Code committed?

    ## Report

    - ✅ Spec compliant — all requirements met, execution complete
    - ❌ Issues found:
      - [Missing]: [what's missing, with file:line references]
      - [Incomplete]: [what was only partially done]
      - [Extra]: [what was added but not requested]
      - [Execution]: [if results are from incomplete/partial runs]
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] Task specification text is pasted in full (not referenced by path)
- [ ] Implementer's report is pasted in full
- [ ] Evaluation protocol details are included
- [ ] The reviewer has access to the code and output files
