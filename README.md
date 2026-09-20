  # Dart Project - Cellular Automaton Zoo
  In this project you will build a Dart application simulating cellular automata. A cellular automaton is a grid of individual cells that change state over discrete time steps by following a simple set of local rules.

Below is an example of what one may look like:

![Automaton Image](cellular_automaton.gif)
  

In the 2D grid, each cell is either alive or dead. In the animation above, a cell is colored black if alive and white if dead. Simple rules like the following govern the animation:
1. Any live cell with fewer than two live neighbors dies (as if by loneliness).
2. Any live cell with two or three live neighbors lives on to the next generation.
3. Any live cell with more than three live neighbors dies (as if by overcrowding).
4. Any dead cell with exactly three live neighbors becomes alive (as if by reproduction).

This is also called the [Conway's Game of Life](https://youtu.be/R9Plq-D1gEk?si=x4bpcwctv4KS1e9b) devised by the mathematician John Conway.

At each timestep, the program iterates over the grid and computes the next state based on the rules above. The rules can also be denoted with the shorthand **B3/S23**, where B stands for Birth and S stands for Survival: a dead cell becomes alive if it has exactly 3 neighbors (B3), and a living cell stays alive if it has 2 or 3 neighbors (S23). Changing the B/S numbers produces different patterns with interesting properties. You may find some rules online and test out if those properties truly hold.

  In a 2D grid, each cell has 8 neighbors, except the ones at the border of the grid. Where the corner cells have 3 neighbors and the cells on the edges have 5. In your implementation you will assume these properties. The following section describes a rough spec you will follow:

## Spec

1. A class `Grid` holds a rectangular board of alive/dead cells. It defines a single constructor with required named parameters `int width`,  `int height` and`int seed`. This class is responsible for the board's state at each timestep; the internal data structures used to track which cells are alive are up to you. It should also include a getter method `get population` which returns the count of cells that are alive. You must make sure the initial state of the grid has some alive cells, this greatly affects the simulation. The `seed` argument accepts an integer that acts a seed for a random generator. Use the `dart:math` package to create a random number generator that initializes the board state. For example:
```

int customSeed = 42;
// Create a Random instance with the seed
var random = Random(customSeed);
// Generate a random integer from 0 (inclusive) up to 2 (exclusive), which gives 0 or 1
int randomNumber = random.nextInt(2);
print('Random 0 or 1: $randomNumber');

```
2. A class `Cell` that encodes the coordinates of a cell within the grid. It defines a single constructor with required named parameters `x` and `y`. It must override == so cells can be compared, and should override `hashCode` if you use a `Set` or `Map` to track alive cells.

3. An abstract subclass `CellularAutomaton extends Grid` which declares two abstract methods: (1) `bool nextState(bool currentlyAlive, int liveNeighborCount)` and (2) `String render()`. It also implements one concrete `step()` method that advances the grid to its next state and increments a public class member called `int generation` after every step is taken.
4. A mixin `ConwayRules` that implements a single method `bool nextState(bool currentlyAlive, int liveNeighborCount)`. It takes the current state of a cell encoded as a boolean (`true` for alive and `false` for dead) and the count of neighbors which are alive. Based on these values the method returns a boolean indicating whether the cell should stay alive (`true`) or die (`false`) in the next time step. This is where you implement the logic for the cellular automaton.

5. A mixin `AsciiRenderable`that has access to the members of the `Grid` class allowing it to access the state of the board (HINT: using the `on` keyword). It implements a single `String render()` method which returns a string of characters representing the cells of the grid. Use `#` for alive cells and `.` for dead cells. Make sure newlines are inserted at appropriate places in the string.

6. A mixin `DecoratedRenderable` that has access to the members of `CellularAutomaton` class (HINT: using the `on` keyword). It implements a single `String render()` method, however it overrides the default `render()` method and uses the `super` keyword to retrieve the raw string representing the board. It then modifies this string by adding a border to the grid using `|` and `-` characters.

7. You must also implement error handling wherever necessary. For example: If your Grid class contains an `isAlive(Cell cell)` method to get the state of a cell, an error must be thrown if the cell does not exist on the grid.

Given that you have implemented this Spec, some starter code is offered to you which is described below:

## Starter code

You are given three things:
- `lib/cellular_automaton_zoo.dart`, a file that exports every file under `lib/src/` as a dart package. Each of the files under `lib/src/` is completely empty and implementing every class and mixin in them, per the spec above, is your job.
- `bin/main.dart`, contains a complete command line application (CLI) and an example of how the classes and mixins you write come together. You should not need to modify this file — but it also won't compile until the classes and mixins it references actually
### Working in Android Studio

1. Install the **Dart** and **Flutter** plugins (Example: Settings/Preferences → Plugins → search "Dart" → Install), then restart Android Studio after installing both.

2. Create a new project using New Flutter Project → Select the Dart generator from the pane on the left → If asked, enter the path to the Dart SDK installed on your system → **Name your project as: cellular_automaton_zoo**

3. Copy the provided starter files into place: replace the generated contents of `lib/` with the given `lib/cellular_automaton_zoo.dart` and the (empty) `lib/src/` files. There is no `bin/` folder yet — create one yourself at the project root and copy `bin/main.dart` into it.

### Installing the Dependencies
The starter code uses the `args` package for the CLI. You will need to add it to the project yourself using the `dart pub add` command using the terminal as follows:

```
dart pub add args
dart pub add dev:test
```
### Using the CLI
Once you have implemented your code, the provided CLI can be run using the `dart run` command. Several arguments can be passed to it which set the grid size, width, the animation speed and the species of the automatons. For an example you can run:
```

dart run bin/main.dart --species=conway --width=30 --height=15 --generations=100 --fps=8

```
## Deliverables
1. A PDF file `spec.pdf` describing your refined spec of the rough spec above. Spell out the exact signature of every method, class and mixin (include the details of using the `on` keyword where required and where it is not).
2. The Dart code implementing your refined spec.
3. A screen recorded video `tutorial.mp4`, at most 180 seconds. In the video you will code live by adding a new mixin called `CustomRules` to the `rules.dart`. The mixin would be similar to `ConwayRules` but implement a rule of your choice. Then you will modify the `CLI` appropriately so that you can run your custom rules by passing `--species=custom`. You will run the command showing your animation and explain the changes you are making as you live code. Additionally, also include explanations of how you track the state of automaton (eg: datastructures used to track the state of dead/alive cells, how the states are updated, etc)
4. A report on your use of LLMs `llm-usage.pdf`. You must include the LLM you used, for what purpose(code generation vs. spec refinement vs. test-case generation), how accurate the results were, and example prompts with the corresponding responses.

You are required to use LLMs for this assignment.

  All the files need to be submitted as a `zip` file named as `<firstname>_<lastname>.zip` it should include the following:
- A folder `cellular_automaton_zoo` which is your android studio project.
- A file `spec.pdf` with your refined spec.
- A file `llm-usage.pdf` with your llm report.
- A video `tutorial.mp4` containing your screen recorded video.

**Make sure you include the latest version of your code in the submission corresponding to the video. We should be able to run your custom animation.**
## Grading

We encourage you use the suggested file names in your submission as it makes grading easier for us. We will grade your submission on the following criteria:
1. The completeness of your refined spec.
2. Code compliance with your refined spec, and correct use of mixins as described in the project. (Appropriate usage of the 'on' keyword)
3. Accuracy of your video in terms of demonstrating adding the custom rule, and clarity in explaining how you store and update the state of the automaton.
4. Ability to use LLMs effectively and assess LLM results.

Submission details are posted on Canvas.

## Some Advice

Here is some advice Claude has for you:

1. **Order of mixins matters.** In `with ConwayRules, AsciiRenderable, DecoratedRenderable`, mixins are applied left to right. `DecoratedRenderable` calls `super.render()`, so something that already provides `render()` (such as `AsciiRenderable`) must come *before* it. Swapping them produces a confusing compile error.
2. **`_private` means private to the file, not the class.** A member starting with `_` in `grid.dart` cannot be used from `cellular_automaton.dart` or `rendering.dart`. If other files need to read or change the board, give `Grid` public methods for it.
3. **Do not update the board while you are scanning it.** If you change a cell and then count the neighbors of the next cell, you are reading a half-updated board and the patterns come out wrong. Work out every cell's next state first, and only then apply them all.
4. **No wrap-around.** The edges of the grid are walls, not portals. Cells outside the grid do not count as neighbors, which is why a corner has 3 neighbors and an edge cell has 5.
5. **Trailing newline in `render()`.** If every row ends with `\n`, then `split('\n')` gives you an extra empty string at the end. Skip it or you will draw a stray empty row inside the border.
6. **`==` and `hashCode` go together.** Override both in `Cell`, using the same fields. `Object.hash(x, y)` is an easy way to write `hashCode`.
7. **The starting board must have live cells.** With a very small grid, random generation can produce an all-dead board, which never changes. Make sure at least one cell is alive.
8. **Validate your inputs.** Check for a cell outside the grid in `isAlive` and anywhere else a `Cell` is used to access the board. Also consider what a `width` or `height` of 0 or a negative number should do.
9. **Same seed, same board.** Create one `Random(seed)` and reuse it. Do not create a new `Random(seed)` for every cell, or every cell will get the same value.
10. **`--species=custom` needs two changes in `bin/main.dart`.** Add `'custom'` to the `allowed` list of the `species` option, and add a new class composing your `CustomRules` mixin with the rendering mixins, plus a matching line in the `switch`. Without both, the CLI rejects the species.
11. **You only need to read `bin/main.dart`, not master it.** It uses some Dart features (`switch` expressions, `async`/`await`) that are beyond this project. Focus on the class at the top that composes the mixins, which is the part that matters here.
12. **Test your rules by hand.** Set up a small pattern, such as three live cells in a row (a "blinker"), and check that it flips between horizontal and vertical each step. This catches most bugs in `step()` and `nextState`.
