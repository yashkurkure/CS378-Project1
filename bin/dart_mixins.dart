import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:dart_mixins/dart_mixins.dart';

/// Each "species" is a concrete mixin composition — this is the payoff
/// line students write themselves: which mixins, in which order.
class ConwayToroidal extends CellularAutomaton
    with ToroidalEdges, ConwayRules, AsciiRenderable, ColorRenderable, Trackable {
  ConwayToroidal(super.width, super.height);
}

class HighLifeWalled extends CellularAutomaton
    with WalledEdges, HighLifeRules, AsciiRenderable, ColorRenderable, Trackable {
  HighLifeWalled(super.width, super.height);
}

class DayAndNightToroidal extends CellularAutomaton
    with ToroidalEdges, DayAndNightRules, AsciiRenderable, ColorRenderable, Trackable {
  DayAndNightToroidal(super.width, super.height);
}

class SeedsWalled extends CellularAutomaton
    with WalledEdges, SeedsRules, AsciiRenderable, ColorRenderable, Trackable {
  SeedsWalled(super.width, super.height);
}

/// Reproducible on this machine for this student, different elsewhere.
int _seedForThisMachine(String studentId) =>
    (Platform.localHostname + studentId).hashCode & 0x7fffffff;

CellularAutomaton _buildSpecies(String name, int w, int h) => switch (name) {
      'conway' => ConwayToroidal(w, h),
      'highlife' => HighLifeWalled(w, h),
      'daynight' => DayAndNightToroidal(w, h),
      'seeds' => SeedsWalled(w, h),
      _ => throw ArgumentError('Unknown species: $name'),
    };

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('species',
        defaultsTo: 'conway',
        allowed: ['conway', 'highlife', 'daynight', 'seeds'])
    ..addOption('student', defaultsTo: Platform.environment['USER'] ?? 'anon')
    ..addOption('width', defaultsTo: '40')
    ..addOption('height', defaultsTo: '20')
    ..addOption('generations', defaultsTo: '100')
    ..addOption('fps', defaultsTo: '8');

  final args = parser.parse(arguments);
  final width = int.parse(args['width']);
  final height = int.parse(args['height']);
  final generations = int.parse(args['generations']);
  final fps = int.parse(args['fps']);
  final studentId = args['student'] as String;

  final seed = _seedForThisMachine(studentId);
  final rng = Random(seed);

  final sim = _buildSpecies(args['species'], width, height);
  sim.seed([
    for (final cell in sim.allCells)
      if (rng.nextDouble() < 0.25) cell,
  ]);

  for (var i = 0; i <= generations; i++) {
    stdout.write('\x1B[2J\x1B[H'); // clear screen, cursor home
    stdout.writeln('species=${args['species']}  seed=$seed  '
        '(host=${Platform.localHostname} student=$studentId)');
    stdout.writeln('generation ${sim.generation}/$generations  '
        'population=${sim.population}');
    stdout.write(sim.render());
    if (i < generations) {
      sim.step();
      await Future.delayed(Duration(milliseconds: 1000 ~/ fps));
    }
  }
}
