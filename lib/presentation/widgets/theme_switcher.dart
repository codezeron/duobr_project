import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/presentation/stores/theme_store.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final themeStore = getIt<ThemeStore>();
    return Observer(
      builder: (_) {
        return IconButton(
          icon: Icon(themeStore.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).appBarTheme.actionsIconTheme?.color),
          onPressed: themeStore.toggleTheme,

          tooltip: themeStore.isDarkMode ? 'Modo claro' : 'Modo escuro',
        );
      },
    );
  }
}
