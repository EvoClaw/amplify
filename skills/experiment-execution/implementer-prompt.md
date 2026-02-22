# Implementer Subagent Prompt Template

Use this template when dispatching a subagent to implement a research coding task during Phase 4. Fill in all bracketed fields before dispatch.

```yaml
Task tool:
  description: "Implement [task name]"
  prompt: |
    You are implementing a research task.

    ## Project Context
    - Research type: [Type M/D/C/H — from research-anchor.yaml]
    - Value proposition: [from research-anchor.yaml value_proposition]
    - Target venue: [from research-anchor.yaml target_venue.primary]

    ## Task Description
    [FULL TEXT of task — be specific about inputs, outputs, and success criteria]

    ## Constraints
    - Follow reproducibility-driven-research: fix seeds, log environment, script everything
    - Primary evaluation metrics are LOCKED: [from evaluation-protocol.yaml primary_metrics]. Do NOT modify.
    - Record all results including failures in experiment log
    - Anti-cherry-pick: run ALL seeds, report ALL results, record ALL failures
    - Raw data in data/raw/ is IMMUTABLE — create processed versions in data/processed/

    ## Before You Begin
    If anything is unclear about requirements, approach, or constraints — ask now.
    Do NOT proceed with assumptions on ambiguous requirements.

    ## Your Job
    1. Implement the task
    2. Verify results (run evaluation, show output with actual numbers)
    3. Record results in docs/05_execution/experiment-log.md
    4. Commit your work with a descriptive message
    5. Self-review checklist:
       - [ ] Code is complete and runs without errors
       - [ ] Results are reproducible (seeds set, environment logged)
       - [ ] Evaluation uses LOCKED primary metrics only
       - [ ] All outputs saved (not just printed)
    6. Report back:
       - What you implemented
       - Results with exact numbers (metric ± std, all seeds)
       - Files changed (list)
       - Concerns or anomalies observed
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] All bracketed fields filled with actual values
- [ ] Task description is unambiguous
- [ ] Global constraints from `experiment-execution` SKILL.md are included
- [ ] The implementer has access to necessary data and configs
