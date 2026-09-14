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
///
/// TODO: implement, following the pattern of [ToroidalEdges] above, but
/// skip any candidate neighbor that falls outside `[0, width) x [0, height)`
/// instead of wrapping it.
mixin WalledEdges on Grid {
  Iterable<Point<int>> neighborsOf(Point<int> cell) sync* {
    throw UnimplementedError();
  }
}
