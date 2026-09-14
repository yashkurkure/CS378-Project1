import 'cellular_automaton.dart';

/// Records population history without touching the simulation logic —
/// it just wraps `step()` and calls through to it.
///
/// TODO: implement `step()`. Append `population` to `populationHistory`,
/// then call `super.step()` to actually advance the simulation. Order
/// matters: recording before vs. after `super.step()` captures a
/// different generation's population — pick one and be able to explain
/// which you chose.
mixin Trackable on CellularAutomaton {
  final List<int> populationHistory = [];

  @override
  void step() => throw UnimplementedError();
}
