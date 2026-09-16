import 'cell.dart';
import 'grid.dart';

/// Defines the three extension points that mixins are responsible for:
///
/// - [neighborsOf]  — the edge policy (toroidal wrap, walled, ...)
/// - [nextState]    — the rule set (Conway, HighLife, ...)
/// - [render]       — the presentation (plain ASCII, colored, ...)
///
/// [step] is already implemented here using those three, but it's still
/// `on`-able: a mixin like `Trackable` can override it and call
/// `super.step()` to add behavior (recording stats) without touching the
/// simulation logic itself.
abstract class CellularAutomaton extends Grid {
  int generation = 0;

  CellularAutomaton(super.width, super.height);

  Iterable<Cell> neighborsOf(Cell cell);

  bool nextState(bool currentlyAlive, int liveNeighbors);

  String render();

  void step() {
    final next = <Cell>{};
    for (final cell in allCells) {
      final liveNeighbors = neighborsOf(cell).where(isAlive).length;
      if (nextState(isAlive(cell), liveNeighbors)) {
        next.add(cell);
      }
    }
    alive
      ..clear()
      ..addAll(next);
    generation++;
  }
}
