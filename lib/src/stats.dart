import 'cellular_automaton.dart';

/// Records population history without touching the simulation logic —
/// it just wraps `step()` and calls through to it.
mixin Trackable on CellularAutomaton {
  final List<int> populationHistory = [];

  @override
  void step() {
    populationHistory.add(population);
    super.step();
  }
}
