import 'package:flutter/material.dart';
import 'package:duobr_project/data/models/player_model.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagem do jogador
              Expanded(child: Image.network(player.avatarUrl, fit: BoxFit.cover, width: double.infinity)),
              const SizedBox(height: 16),

              // Nome e rank
              Text(player.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),

              Text('Rank: ${player.rank}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),

              const SizedBox(height: 16),

              // Games preferidos (exemplo)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children:
                    player.games.map((game) {
                      return Chip(label: Text(game), backgroundColor: Colors.grey[200]);
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
