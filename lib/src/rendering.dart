import 'cell.dart';
import 'cellular_automaton.dart';
import 'grid.dart';

mixin AsciiRenderable on Grid {
  String render() {
    final buf = StringBuffer();
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        buf.write(isAlive(Cell(x: x, y: y)) ? '█' : '·');
      }
      buf.writeln();
    }
    return buf.toString();
  }
}

/// Wraps whatever `render()` produced in an ANSI color that cycles with
/// the generation counter. Must be mixed in *after* a mixin that already
/// implements `render()` (e.g. `AsciiRenderable`) — it calls `super.render()`.
///
/// TODO: implement. Pick a color from `_palette` using `generation`, and
/// return it concatenated with `super.render()` and a reset code
/// (`\x1B[0m`) at the end. If you mix this in *before* `AsciiRenderable`
/// instead of after, think about what `super.render()` resolves to —
/// try it and see what breaks.
mixin ColorRenderable on CellularAutomaton {
  static const _palette = ['\x1B[36m', '\x1B[35m', '\x1B[33m', '\x1B[32m'];

  @override
  String render() => throw UnimplementedError();
}
