import 'package:flutter/material.dart';
import 'package:frontend/Features/Admin/presentation/Screen/Update_trial.dart';
import 'package:frontend/Features/Admin/presentation/Screen/add_map.dart';
import 'package:frontend/Features/Admin/presentation/Screen/create_trail.dart';
import 'package:frontend/Features/Authentication/Presentation/Pages/Login.dart';
import 'package:frontend/Features/Authentication/Presentation/Pages/register.dart';
import 'package:frontend/Features/Home/Presentation/Page/Home.dart';
import 'package:frontend/Features/Profile/Presentation/Screen/Profile_Screen.dart';
import 'package:frontend/Features/Travel_Route/Presentation/Screen/Travel_Route_Screen.dart';
import 'package:frontend/Features/onboarding/Screen/onboarding_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "register":
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case "profile":
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case "onboarding_screen":
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case "add_map":
        return MaterialPageRoute(builder: (_) => const AddMap());
      case "create_trail":
        return MaterialPageRoute(builder: (_) => const CreateTrail());
      case "travel_route":
        return MaterialPageRoute(builder: (_) => TravelRouteScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
