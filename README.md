# Dart Project: Cellular Automaton Zoo

In this project you will build a Dart application simulating cellular
automata. A cellular automaton is a grid of individual cells that change
state over discrete time steps by following a simple set of local rules.
Below is an example of what one may look like:

![Cellular automaton animation](cellular_automaton.gif)

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

This is also called the [Conway's Game of Life](https://youtu.be/R9Plq-D1gEk?si=x4bpcwctv4KS1e9b) devised by the mathematician John Conway.

At each timestep, the program iterates over the grid and computes the next
state based on the rules above. The rules can also be denoted with the
shorthand **B3/S23**, where B stands for Birth and S stands for Survival:
a dead cell becomes alive if it has exactly 3 neighbors (B3), and a living
cell stays alive if it has 2 or 3 neighbors (S23). Changing the B/S numbers
produces different patterns with interesting properties. You may find some rules online and test out if those properties truly hold.

In a 2D grid, each cell has 8 neighbors, except the ones at the border of the grid. Where the corner cells have 3 neighbors and the cells on the edges have 5. In your implementation you will assume these properties. The following section describes a rough spec you will follow:

## Spec

1. A class `Grid` holds a rectangular board of alive/dead cells. It defines
a single constructor with required named parameters `width` and `height`. This class is responsible for the board's state at each timestep; the internal data structures used to track which cells are alive are up to you. It should also include a getter method `get population` which returns the count of cells that are alive.

2. A class `Cell` that encodes the coordinates of a cell within the grid.
It defines a single constructor with required named parameters `x` and `y`. It must override `==` so cells can be compared, and should override `hashCode` if you use a `Set` or `Map` to track alive cells.

3. An abstract subclass `CellularAutomaton extends Grid` which declares
two abstract methods: (1) `bool nextState(bool currentlyAlive, int liveNeighborCount)` and (2) `String render()`. It also implements one concrete `step()` method that advances the grid to its next state using `neighborsOf` and `nextState`.

4. A mixin `ConwayRules` that implements a single method `bool nextState(bool currentlyAlive, int liveNeighborCount)`. It takes the current state of a cell encoded as a boolean (true for alive and false for dead) and the count of neighbors which are alive. Based on these values the method returns a boolean indicating whether the cell should stay alive (true) or die (false) in the next timestep.

5. A mixin `AsciiRenderable` that has access to the members of the `Grid` class allowing it to access the state of the board (HINT: using the `on` keyword). It implements a single `String render()` method which returns a string of characters representing the cells of the grid. Use `#` for alive cells and `.` for dead cells. Make sure newlines are inserted at appropriate places in the string.

6. A mixin `DecoratedRenderable` that has access to the members of `CellularAutomaton` class (HINT: using the `on` keyword). It implements a single `String render()` method, however it overrides the default `render()` methods and uses the `super` keyword to retrieve the raw string representing the board. It then modifies this string by adding a border to the grid using `|` and `-` characters.

7. You must also implement error handling wherever necessary. For example: If your Grid class contains an `isAlive(Cell cell)` method to get the state of a cell, an error must be thrown if the cell does not exist on the grid.

Given that you have implemented this Spec, some starter code is offered to you which implements a command line interface and code to animate the board onto the command line described below and available in the repository under the `bin` and `lib` folders.

## Starter code

You are given two things:

- `lib/cellular_automaton.dart`, a barrel file that exports every
  file under `lib/src/` (`grid.dart`, `cell.dart`,
  `cellular_automaton.dart`, `rules.dart`,
  `rendering.dart`). Each of the files under `lib/src/` is completely
  empty and implementing every class and mixin in them, per the spec
  above, is your job.

- `bin/cellular_automaton.dart`, contains a complete command line application (CLI) and an example of how the classes and mixins you write come together. You should not need to modify this file — but it also won't compile until the classes and mixins it references actually exist in `lib/src/`.

### Working in Android Studio

1. Install the **Dart** and **Flutter** plugins (Example: Settings/Preferences → Plugins → search "Dart" → Install), then restart Android Studio after installing both.

2. Create a new project using **New Flutter Project** -> **Select the Flutter generator from the pane on the left** -> **If asked, enter the path to the Flutter SDK installed on your system** -> **Name your project as: cellular_automaton_zoo**
3. Copy the provided starter files into place: replace the generated contents of `lib/` with the given `lib/cellular_automaton.dart` and the (empty) `lib/src/` files. There is no `bin/` folder yet — create one yourself at the project root and copy `bin/cellular_automaton.dart` into it.

### Installing the Dependencies

The starter code uses the `args` package for the CLI. You will need to add it
to the project yourself using the `dart pub add` command before being able to compile the application. Furthermore, as a part of grading you will use the `test` package to implement the tests for your project. To install both packages, open the terminal provided by Android Studio and run:

```
dart pub add args
dart pub add dev:test
```

### Using the CLI

The provided CLI can be run using the `dart run` command. Several arguments can be passed to it which set the grid size, width, the animation speed and the species of the automatons. As an example you can run:

```
dart run bin/cellular_automaton.dart --species=conway --width=30 --height=15 --generations=100 --fps=8
```

## Deliverables

1. A PDF file `spec.pdf` describing your refined spec of the rough spec above. Spell out the exact signature of every method, class and mixin (include the details of using the `on` keyword where required and where it is not).

2. The Dart code implementing your refined spec, plus tests under `test/`
runnable with `dart test`. Some sample tests are given that test the CLI for your reference on how tests are implemented using dart's `test` package.

3. A screen recorded video `tutorial.mp4`, at most 120 seconds. In the video you will code live by adding a new mixin called `CustomRules` to the `rules.dart`. The mixin would be similar to `ConwayRules` but implement a rule of your choice. Then you will modify the `CLI` appropriately so that the following command will run your custom animation:

```
dart run bin/cellular_automaton.dart --species=custom --width=30 --height=15 --generations=100 --fps=8
```
You will run the command showing your animation and explain the changes you are making as you live code. Additionally, also include explanations of how you track which cells are alive or dead.

4. A report on your use of LLMs `llm-usage.pdf`. You must include the LLM you used, for what purpose(code generation vs. spec refinement vs. test-case generation), how accurate the results were, and example prompts with the corresponding responses.

You are required to use LLMs for this assignment.

All the files need to be submitted as a `zip` file named as `<firstname>_<lastname>.zip` it should include the following:
- A folder `cellular_automaton_zoo` which is your android studio project.
- A file `spec.pdf` with your refined spec.
- A file `llm-usage.pdf` with your llm report.
- A video `tutorial.mp4` containing your screen recorded video.

**Make sure you include the latest version of your code post recording the video, we should be able to run your custom animation.**

## Grading

We encourage you use the suggested file names in your submission as it makes grading easier for us.

1. The completeness of your refined spec.
2. Code compliance with your refined spec, and correct use of mixins as
   described in the project. (Appropriate usage of the 'on' keyword)
3. Accuracy of your video in terms of demonstrating adding the custom rule, and clarity in explaining how you store the state of alive and dead cells.
4. Ability to use LLMs effectively and assess LLM results.

Submission details are posted on Canvas.
