import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              logout();
              Navigator.popAndPushNamed(context, "login");
            },
            child: const Row(
              children: [
                Text(
                  "Log Out",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Gap(10),
                Icon(Icons.logout)
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("acessToken");
    prefs.remove("refreshToken");
    prefs.remove("role");
  }
}
