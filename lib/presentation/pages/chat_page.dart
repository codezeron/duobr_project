import 'package:duobr_project/data/models/player_model.dart';
import 'package:duobr_project/data/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:duobr_project/presentation/stores/chat_store.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';
import 'package:duobr_project/core/di/injector.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final PlayerModel otherUser;

  const ChatPage({super.key, required this.chatId, required this.otherUser, required this.currentUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatStore chatStore = getIt<ChatStore>();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatStore.listenToMessages(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherUser.name)),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                final messages = chatStore.messages;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == widget.currentUserId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: isMe ? Theme.of(context).colorScheme.primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message.content, style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('HH:mm').format(message.timestamp),
                              style: TextStyle(fontSize: 10, color: isMe ? Colors.white70 : Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _messageController, decoration: const InputDecoration(hintText: "Digite uma mensagem..."))),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final content = _messageController.text.trim();
                    if (content.isNotEmpty) {
                      chatStore.sendMessage(chatId: widget.chatId, senderId: widget.currentUserId, content: content);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
