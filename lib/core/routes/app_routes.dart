import 'package:duobr_project/presentation/pages/auth/register_page.dart';
import 'package:duobr_project/presentation/pages/home_page.dart';
import 'package:duobr_project/presentation/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String search = '/search';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      // splash: (context) =>  SplashPage(),
      login: (context) => LoginPage(),
      register: (context) => RegisterPage(),
      home: (context) => HomePage(),
      //   search: (context) => SearchPage(),
      //   chat: (context) => ChatPage(),
      //   profile: (context) => ProfilePage(),
    };
  }
}
