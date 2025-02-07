import 'package:flutter/material.dart';
import 'package:frontend/Features/Authentication/Presentation/Pages/Login.dart';
import 'package:frontend/Features/Authentication/Presentation/Pages/register.dart';
import 'package:frontend/Features/Home/Presentation/Page/Home.dart';
import 'package:frontend/Features/onboarding/Screen/onboarding_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "register":
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case "onboarding_screen":
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
