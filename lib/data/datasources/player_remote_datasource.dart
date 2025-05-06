import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player_model.dart';

abstract class PlayerRemoteDataSource {
  Future<List<PlayerModel>> getAvailablePlayers();
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  final FirebaseFirestore firestore;

  PlayerRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<PlayerModel>> getAvailablePlayers() async {
    final snapshot = await firestore.collection('players').get();

    return snapshot.docs.map((doc) => PlayerModel.fromMap(doc.data(), doc.id)).toList();
  }
}
