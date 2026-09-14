import 'dart:math';

import 'cellular_automaton.dart';
import 'grid.dart';

mixin AsciiRenderable on Grid {
  String render() {
    final buf = StringBuffer();
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        buf.write(isAlive(Point(x, y)) ? '█' : '·');
      }
      buf.writeln();
    }
    return buf.toString();
  }
}

/// Wraps whatever `render()` produced in an ANSI color that cycles with
/// the generation counter. Must be mixed in *after* a mixin that already
/// implements `render()` (e.g. `AsciiRenderable`) — it calls `super.render()`.
mixin ColorRenderable on CellularAutomaton {
  static const _palette = ['\x1B[36m', '\x1B[35m', '\x1B[33m', '\x1B[32m'];

  @override
  String render() {
    final color = _palette[generation % _palette.length];
    return '$color${super.render()}\x1B[0m';
  }
}
