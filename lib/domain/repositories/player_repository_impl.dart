import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duobr_project/data/models/player_model.dart';
import 'package:duobr_project/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final FirebaseFirestore _firestore;

  PlayerRepositoryImpl(this._firestore);

  @override
  Future<List<PlayerModel>> getAvailablePlayers() async {
    // await Future.delayed(const Duration(seconds: 1));
    // return [
    //   PlayerModel(
    //     id: '1',
    //     name: 'João',
    //     avatarUrl: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     games: ['Valorant'],
    //     rank: 'Diamante',
    //     bio: 'Jogo quase todo dia à noite!',
    //     available: true,
    //   ),
    //   PlayerModel(
    //     id: '2',
    //     name: 'Maria',
    //     avatarUrl: 'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     games: ['CS:GO'],
    //     rank: 'Águia',
    //     available: false,
    //     bio: 'Procurando duo fixo!',
    //   ),
    //   PlayerModel(
    //     id: '3',
    //     name: 'Noboru',
    //     rank: 'Ouro',
    //     games: ['CS:GO'],
    //     avatarUrl: 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     bio: 'Rush B, sem medo!',
    //     available: false,
    //   ),
    //   PlayerModel(
    //     id: '4',
    //     name: 'Bruna',
    //     rank: 'Prata',
    //     games: ['League of Legends'],
    //     avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     bio: 'Jogo todos os dias!',
    //     available: true,
    //   ),
    // ];
    final query = await _firestore.collection('users').get();
    return query.docs.map((doc) {
      final data = doc.data();
      return PlayerModel(
        id: doc.id,
        name: data['name'] ?? 'Unknown',
        avatarUrl:
            data['avatarUrl'] ?? 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        games: List<String>.from(data['games'] ?? []),
        rank: data['rank'] ?? 'Unknown',
        bio: data['bio'] ?? 'No bio available',
        available: data['available'] ?? false,
      );
    }).toList();
  }

  Future<PlayerModel?> getPlayerById(String id) async {
    final doc = await _firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return PlayerModel.fromDocument(doc);
    }
    return null;
  }
}
