# Architecture vocabulary for data estates

Use these terms exactly. The ideas come from software design (deep modules from John Ousterhout, seams from Michael Feathers) and are restated here for pipelines and data.

## Terms

**Module.** Anything with an interface and an implementation, at any scale: a transformation step, a job, a published dataset, a whole pipeline. Avoid "component", "layer", and "service" when you mean this.

**Interface.** Everything a consumer has to know to use the module correctly. For data that is the contract: structure, grain, keys, meaning of each field, freshness, how late or corrected data appears, and how failure shows. A published table whose consumers must know that three statuses have to be excluded has those exclusions in its interface, whether or not anyone wrote them down.

**Implementation.** What sits inside the module: the extraction, joins, rules, and state handling the consumer does not need to see.

**Depth.** Leverage at the interface: how much behaviour a consumer gets per thing they have to learn. A module is **deep** when a lot of logic sits behind a small contract, for example one clean dataset that hides the source's quirks. It is **shallow** when the contract is nearly as complicated as what is behind it, for example a hop that copies a source table and leaves every consumer to handle its quirks.

**Seam.** A place where behaviour can be changed without editing what is on either side: the point where a source could be swapped, or a consumer repointed. Avoid "boundary".

**Adapter.** A concrete thing that satisfies an interface at a seam: the connector for one specific source, or a fixed set of sample records standing in for it in a test.

**Leverage.** What consumers gain from depth. One definition serves every report, export, and integration that needs it.

**Locality.** What the maintainer gains from depth. A rule, its bugs, and its tests live in one place, so a change is made once.

## Principles

- **Depth belongs to the interface.** A deep module can be built from many small internal steps. They are not part of the contract.
- **The deletion test.** Imagine deleting the module. If complexity disappears, it was a pass-through. If it reappears in every consumer, the module was earning its place.
- **The interface is the test surface.** Tests feed inputs in and compare outputs at the contract. If a test has to reach inside to check something, the module is the wrong shape.
- **One adapter is a hypothetical seam. Two is a real one.** Do not build a generic, configurable framework for a single source. Introduce a seam when something really varies across it, which usually means a real source plus a test stand-in.

## What shallowness looks like in data

- The same measure computed separately in several reports or queries (no locality).
- A chain of hops that each copy data onward (deleting any of them loses nothing).
- A consumer reading an intermediate object (the seam leaks).
- A rule split across tools, so no single place shows the whole of it.
- Jobs coordinated by clock time (the dependency is part of the interface but is written nowhere).

## Dependency categories

Classify what a candidate depends on. The category decides how the deepened module is tested.

1. **Pure transformation.** No input or output beyond the data passed in. Always deepenable. Test with fixed inputs and expected outputs.
2. **Locally substitutable.** A store or engine that has a local or development stand-in, or can be fed a sample extract. Test against the stand-in.
3. **Remote but owned.** Another internal system across a network. Put a seam there, with the real connector as one adapter and fixed sample records as the other.
4. **External.** A third party's interface you do not control. Same pattern, using recorded responses as the test adapter.

## Testing after deepening

- Write tests at the new contract and delete the tests on the shallow pieces it replaced. Keeping both is waste.
- Tests assert on outputs, not on internal state, so they survive changes to the implementation.
- For data there is one extra step code does not have: run old and new side by side on real inputs and reconcile them before consumers move.
