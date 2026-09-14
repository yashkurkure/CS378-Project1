import 'dart:math';

/// A sparse grid: only alive cells are stored. Cells outside
/// `[0, width) x [0, height)` are never stored here — how they're treated
/// (wrapped, ignored, etc.) is the job of an edge-policy mixin, not this
/// class.
class Grid {
  final int width;
  final int height;
  final Set<Point<int>> alive = <Point<int>>{};

  Grid(this.width, this.height);

  bool isAlive(Point<int> cell) => alive.contains(cell);

  void seed(Iterable<Point<int>> cells) => alive.addAll(cells);

  int get population => alive.length;

  /// Every coordinate in the grid, row by row.
  Iterable<Point<int>> get allCells sync* {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        yield Point(x, y);
      }
    }
  }
}
