# Rough Rubric - Cellular Automaton Zoo (100 pts)

This rubric expands the four grading criteria listed in the README.

## 1. Refined spec, `spec.pdf` (20)

| Pts | Criterion |
|---|---|
| 6 | Exact signatures for every class and mixin: `Grid({required int width, required int height, required int seed})`, `get population`, `Cell({required x, required y})`, `==`/`hashCode`, `nextState`, `render`, `step`, `generation` |
| 5 | States where `on` is used and why: `AsciiRenderable on Grid`, `DecoratedRenderable on CellularAutomaton`, and `ConwayRules` needs no `on`. Explains why the mixin order matters |
| 4 | Defines edge cases: neighbors at edges and corners (no wrap-around), invalid width/height, out-of-bounds access, at least one cell alive at the start |
| 3 | Defines the `render()` output: `#` and `.`, where newlines go, and the border characters |
| 2 | Describes how the board is stored and how it is updated (compute the full next state first, then apply it) |

## 2. Code (45)

**Gate:** the code must run with the unmodified `bin/main.dart` (`dart run bin/main.dart --species=conway`). If it does not, cap this section at 50%.

| Pts | Criterion |
|---|---|
| 6 | `Grid`: required named constructor; uses a single `Random(seed)`, so the same seed gives the same board; `population` is correct; at least one cell starts alive |
| 4 | `Cell`: `==` and `hashCode` are overridden and consistent with each other |
| 8 | `CellularAutomaton`: abstract; declares both abstract methods; `step()` builds the next generation in a separate buffer and increments `generation` |
| 6 | `ConwayRules.nextState` implements B3/S23 correctly |
| 4 | Neighbor counting: corners see 3 neighbors, edges see 5, no wrap-around |
| 5 | `AsciiRenderable on Grid`: correct characters and newlines |
| 6 | `DecoratedRenderable on CellularAutomaton`: gets the board from `super.render()` and adds the border without redrawing the board |
| 4 | Error handling: out-of-bounds access throws; invalid width/height is rejected |
| 2 | The code matches the student's own `spec.pdf` |

## 3. Video, `tutorial.mp4` (20)

| Pts | Criterion |
|---|---|
| 6 | Adds a `CustomRules` mixin to `rules.dart` live, implementing a rule other than B3/S23 |
| 5 | Makes both CLI changes: adds `'custom'` to `allowed`, and adds a new composed class with its `switch` case |
| 4 | Runs `--species=custom`, and the animation visibly follows the new rule |
| 5 | Clearly explains how the automaton state is stored and how it is updated |

**Penalties:** the video runs over 180 s, or the submitted code does not match the video or cannot run `--species=custom`.

## 4. LLM usage report, `llm-usage.pdf` (15)

| Pts | Criterion |
|---|---|
| 3 | Names the model(s) used and what each one was used for (code, spec, tests) |
| 4 | Includes example prompts with the actual responses |
| 6 | Critically evaluates the output: where the LLM was wrong, and how the student caught and fixed it |
| 2 | Gives an honest account of how much they relied on the LLM |

## Packaging deductions

Deduct for a wrong zip name or file names, missing files, or a project that does not open.

## Grading notes

- The spec requires no method for placing cells, and students can fill the random board in any order. Automated tests can only rely on the constructor, `population`, `generation`, `step()`, `render()`, and `nextState`. Two ways to test with only those:
  - Test `nextState` across all 18 inputs (alive or dead, 0-8 live neighbors).
  - Parse `render()`, compute the next Conway generation independently, call `step()`, and compare. Also check that `population` equals the number of `#` characters.
- The border format (corner characters, padding) is not defined in the spec, so grade it loosely.
