import 'dart:math';

import 'grid.dart';

const _moore = [
  Point(-1, -1), Point(0, -1), Point(1, -1),
  Point(-1, 0), Point(1, 0),
  Point(-1, 1), Point(0, 1), Point(1, 1),
];

/// The grid wraps at every edge — Pac-Man style. Every cell has exactly
/// 8 neighbors, including the corners.
mixin ToroidalEdges on Grid {
  Iterable<Point<int>> neighborsOf(Point<int> cell) sync* {
    for (final o in _moore) {
      final x = (cell.x + o.x + width) % width;
      final y = (cell.y + o.y + height) % height;
      yield Point(x, y);
    }
  }
}

/// The grid has hard walls — off-grid neighbors simply don't exist, so
/// edge and corner cells have fewer than 8 neighbors.
mixin WalledEdges on Grid {
  Iterable<Point<int>> neighborsOf(Point<int> cell) sync* {
    for (final o in _moore) {
      final p = Point(cell.x + o.x, cell.y + o.y);
      if (p.x >= 0 && p.x < width && p.y >= 0 && p.y < height) {
        yield p;
      }
    }
  }
}
