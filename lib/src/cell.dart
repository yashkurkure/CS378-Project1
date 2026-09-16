/// A single (x, y) coordinate within a [Grid].
///
/// Overrides `==`/`hashCode` on (x, y) so it works as a `Set`/`Map` key —
/// [Grid] stores alive cells in a `Set<Cell>`.
class Cell {
  final int x;
  final int y;

  const Cell({required this.x, required this.y});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cell && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}
