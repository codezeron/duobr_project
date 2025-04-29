import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
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
  final _authStore = getIt<AuthStore>();

  final List<Widget> _pages = [
    Center(child: Text("Página Inicial")),
    Center(child: Text("Buscar")),
    Center(child: Text("Chat")),
    Center(child: Text("Perfil")),
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
          bottomNavigationBar: CustomBottomNav(currentIndex: _currentIndex, onTap: (index) => setState(() => _currentIndex = index)),
        );
      },
    );
  }
}
