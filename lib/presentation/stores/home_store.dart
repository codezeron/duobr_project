import 'dart:developer';

import 'package:duobr_project/data/models/player_model.dart';
import 'package:mobx/mobx.dart';
import '../../domain/usecases/get_available_players.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final GetAvailablePlayers getAvailablePlayers;

  _HomeStoreBase(this.getAvailablePlayers);

  @observable
  ObservableList<PlayerModel> players = ObservableList<PlayerModel>();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<PlayerModel> matchedPlayers = ObservableList<PlayerModel>();

  @action
  Future<void> fetchPlayers() async {
    isLoading = true;
    final result = await getAvailablePlayers();
    players = result.asObservable();
    isLoading = false;
  }

  @action
  void addMatch(PlayerModel player) {
    matchedPlayers.add(player);
  }
}
