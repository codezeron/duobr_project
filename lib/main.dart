import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/core/theme/app_theme.dart';
import 'package:duobr_project/presentation/pages/auth/login_page.dart';
import 'package:duobr_project/presentation/stores/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = getIt<ThemeStore>();
    return Observer(
      builder: (_) {
        return MaterialApp(
          home: LoginPage(),
          navigatorKey: navigatorKey,
          themeMode: themeStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          title: 'Duobr Project',
          initialRoute: AppRoutes.login,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
