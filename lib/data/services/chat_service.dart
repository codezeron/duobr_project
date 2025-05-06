import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duobr_project/data/models/chat_model.dart';
import 'package:duobr_project/data/models/message_model.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createChatIfNotExists({required String userId1, required String userId2}) async {
    final query = await _firestore.collection('chats').where('userIds', arrayContains: userId1).get();

    final existingChat = query.docs.firstWhere((doc) {
      final userIds = List<String>.from(doc['userIds']);
      return userIds.contains(userId2);
    });

    if (existingChat == null) {
      await _firestore.collection('chats').add(ChatModel.create(userId1, userId2).toJson());
    }
  }

  Future<List<ChatModel>> getUserChats(String userId) async {
    final snapshot = await _firestore.collection('chats').where('userIds', arrayContains: userId).orderBy('lastMessageTime', descending: true).get();

    return snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
  }

  Stream<List<MessageModel>> listenToMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => MessageModel.fromDocument(doc)).toList());
  }

  Future<void> sendMessage({required String chatId, required String senderId, required String content}) async {
    final timestamp = DateTime.now();

    final message = MessageModel(id: '', senderId: senderId, content: content, timestamp: timestamp);

    final messageRef = _firestore.collection('chats').doc(chatId).collection('messages').doc();

    await messageRef.set(message.copyWith(id: messageRef.id).toJson());

    // Atualizar chat principal
    await _firestore.collection('chats').doc(chatId).update({'lastMessage': content, 'lastMessageTime': timestamp});
  }

  Future<String> getChatId(String userId1, String userId2) async {
    final query = await _firestore.collection('chats').where('userIds', arrayContains: userId1).get();

    for (var doc in query.docs) {
      final userIds = List<String>.from(doc['userIds']);
      if (userIds.contains(userId2)) {
        return doc.id;
      }
    }

    // Se não existir, criar novo chat
    final newChat = ChatModel.create(userId1, userId2);
    final docRef = await _firestore.collection('chats').add(newChat.toJson());
    return docRef.id;
  }
}
