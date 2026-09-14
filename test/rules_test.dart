import 'dart:math';

import 'package:dart_mixins/dart_mixins.dart';
import 'package:test/test.dart';

// Pure functions of (alive, neighborCount) — no `on` clause needed, so we
// can test them completely in isolation.
class _ConwayHarness with ConwayRules {}
class _HighLifeHarness with HighLifeRules {}
class _DayAndNightHarness with DayAndNightRules {}
class _SeedsHarness with SeedsRules {}

// Edge mixins need a real Grid to read width/height from.
class _ToroidalHarness extends Grid with ToroidalEdges {
  _ToroidalHarness(super.width, super.height);
}
class _WalledHarness extends Grid with WalledEdges {
  _WalledHarness(super.width, super.height);
}

void main() {
  group('ConwayRules (B3/S23)', () {
    final r = _ConwayHarness();
    test('lonely cell dies', () => expect(r.nextState(true, 1), isFalse));
    test('2 neighbors survives', () => expect(r.nextState(true, 2), isTrue));
    test('3 neighbors survives', () => expect(r.nextState(true, 3), isTrue));
    test('overcrowded cell dies', () => expect(r.nextState(true, 4), isFalse));
    test('birth on exactly 3', () => expect(r.nextState(false, 3), isTrue));
    test('no birth on 2', () => expect(r.nextState(false, 2), isFalse));
  });

  group('HighLifeRules (B36/S23)', () {
    final r = _HighLifeHarness();
    test('also births on 6', () => expect(r.nextState(false, 6), isTrue));
    test('still no birth on 4', () => expect(r.nextState(false, 4), isFalse));
  });

  group('DayAndNightRules (B3678/S34678)', () {
    final r = _DayAndNightHarness();
    test('survives on 4', () => expect(r.nextState(true, 4), isTrue));
    test('births on 6', () => expect(r.nextState(false, 6), isTrue));
    test('no birth on 5', () => expect(r.nextState(false, 5), isFalse));
  });

  group('SeedsRules (B2/S)', () {
    final r = _SeedsHarness();
    test('nothing ever survives', () => expect(r.nextState(true, 2), isFalse));
    test('births only on exactly 2', () => expect(r.nextState(false, 2), isTrue));
    test('no birth on 3', () => expect(r.nextState(false, 3), isFalse));
  });

  group('ToroidalEdges', () {
    final g = _ToroidalHarness(3, 3);
    test('corner has all 8 neighbors, wrapped', () {
      final ns = g.neighborsOf(const Point(0, 0)).toSet();
      expect(ns, hasLength(8));
      expect(ns, contains(const Point(2, 2))); // wraps around
    });
  });

  group('WalledEdges', () {
    final g = _WalledHarness(3, 3);
    test('corner only has 3 neighbors', () {
      final ns = g.neighborsOf(const Point(0, 0)).toSet();
      expect(ns, hasLength(3));
      expect(ns, isNot(contains(const Point(2, 2))));
    });
  });

  group('blinker oscillator (Conway, walled)', () {
    test('period-2 oscillation', () {
      final sim = _BlinkerSim(5, 5)
        ..seed(const [Point(1, 2), Point(2, 2), Point(3, 2)]);
      final gen0 = sim.alive.toSet();
      sim.step();
      expect(sim.alive, unorderedEquals(const [Point(2, 1), Point(2, 2), Point(2, 3)]));
      sim.step();
      expect(sim.alive, unorderedEquals(gen0));
    });
  });
}

class _BlinkerSim extends CellularAutomaton with WalledEdges, ConwayRules {
  _BlinkerSim(super.width, super.height);
  @override
  String render() => ''; // not under test here
}
