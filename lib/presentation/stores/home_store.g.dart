// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$playersAtom =
      Atom(name: '_HomeStoreBase.players', context: context);

  @override
  ObservableList<PlayerModel> get players {
    _$playersAtom.reportRead();
    return super.players;
  }

  @override
  set players(ObservableList<PlayerModel> value) {
    _$playersAtom.reportWrite(value, super.players, () {
      super.players = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$matchedPlayersAtom =
      Atom(name: '_HomeStoreBase.matchedPlayers', context: context);

  @override
  ObservableList<PlayerModel> get matchedPlayers {
    _$matchedPlayersAtom.reportRead();
    return super.matchedPlayers;
  }

  @override
  set matchedPlayers(ObservableList<PlayerModel> value) {
    _$matchedPlayersAtom.reportWrite(value, super.matchedPlayers, () {
      super.matchedPlayers = value;
    });
  }

  late final _$fetchPlayersAsyncAction =
      AsyncAction('_HomeStoreBase.fetchPlayers', context: context);

  @override
  Future<void> fetchPlayers() {
    return _$fetchPlayersAsyncAction.run(() => super.fetchPlayers());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void addMatch(PlayerModel player) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.addMatch');
    try {
      return super.addMatch(player);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
players: ${players},
isLoading: ${isLoading},
matchedPlayers: ${matchedPlayers}
    ''';
  }
}
