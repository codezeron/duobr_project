import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/presentation/stores/home_store.dart';
import 'package:duobr_project/presentation/widgets/swipe_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:duobr_project/data/models/player_model.dart';
import 'package:duobr_project/presentation/widgets/player_card.dart';

class PlayerSwiper extends StatefulWidget {
  final List<PlayerModel> players;
  final CardSwiperController controller;

  const PlayerSwiper({super.key, required this.players, required this.controller});

  @override
  State<PlayerSwiper> createState() => _PlayerSwiperState();
}

class _PlayerSwiperState extends State<PlayerSwiper> {
  final ValueNotifier<String?> _swipeFeedback = ValueNotifier(null);

  final List<String> _likedPlayers = [];
  final List<PlayerModel> _matchedPlayers = [];

  void _handleSwipeMatch(int index, CardSwiperDirection direction) {
    final player = widget.players[index];

    if (direction == CardSwiperDirection.right) {
      _likedPlayers.add(player.id); // Simula like

      // Simula que o outro jogador também deu like (match)
      // Em produção, isso viria do backend
      bool hasMatched = true;

      if (hasMatched) {
        _matchedPlayers.add(player);

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("🔥 It's a Match!"),
                content: Text("Você e ${player.name} se curtiram!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Aqui depois você pode navegar para o chat ou salvar esse match
                    },
                    child: const Text("Bater um papo"),
                  ),
                ],
              ),
        );
      }
    }
  }

  void _updateSwipeFeedback(CardSwiperDirection? direction) {
    final directionText = {
      CardSwiperDirection.right: "Like 💚",
      CardSwiperDirection.left: "Dislike ❌",
      CardSwiperDirection.top: "Super Like ⭐",
      CardSwiperDirection.bottom: "Pular 👋",
    };

    _swipeFeedback.value = directionText[direction];
  }

  void _clearSwipeFeedback() {
    _swipeFeedback.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [_buildSwiper(context), SwipeFeedback(feedbackNotifier: _swipeFeedback)]);
  }

  Widget _buildSwiper(BuildContext context) {
    return CardSwiper(
      cardsCount: widget.players.length,
      numberOfCardsDisplayed: 2,
      controller: widget.controller,
      backCardOffset: const Offset(0, 0),
      padding: const EdgeInsets.all(24),
      isLoop: false,
      cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
        final player = widget.players[index];
        return PlayerCard(player: player);
      },
      // onSwipeDirectionChange: (oldDirection, newDirection) {
      //   if (oldDirection != newDirection) {
      //     _clearSwipeFeedback();
      //     if (newDirection == CardSwiperDirection.left || newDirection == CardSwiperDirection.right) {
      //       // Handle horizontal swipe
      //       _updateSwipeFeedback(newDirection);
      //     } else if (newDirection == CardSwiperDirection.top || newDirection == CardSwiperDirection.bottom) {
      //       // Handle vertical swipe
      //       _updateSwipeFeedback(newDirection);
      //     }
      //   }
      // },
      onSwipe: (previousIndex, currentIndex, direction) {
        _updateSwipeFeedback(direction);

        if (currentIndex! < widget.players.length) {
          final matchedPlayer = widget.players[previousIndex];
          getIt<HomeStore>().addMatch(matchedPlayer);
        }
        return true;
      },
    );
  }
}
