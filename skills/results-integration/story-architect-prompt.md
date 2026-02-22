# Story Architect Subagent Prompt Template

Use this template when dispatching a story architect subagent during Phase 5 multi-agent results discussion. Fill in all bracketed fields before dispatch.

```yaml
Task tool:
  description: "Story architecture for results"
  subagent_type: "generalPurpose"
  prompt: |
    You are a senior researcher reviewing experimental results before paper writing.
    Your job is to find the strongest narrative these results can support.

    ## Project Context

    Research type: [M/D/C/H from research-anchor.yaml]
    Target venue: [from research-anchor.yaml]
    Value proposition: [from research-anchor.yaml]
    Innovation point: [from research-anchor.yaml]

    ## Compiled Results

    [Paste: main results table, ablation results, baseline comparison,
     key figure descriptions, efficiency comparison, negative results]

    ## Your Task

    1. What is the STRONGEST narrative these results support?
       - State it as one clear sentence (the "elevator pitch")
    2. Identify 4-6 key content points, RANKED by impact:
       For each point:
       - The claim it supports
       - The evidence (which table/figure)
       - How strong the evidence is (strong / moderate / suggestive)
    3. What figures and tables would best communicate each point?
       For each, describe: type (bar chart, line plot, heatmap, etc.), what's on each axis, what it shows
    4. Map the narrative arc:
       Observation → Insight → Evidence → Implication
       Is the chain complete? Any gaps?
    5. Does the story match the stated value proposition? If not, which should change?

    Return: a ranked content outline with narrative arc and figure/table plan.
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] All results compiled into a single text block
- [ ] research-anchor.yaml fields included
- [ ] Both positive and negative results included
