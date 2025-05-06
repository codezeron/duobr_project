import 'package:duobr_project/data/models/player_model.dart';
import 'package:duobr_project/domain/repositories/player_repository.dart';

class GetAvailablePlayers {
  final PlayerRepository repository;

  GetAvailablePlayers(this.repository);

  Future<List<PlayerModel>> call() {
    return repository.getAvailablePlayers();
  }
}
