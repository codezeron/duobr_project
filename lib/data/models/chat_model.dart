import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final List<String> userIds;
  final String lastMessage;
  final DateTime? lastMessageTime;

  ChatModel({required this.id, required this.userIds, required this.lastMessage, this.lastMessageTime});

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      userIds: List<String>.from(data['userIds'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'userIds': userIds, 'lastMessage': lastMessage, 'lastMessageTime': lastMessageTime};
  }

  static ChatModel create(String userId1, String userId2) {
    return ChatModel(
      id: '', // Firestore atribuirá automaticamente
      userIds: [userId1, userId2],
      lastMessage: '',
      lastMessageTime: null,
    );
  }
}
