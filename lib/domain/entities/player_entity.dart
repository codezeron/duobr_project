class PlayerEntity {
  final String id;
  final String name;
  final List<String> games;
  final String rank;
  final String avatarUrl;
  final bool available;
  final String? bio;

  PlayerEntity({
    required this.id,
    required this.name,
    required this.games,
    required this.rank,
    required this.avatarUrl,
    required this.available,
    this.bio,
  });
}
