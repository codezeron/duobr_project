import 'package:duobr_project/data/models/chat_model.dart';
import 'package:duobr_project/data/services/match_service.dart';
import 'package:mobx/mobx.dart';

part 'match_store.g.dart';

class MatchStore = _MatchStoreBase with _$MatchStore;

abstract class _MatchStoreBase with Store {
  final MatchService _matchService;

  _MatchStoreBase(this._matchService);

  @observable
  ObservableList<ChatModel> matches = ObservableList<ChatModel>();

  @observable
  ObservableList<String> matchedUserIds = ObservableList<String>();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchMatches(String userId) async {
    isLoading = true;
    final ids = await _matchService.getMatchedUserIds(userId);
    matchedUserIds = ObservableList.of(ids);
    isLoading = false;
  }
}
