import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;

  MessageModel({required this.id, required this.senderId, required this.content, required this.timestamp});

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'senderId': senderId, 'content': content, 'timestamp': timestamp};
  }

  MessageModel copyWith({String? id}) {
    return MessageModel(id: id ?? this.id, senderId: senderId, content: content, timestamp: timestamp);
  }
}
