import 'cell.dart';
import 'grid.dart';

const _moore = [
  Cell(x: -1, y: -1), Cell(x: 0, y: -1), Cell(x: 1, y: -1),
  Cell(x: -1, y: 0), Cell(x: 1, y: 0),
  Cell(x: -1, y: 1), Cell(x: 0, y: 1), Cell(x: 1, y: 1),
];

/// The grid wraps at every edge — Pac-Man style. Every cell has exactly
/// 8 neighbors, including the corners.
mixin ToroidalEdges on Grid {
  Iterable<Cell> neighborsOf(Cell cell) sync* {
    for (final o in _moore) {
      final x = (cell.x + o.x + width) % width;
      final y = (cell.y + o.y + height) % height;
      yield Cell(x: x, y: y);
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
  Iterable<Cell> neighborsOf(Cell cell) sync* {
    throw UnimplementedError();
  }
}
