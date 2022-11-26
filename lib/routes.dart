import 'package:flutter/material.dart';
import 'package:university_app/screens/dashboard/dashboard_view.dart';
import 'package:university_app/screens/login/login_view.dart';
import 'package:university_app/screens/profile/profile_view.dart';
import 'package:university_app/screens/splash/splash_view.dart';
import 'package:university_app/screens/university_list/university_list_view.dart';

mixin Routes {
  static const String splash = '/';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String profile = 'profile';
  static const String universityList = 'universityList';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute<SplashView>(
            settings: const RouteSettings(name: splash),
            builder: (BuildContext buildContext) => const SplashView());

      case login:
        return MaterialPageRoute<LoginView>(
            settings: const RouteSettings(name: login),
            builder: (BuildContext buildContext) => const LoginView());

      case dashboard:
        return MaterialPageRoute<Dashboard>(
            settings: const RouteSettings(name: dashboard),
            builder: (BuildContext buildContext) => const Dashboard());

      case profile:
        return MaterialPageRoute<ProfileView>(
            settings: const RouteSettings(name: profile),
            builder: (context) => const ProfileView());

      case universityList:
        return MaterialPageRoute<ProfileView>(
            settings: const RouteSettings(name: universityList),
            builder: (context) => const UniversityListView());

      default:
        return MaterialPageRoute<LoginView>(
            settings: const RouteSettings(name: login),
            builder: (BuildContext buildContext) => const LoginView());
    }
  }
}
