import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duobr_project/domain/entities/player_entity.dart';

class PlayerModel extends PlayerEntity {
  PlayerModel({
    required super.id,
    required super.name,
    required super.games,
    required super.rank,
    required super.avatarUrl,
    required super.available,
    required super.bio,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map, String id) {
    return PlayerModel(
      id: id,
      name: map['name'],
      games: map['games'] != null ? List<String>.from(map['games']) : [],
      rank: map['rank'],
      avatarUrl: map['avatarUrl'],
      available: map['available'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'game': games, 'rank': rank, 'avatarUrl': avatarUrl, 'available': available, 'bio': bio};
  }

  factory PlayerModel.fromDocument(DocumentSnapshot doc) {
    return PlayerModel(
      id: doc.id,
      name: doc['name'] ?? 'Unknown',
      games: List<String>.from(doc['games'] ?? []),
      rank: doc['rank'] ?? 'Unknown',
      avatarUrl:
          doc['avatarUrl'] ?? 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      available: doc['available'] ?? false,
      bio: doc['bio'] ?? 'No bio available',
    );
  }
  Map<String, dynamic> toDocument() {
    return {'name': name, 'games': games, 'rank': rank, 'avatarUrl': avatarUrl, 'available': available, 'bio': bio};
  }
}
