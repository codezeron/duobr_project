import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duobr_project/data/models/chat_model.dart';
import 'package:duobr_project/data/models/message_model.dart';
import 'package:duobr_project/data/services/chat_service.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final ChatService _chatService;

  _ChatStore(this._chatService);

  @observable
  bool isLoading = false;

  @observable
  ObservableList<ChatModel> chats = ObservableList<ChatModel>();

  @observable
  ObservableList<MessageModel> messages = ObservableList<MessageModel>();

  @action
  void listenToMessages(String chatId) {
    messages.clear();
    _chatService.listenToMessages(chatId).listen((list) {
      messages = ObservableList.of(list);
    });
  }

  @action
  Future<void> sendMessage({required String chatId, required String senderId, required String content}) async {
    await _chatService.sendMessage(chatId: chatId, senderId: senderId, content: content);
  }

  @action
  Future<String> getUserNameById(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data()?['name'] ?? 'Desconhecido';
    }
    return 'Desconhecido';
  }

  @action
  void clearMessages() {
    messages.clear();
  }
}
