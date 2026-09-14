/// Conway's original rule: B3/S23.
mixin ConwayRules {
  bool nextState(bool alive, int n) => alive ? (n == 2 || n == 3) : n == 3;
}

/// B36/S23 — same survival rule as Conway, but also births on 6 neighbors.
/// Famous for having a self-replicating pattern.
///
/// TODO: implement. A live cell survives on 2 or 3 neighbors (same as
/// Conway). A dead cell is born on 3 OR 6 neighbors.
mixin HighLifeRules {
  bool nextState(bool alive, int n) => throw UnimplementedError();
}

/// B3678/S34678 — symmetric under alive/dead inversion, tends to produce
/// blobby, cave-like patterns.
///
/// TODO: implement. A live cell survives on 3, 4, 6, 7, or 8 neighbors.
/// A dead cell is born on 3, 6, 7, or 8 neighbors.
mixin DayAndNightRules {
  bool nextState(bool alive, int n) => throw UnimplementedError();
}

/// B2/S — nothing ever survives, only births. Everything alive dies every
/// single step, but new cells keep exploding into existence. Chaotic.
///
/// TODO: implement. No live cell ever survives, regardless of neighbor
/// count. A dead cell is born on exactly 2 neighbors.
mixin SeedsRules {
  bool nextState(bool alive, int n) => throw UnimplementedError();
}
