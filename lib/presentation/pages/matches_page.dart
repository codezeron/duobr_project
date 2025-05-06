import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/data/models/player_model.dart';
import 'package:duobr_project/data/services/chat_service.dart';
import 'package:duobr_project/domain/repositories/player_repository_impl.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';
import 'package:duobr_project/presentation/stores/chat_store.dart';
import 'package:duobr_project/presentation/stores/match_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'chat_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final MatchStore matchStore = getIt<MatchStore>();
  final ChatService chatService = getIt<ChatService>();
  final PlayerRepositoryImpl playerRepository = getIt<PlayerRepositoryImpl>();
  final String currentUserId = getIt<AuthStore>().user!.uid;

  @override
  void initState() {
    super.initState();
    matchStore.fetchMatches(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (matchStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (matchStore.matchedUserIds.isEmpty) {
          return const Center(child: Text("Nenhum match encontrado."));
        }

        return ListView.builder(
          itemCount: matchStore.matchedUserIds.length,
          itemBuilder: (_, index) {
            final matchedUserId = matchStore.matchedUserIds[index];
            return FutureBuilder<PlayerModel?>(
              future: playerRepository.getPlayerById(matchedUserId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Loading...'));
                }
                final player = snapshot.data!;
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(player.avatarUrl)),
                  title: Text(player.name),
                  subtitle: Text(player.id ?? ''),
                  onTap: () async {
                    final chatId = await chatService.getChatId(currentUserId, matchedUserId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatPage(chatId: chatId, currentUserId: currentUserId, otherUser: player)),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Agora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min atrás';
    if (diff.inHours < 24) return '${diff.inHours} h atrás';
    return '${diff.inDays} d atrás';
  }
}
