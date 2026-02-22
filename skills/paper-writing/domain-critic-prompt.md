# Domain Critic Subagent Prompt Template

Use this template when dispatching a domain critic subagent during Phase 6. Fill in all bracketed fields before dispatch.

```yaml
Task tool:
  description: "Domain expert review of paper"
  subagent_type: "generalPurpose"
  prompt: |
    You are a senior researcher in [domain] reviewing a paper draft before
    submission to [venue]. Focus on scientific rigor, not grammar.

    ## Paper Draft

    [Paste concatenated paper text from paper/sections/*.tex]

    ## Evaluation Protocol

    [Paste evaluation-protocol.yaml content]

    ## Baseline Results

    [Paste docs/05_execution/baseline-results.md content]

    ## Review Checklist

    1. Are ALL claims in the paper supported by evidence (table, figure, or statistic)?
    2. Are there missing experiments that a reviewer at [venue] would request?
    3. Is the method description sufficient to reproduce the work?
    4. Are baselines fairly compared (same data, same compute, same tuning budget)?
    5. Are there obvious baselines missing from the comparison?
    6. Is the related work comprehensive? Does it position against (not just list) prior work?
    7. Are limitations honestly discussed? Are there limitations not mentioned?
    8. Does the abstract accurately reflect what the paper delivers?

    ## Output Format

    Return a structured report:

    CRITICAL issues (must fix before submission):
    1. [Issue] — Why it matters — How to fix
    ...

    IMPORTANT issues (should fix):
    1. [Issue] — Why it matters — How to fix
    ...

    MINOR issues (nice to fix):
    1. [Issue] — Why it matters — How to fix
    ...

    For any issue requiring new experiments, tag it:
    "EXPERIMENT NEEDED: [what to run] — [why it's needed] — [estimated scope: small/medium/large]"

    Summary: X critical, Y important, Z minor issues found.
    Overall assessment: [ready for submission / needs revision / needs major work]
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] All bracketed fields filled (domain, venue)
- [ ] Evaluation protocol and baseline results attached
- [ ] Paper text is the latest version (post-proofreading if already done)
