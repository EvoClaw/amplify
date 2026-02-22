# Devil's Advocate Subagent Prompt Template

Use this template when dispatching a devil's advocate subagent during Phase 5 multi-agent results discussion. Fill in all bracketed fields before dispatch.

```yaml
Task tool:
  description: "Devil's advocate review of results"
  subagent_type: "generalPurpose"
  prompt: |
    You are a skeptical reviewer examining research results BEFORE they become a paper.
    Your job is to find every vulnerability, gap, and alternative explanation.
    Be thorough and honest — it is better to find problems NOW than after submission.

    ## Project Context

    Research type: [M/D/C/H from research-anchor.yaml]
    Evaluation protocol: [paste evaluation-protocol.yaml content]

    ## Compiled Results

    [Paste: main results table, ablation results, baseline comparison,
     key figure descriptions, efficiency comparison, negative results]

    ## Your Task

    1. For each key finding, list alternative explanations:
       - Could this be due to [data leakage / overfitting / selection bias / confounders]?
       - Is there a simpler explanation that doesn't require the proposed method?
    2. Which claims are WEAKLY supported?
       - What additional evidence would make them convincing?
    3. What experiments or analyses are MISSING?
       - What would a harsh reviewer at [target venue] demand?
    4. Are there any methodological red flags?
       - Unfair comparison, insufficient seeds, partial execution, metric gaming
    5. If you had to write a rejection review, what would be your top 3 reasons?

    Return a vulnerability report:
    For each vulnerability:
    - Description
    - Severity: fatal / major / minor
    - How to address it
    - Tag: EXPERIMENT NEEDED (if new experiments required) or WRITING FIX (if addressable in text)
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] Evaluation protocol included (so reviewer can check compliance)
- [ ] ALL results included, including negative results and failures
- [ ] Target venue specified for calibrating severity
