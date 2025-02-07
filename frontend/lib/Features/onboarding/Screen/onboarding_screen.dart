import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/Core/Network/dio_client.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final dio = createDio(baseUrl: "https://192.168.100.7:5001");

  Future<void> tryApiCall() async {
    try {
      debugPrint("API Call Started...");
      var response = await dio.get("/Admin/Test");
      debugPrint("Response: ${response.data}");
    } catch (e) {
      debugPrint("API Call Failed: $e");
    }
  }

  @override
  void initState() {
    tryApiCall();
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
    bool isOnBoard = prefs.getBool('IsOnBoard') ?? false;
    var isLoggedIn = prefs.get("acessToken") != null;
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
