/// Conway's original rule: B3/S23.
mixin ConwayRules {
  bool nextState(bool alive, int n) => alive ? (n == 2 || n == 3) : n == 3;
}

/// B36/S23 — same survival rule as Conway, but also births on 6 neighbors.
/// Famous for having a self-replicating pattern.
mixin HighLifeRules {
  bool nextState(bool alive, int n) =>
      alive ? (n == 2 || n == 3) : (n == 3 || n == 6);
}

/// B3678/S34678 — symmetric under alive/dead inversion, tends to produce
/// blobby, cave-like patterns.
mixin DayAndNightRules {
  static const _births = {3, 6, 7, 8};
  static const _survives = {3, 4, 6, 7, 8};
  bool nextState(bool alive, int n) =>
      alive ? _survives.contains(n) : _births.contains(n);
}

/// B2/S — nothing ever survives, only births. Everything alive dies every
/// single step, but new cells keep exploding into existence. Chaotic.
mixin SeedsRules {
  bool nextState(bool alive, int n) => !alive && n == 2;
}
