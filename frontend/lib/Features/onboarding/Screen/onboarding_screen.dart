import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    onBoardingCompleted();
    navigateToApplication();
    super.initState();
  }

  Future<void> onBoardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsOnBoard", true);
  }

  Future<void> navigateToApplication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("acessToken");
    bool isOnBoard = prefs.getBool('IsOnBoard') ?? false;
    var isLoggedIn = token != null;
    var checkTokenExpiry =
        isLoggedIn ? JwtDecoder.isExpired(token.toString()) : true;

    if (token == null || checkTokenExpiry) {
      prefs.remove("accessToken");
      prefs.remove("refreshToken");
      Navigator.pushReplacementNamed(context, "login");
      return;
    }

    if (!isOnBoard) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "onboarding_screen");
    } else if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "");
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: const Color(0xFF008080),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              "Nepali Hiking App",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Image(
              image: AssetImage(
                "assets/onboardImage.png",
              ),
              height: 250,
              width: 300,
            ),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
