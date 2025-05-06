// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ChatStore.isLoading', context: context);

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

  late final _$chatsAtom = Atom(name: '_ChatStore.chats', context: context);

  @override
  ObservableList<ChatModel> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<ChatModel> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_ChatStore.messages', context: context);

  @override
  ObservableList<MessageModel> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<MessageModel> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatStore.sendMessage', context: context);

  @override
  Future<void> sendMessage(
      {required String chatId,
      required String senderId,
      required String content}) {
    return _$sendMessageAsyncAction.run(() => super
        .sendMessage(chatId: chatId, senderId: senderId, content: content));
  }

  late final _$getUserNameByIdAsyncAction =
      AsyncAction('_ChatStore.getUserNameById', context: context);

  @override
  Future<String> getUserNameById(String uid) {
    return _$getUserNameByIdAsyncAction.run(() => super.getUserNameById(uid));
  }

  late final _$_ChatStoreActionController =
      ActionController(name: '_ChatStore', context: context);

  @override
  void listenToMessages(String chatId) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.listenToMessages');
    try {
      return super.listenToMessages(chatId);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.clearMessages');
    try {
      return super.clearMessages();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
chats: ${chats},
messages: ${messages}
    ''';
  }
}
