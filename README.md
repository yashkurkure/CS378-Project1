# Dart Project: Cellular Automaton Zoo

In this project you will build a Dart application simulating cellular
automata. A cellular automaton is a grid of individual cells that change
state over discrete time steps by following a simple set of local rules.
Below is an example of what one may look like:

![Cellular automaton animation](cellular_automaton.gif)

## Background

In the 2D grid, each cell is either alive or dead. In the animation above,
a cell is colored black if alive and white if dead. Simple rules like the
following govern the animation:

1. Any live cell with fewer than two live neighbors dies (as if by
   loneliness).
2. Any live cell with two or three live neighbors lives on to the next
   generation.
3. Any live cell with more than three live neighbors dies (as if by
   overcrowding).
4. Any dead cell with exactly three live neighbors becomes alive (as if by
   reproduction).

This is [Conway's Game of Life](https://youtu.be/R9Plq-D1gEk?si=x4bpcwctv4KS1e9b).

At each timestep, the program iterates over the grid and computes the next
state based on the rules above. The rules can also be denoted with the
shorthand **B3/S23**, where B stands for Birth and S stands for Survival:
a dead cell becomes alive if it has exactly 3 neighbors (B3), and a living
cell stays alive if it has 2 or 3 neighbors (S23). Changing the B/S numbers
produces different variants of the same game. You will implement:

- B3/S23 (Conway's Rule)
- B36/S23 (HighLife)
- B3678/S34678 (Day and Night)
- B2/S (Seeds)

A cell's neighbor count depends on how the grid's edges are handled, since
not every cell in the grid has the same number of neighbors. You will
implement two ways of considering neighbors:

1. **Walled edges** — corners have three neighbors, edges have six.
2. **Toroidal edges** — the grid wraps around to the other side, so every
   cell has eight neighbors.

A plethora of different animations can be produced just by changing the
grid size, the rule set, and the edge policy. The goal of this assignment
is to cleanly implement every swappable piece of behavior — rule sets,
edge handling, rendering, stats — as a Dart mixin, and to assemble a final
simulation class purely by choosing which mixins to compose. Here is a
rough spec of the project.

## Rough spec

1. A class `Grid` holds a rectangular board of alive/dead cells. It defines
   a single constructor with required named parameters `width` and
   `height`. This class is responsible for the board's state at each
   timestep; the internal data structures used to track which cells are
   alive are up to you.

2. A class `Cell` that encodes the coordinates of a cell within the grid.
   It defines a single constructor with required named parameters `x` and
   `y`. It must override `==` so cells can be compared, and should override
   `hashCode` if you use a `Set` or `Map` to track alive cells.

3. An abstract subclass `CellularAutomaton extends Grid` which declares
   three abstract methods: (1) `Iterable<Cell> neighborsOf(Cell cell)`,
   (2) `bool nextState(bool currentlyAlive, int liveNeighborCount)`, and
   (3) `String render()`. It also implements a concrete `step()` method
   that advances the grid to its next state using `neighborsOf` and
   `nextState`.

4. Four mixins — `ConwayRules`, `HighLifeRules`, `DayAndNightRules`,
   `SeedsRules` — each implementing `nextState` per one of the B/S rules
   above. These take no superclass constraint; they are pure functions of
   a cell's state and neighbor count.

5. Two mixins, `ToroidalEdges` and `WalledEdges`, each implementing
   `neighborsOf`: one wraps at the board's edges so every cell has 8
   neighbors, the other excludes off-board neighbors so edge and corner
   cells have fewer.

6. A mixin `AsciiRenderable` implements `render()` as text, with `#` for
   alive cells and `.` for dead cells. A second mixin, `ColorRenderable`,
   decorates another mixin's `render()` output (via `super.render()`)
   rather than reimplementing it, and depends on mixin order — for
   example, wrapping `AsciiRenderable`'s output in an ANSI color code.

7. A mixin `Trackable` overrides `step()` to record the board's
   `population` at each generation, calling `super.step()` so the
   simulation logic still executes.

Exact method signatures, constructor shapes, and behavior for erroneous
input are yours to pin down in your refined spec — the implementation
details are up to you as long as the mixin contracts above hold.

## Starter code

You are given only two things:

- `lib/cellular_automaton.dart`, a barrel file that already exports every
  file under `lib/src/` (`cell.dart`, `grid.dart`,
  `cellular_automaton.dart`, `edge_policies.dart`, `rules.dart`,
  `rendering.dart`, `stats.dart`). Each of those files is completely
  empty — implementing every class and mixin in them, per the rough spec
  above, is your job.
- `bin/cellular_automaton.dart`, a complete command-line application that
  imports the `cellular_automaton` package, composes the four required
  species out of the mixins you will write, and handles argument parsing,
  seeding, and printing the animation to the terminal. You should not
  need to modify this file — but it also won't compile until the classes
  and mixins it references actually exist in `lib/src/`.

The project uses the `args` package for the CLI. You will need to add it
to the project yourself using `dart pub add`, and add `test` yourself
once you start writing your own tests:

```
dart pub add args
dart pub add dev:test
```

Afterward, you can open `pubspec.yaml` to verify both packages were
added.

### Working in Android Studio

1. Install the **Dart** plugin (Settings/Preferences → Plugins → search
   "Dart" → Install), then restart Android Studio.
2. Create a new project: **File → New → Project…**, choose **Dart** in
   the project type list, and give it a name. Android Studio generates a
   fresh `pubspec.yaml` and a `lib/` folder for you.
3. Copy the provided starter files into place: replace the generated
   contents of `lib/` with the given `lib/cellular_automaton.dart` and
   the (empty) `lib/src/` files. There is no `bin/` folder yet — create
   one yourself at the project root and copy `bin/cellular_automaton.dart`
   into it.
4. Android Studio shows a "Pub get" banner at the top of the editor
   whenever `pubspec.yaml` changes; you can click that instead of running
   `dart pub get` manually.
5. Use the built-in **Terminal** tool window (View → Tool Windows →
   Terminal) to run the `dart pub add` commands above, `dart run
   bin/cellular_automaton.dart ...`, and `dart test`.

Example usage of the provided CLI:

```
dart run bin/cellular_automaton.dart --species=highlife --width=30 --height=15 --generations=100 --fps=8
```

## Deliverables

1. A refined spec of the rough spec above. Spell out the exact signature
   of every method and mixin, the exact constraint (`on` clause, or lack
   of one) each mixin requires, and behavior in edge cases — e.g. an
   out-of-bounds coordinate, or a class attempting to mix in both
   edge-policy mixins at once. Your refined spec must also answer, in your
   own words:
     a. What breaks, and why, if `ColorRenderable` is mixed in before
        the mixin that provides `render()`, in terms of mixin resolution
        order.
     b. What happens if a class mixes in both edge-policy mixins, and why.
2. The Dart code implementing your refined spec, plus tests under `test/`
   runnable with `dart test`.
3. screen-recorded video, at most 120 seconds, in which you
   explain your code and run the program, showing the animation. Include
   one custom rule beyond the four listed above and run the animation.
4. A report on your use of LLMs: which LLMs, for what purpose (code
   generation vs. spec refinement vs. test-case generation), how accurate
   the results were, and example prompts with the corresponding responses.

You are required to use LLMs for this assignment.

## Grading

1. Completeness of your refined spec.
2. Code compliance with your refined spec, and correct use of mixins as
   described above.
3. Accuracy of your video.
4. Ability to use LLMs effectively and assess LLM results.

You must work alone on this project. Your project code should be in a zip
archive named `xxx_yyy.zip`, where `xxx` and `yyy` are your first and last
names. The archive may contain your Dart source files in addition to the
video, refined spec, and LLM report. Submit via the assignment's submit
link on the Blackboard course website. No late submissions will be
accepted.
