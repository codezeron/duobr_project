import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/presentation/pages/matches_page.dart';
import 'package:duobr_project/presentation/stores/chat_store.dart';
import 'package:duobr_project/presentation/stores/home_store.dart';
import 'package:duobr_project/presentation/widgets/custom_appbar.dart';
import 'package:duobr_project/presentation/widgets/player_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';
import 'package:duobr_project/presentation/widgets/custom_bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final CardSwiperController _swiperController = CardSwiperController();
  final _authStore = getIt<AuthStore>();
  final _homeStore = getIt<HomeStore>();

  @override
  void initState() {
    super.initState();
    _homeStore.fetchPlayers();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  List<Widget> get _pages => [
    Observer(
      builder: (_) {
        if (_homeStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final players = _homeStore.players;

        if (players.isEmpty) {
          return const Center(child: Text("Nenhum jogador encontrado."));
        }

        return PlayerSwiper(players: players, controller: _swiperController);
      },
    ),
    const Center(child: Text("Buscar")),
    MatchesPage(),
    const Center(child: Text("Perfil")),
  ];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Duobr Project",
            showThemeSwitcher: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await _authStore.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
              ),
            ],
          ),
          body: _pages[_currentIndex],
          bottomNavigationBar: CustomBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
          ),
        );
      },
    );
  }
}
