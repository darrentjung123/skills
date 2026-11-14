# Report format

The review is delivered as one visual report. The diagrams carry the argument and the prose stays sparse.

## Form

- If the environment can produce a file or a rendered page, write a single self-contained HTML document: styles inline, diagrams as inline SVG or plain positioned boxes, no dependency on anything that has to be fetched. Do not write it into the user's repository unless they ask.
- If it cannot, write the same content as Markdown, with a text or Mermaid diagram for each candidate.

## Header

The name of the estate or area reviewed, the date, what was examined, and what could not be reached. Then a short legend: solid box for a module, dashed line for a seam, red arrow for a leak across a seam, heavy box for a deep module. No introduction. Go straight to the candidates.

## Candidate card

- **Title:** short, naming the deepening, such as "One definition of net sales".
- **Badges:** strength (`Strong`, `Worth exploring`, `Speculative`) and dependency category.
- **Where:** the pipelines and objects involved.
- **Before and after diagram:** the centrepiece, side by side.
- **Problem:** one sentence.
- **Change:** one sentence.
- **Wins:** short bullets in the vocabulary's terms, such as "locality: the rule lives once" or "leverage: one contract, six consumers". Avoid "cleaner" and "easier to maintain", which say nothing checkable.
- **Cutover cost:** consumers affected, parallel run needed or not, history to rebuild.
- **Decision-record callout,** if the candidate contradicts a recorded decision.

If a diagram needs a paragraph to explain it, redraw the diagram.

## Diagram patterns

Pick the one that fits and vary them between candidates.

- **Hop chain collapse.** Before: a row of thin boxes each passing data on. After: one heavy box, with the former hops faded inside it.
- **Many definitions to one.** Before: several consumers each holding their own copy of a rule. After: one module holding it, with the consumers pointing at its contract.
- **Leak across a seam.** Before: a red arrow from a consumer into an intermediate object. After: the arrow lands on the published contract.
- **Clock coupling to explicit dependency.** Before: jobs on a timeline with a gap between them and nothing joining them. After: an arrow from one to the next.
- **Interface versus implementation.** Two rectangles per module. Before: the interface is nearly as tall as the implementation. After: a short interface over a tall implementation.

## Top recommendation

One larger card at the end: the candidate to do first and one sentence on why. If nothing is worth doing, say that here.

## Tone

Plain and brief. Use the vocabulary's nouns without ceremony: "the returns feed is shallow", "the rule leaks into four reports", "two adapters justify the seam". No hedging and no preamble.
