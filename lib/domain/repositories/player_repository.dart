import 'package:duobr_project/data/models/player_model.dart';

abstract class PlayerRepository {
  Future<List<PlayerModel>> getAvailablePlayers();
}
