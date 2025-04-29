import 'package:flutter/material.dart';
import 'package:duobr_project/presentation/widgets/theme_switcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showThemeSwitcher;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomAppBar({super.key, required this.title, this.actions, this.showThemeSwitcher = false, this.prefixIcon, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: prefixIcon,
      title: Text(title, style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color, fontSize: 24, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [if (suffixIcon != null) suffixIcon!, if (showThemeSwitcher) ThemeSwitcher(), ...?actions],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
