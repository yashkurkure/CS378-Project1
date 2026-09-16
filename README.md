# Cellular Automaton Zoo

A command-line Game-of-Life engine, built from **composable Dart mixins**.
Your job is to fill in a handful of `TODO`s so that different mixins —
rule sets, edge policies, rendering — snap together into a working
simulation, entirely through `with` composition.

## Setup

This project needs the `args` package (for the CLI) and the `test`
package (for `dart test`). Add them yourself:

```bash
dart pub add args
dart pub add dev:test
```

Then run the suite:

```bash
dart test        # currently: 7 passing, 10 failing on your TODOs
```

## What's given vs. what you implement

Everything compiles and runs today — the failing pieces throw
`UnimplementedError()` instead of not existing, so you always have a
runnable program while you work.

| File | Given (worked example) | You implement |
|---|---|---|
| [lib/src/rules.dart](lib/src/rules.dart) | `ConwayRules` (B3/S23) | `HighLifeRules`, `DayAndNightRules`, `SeedsRules` |
| [lib/src/edge_policies.dart](lib/src/edge_policies.dart) | `ToroidalEdges` | `WalledEdges` |
| [lib/src/rendering.dart](lib/src/rendering.dart) | `AsciiRenderable` | `ColorRenderable` (uses `super.render()`) |
| [lib/src/stats.dart](lib/src/stats.dart) | — | `Trackable` (uses `super.step()`) |

Read the worked examples first — each TODO follows the same shape as the
example already sitting next to it in the same file.

`lib/src/cell.dart`, `lib/src/grid.dart`, `lib/src/cellular_automaton.dart`,
and everything in `bin/` are fully given; you shouldn't need to modify them.

## Running it

```bash
dart run bin/cellular_automaton.dart --species=conway --student=yourname
```

`--species` picks a pre-composed mixin combo (`conway`, `highlife`,
`daynight`, `seeds` — see `bin/cellular_automaton.dart` for exactly which
mixins each one uses). `--student` seeds your starting board — same
input always gives you the same board, but it'll differ from your
classmates'. Full flag list in `bin/cellular_automaton.dart`.

## Grading

`dart test` is your rubric — it grades the mixins directly, in
isolation, without needing the CLI to work at all. Get to 17/17.

## Video deliverable

Record a **single continuous take**, screen-shared, terminal and editor
visible. No slides, no pre-written narration — you're demonstrating
understanding live, not reading a summary of it. Cover, in your own
words and on camera:

1. **Break it, on purpose.** Reorder your `with` clause so
   `ColorRenderable` comes *before* whatever provides `render()`
   instead of after. Show the compiler/runtime error live, and explain
   *why* it happens — what does `super.render()` actually resolve to
   in each order?
2. **Predict, then run.** Pick a rule mixin that *isn't* your
   `--species` default. Before running it, say out loud what you
   expect to happen to a small glider or blinker pattern over a few
   generations. Then run it and reconcile what you predicted against
   what happened.
3. **Justify a design choice.** `ToroidalEdges` and `WalledEdges` both
   implement `neighborsOf`. Explain, referencing linearization order,
   what happens if you mix in both — which one "wins," and why.
4. **Explain `Trackable`.** Does it record population before or after
   `super.step()`? Why does that matter for what the recorded numbers
   mean?

A video that only walks through *what* the code does (without the live
break/predict/justify parts) will not receive full credit — the point
is to show you can reason about mixin composition, not just that your
code passes tests.
