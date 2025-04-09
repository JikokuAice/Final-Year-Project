import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Profile/Presentation/Widgets/user_activity_card.dart';
import 'package:frontend/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? jwtToken;
  late Bloc blocProfile;

  @override
  void initState() {
    blocProfile = BlocProvider.of<ProfileBloc>(context);
    getUserToken().then((e) async =>
        {jwtToken = e, blocProfile.add(FetchUserActivityEvent(token: e!))});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserActivityFetchedSuccess) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Gap(10),
                      Icon(Icons.logout)
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                const Text(
                  "USER ACTIVITY",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: state.userActivity.length,
                        itemBuilder: (context, int i) {
                          return UserActivityCard(
                            trailType: state.userActivity[i]!.trailType,
                            trailName: state.userActivity[i]!.trailName,
                            activityDate: state.userActivity[i]!.activityDate,
                            distanceCovered:
                                state.userActivity[i]!.distanceCovered,
                            image: state.userActivity[i]!.images,
                            location: state.userActivity[i]!.location,
                            avgSpeed: state.userActivity[i]!.avgSpeed,
                            difficulty: state.userActivity[i]!.difficulty,
                            timeElapsed: state.userActivity[i]!.timeElapsed,
                          );
                        }))
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Gap(10),
                      Icon(Icons.logout)
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                const Text(
                  "USER ACTIVITY",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("acessToken");
    prefs.remove("refreshToken");
    prefs.remove("role");
  }

  Future<String?> getUserToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.get("acessToken").toString();
  }
}
