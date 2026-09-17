import 'dart:io';

import 'package:test/test.dart';

Future<ProcessResult> runCli(List<String> args) => Process.run(
      Platform.resolvedExecutable,
      ['run', 'bin/cellular_automaton.dart', ...args],
    );

void main() {
  group('cellular_automaton CLI', () {
    test('runs a conway simulation and prints every generation', () async {
      final result = await runCli([
        '--species=conway',
        '--width=10',
        '--height=5',
        '--generations=2',
        '--fps=1000',
        '--seed=1',
      ]);

      expect(result.exitCode, 0, reason: result.stderr.toString());

      final output = result.stdout as String;
      expect(output, contains('species=conway'));
      expect(output, contains('generation 0/2'));
      expect(output, contains('generation 1/2'));
      expect(output, contains('generation 2/2'));
      expect(output, contains('population='));
      // DecoratedRenderable's border, one dash per column plus the two sides.
      expect(output, contains('-' * 12));
      expect(output, contains('|'));
    });

    test('the same seed always produces the same board', () async {
      final args = [
        '--species=conway',
        '--width=8',
        '--height=4',
        '--generations=0',
        '--fps=1000',
        '--seed=7',
      ];

      final first = await runCli(args);
      final second = await runCli(args);

      expect(first.exitCode, 0);
      expect(second.exitCode, 0);
      expect(first.stdout, equals(second.stdout));
    });

    test('different seeds produce different boards', () async {
      final first = await runCli([
        '--species=conway',
        '--width=8',
        '--height=4',
        '--generations=0',
        '--fps=1000',
        '--seed=1',
      ]);
      final second = await runCli([
        '--species=conway',
        '--width=8',
        '--height=4',
        '--generations=0',
        '--fps=1000',
        '--seed=2',
      ]);

      expect(first.stdout, isNot(equals(second.stdout)));
    });

    test('rejects an unknown species', () async {
      final result = await runCli(['--species=unknown']);
      expect(result.exitCode, isNot(0));
    });
  });
}
