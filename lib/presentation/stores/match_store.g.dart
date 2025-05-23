// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MatchStore on _MatchStoreBase, Store {
  late final _$matchesAtom =
      Atom(name: '_MatchStoreBase.matches', context: context);

  @override
  ObservableList<ChatModel> get matches {
    _$matchesAtom.reportRead();
    return super.matches;
  }

  @override
  set matches(ObservableList<ChatModel> value) {
    _$matchesAtom.reportWrite(value, super.matches, () {
      super.matches = value;
    });
  }

  late final _$matchedUserIdsAtom =
      Atom(name: '_MatchStoreBase.matchedUserIds', context: context);

  @override
  ObservableList<String> get matchedUserIds {
    _$matchedUserIdsAtom.reportRead();
    return super.matchedUserIds;
  }

  @override
  set matchedUserIds(ObservableList<String> value) {
    _$matchedUserIdsAtom.reportWrite(value, super.matchedUserIds, () {
      super.matchedUserIds = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MatchStoreBase.isLoading', context: context);

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

  late final _$fetchMatchesAsyncAction =
      AsyncAction('_MatchStoreBase.fetchMatches', context: context);

  @override
  Future<void> fetchMatches(String userId) {
    return _$fetchMatchesAsyncAction.run(() => super.fetchMatches(userId));
  }

  @override
  String toString() {
    return '''
matches: ${matches},
matchedUserIds: ${matchedUserIds},
isLoading: ${isLoading}
    ''';
  }
}
