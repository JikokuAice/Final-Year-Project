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
            backgroundColor: const Color(0xFFE7E7E7),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: const Text(
                "My Profile",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Ayush Karki", // Replace with dynamic value if available
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "ayush@example.com", // Replace with dynamic value if available
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      logout();
                      Navigator.popAndPushNamed(context, "login");
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 2, color: Colors.grey),
                  const Text(
                    "USER ACTIVITY",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.grey),
                  const SizedBox(height: 10),
                  if (state is UserActivityFetchedSuccess)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.userActivity.length,
                        itemBuilder: (context, i) {
                          final activity = state.userActivity[i];
                          return UserActivityCard(
                            trailType: activity!.trailType,
                            trailName: activity.trailName,
                            activityDate: activity.activityDate,
                            distanceCovered: activity.distanceCovered,
                            image: activity.images,
                            location: activity.location,
                            avgSpeed: activity.avgSpeed,
                            difficulty: activity.difficulty,
                            timeElapsed: activity.timeElapsed,
                          );
                        },
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color(0xFFE7E7E7),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: const Text(
                "My Profile",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Ayush Karki", // Replace with dynamic value if available
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "ayush@example.com", // Replace with dynamic value if available
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      logout();
                      Navigator.popAndPushNamed(context, "login");
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 2, color: Colors.grey),
                  const Text(
                    "USER ACTIVITY",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.grey),
                  const SizedBox(height: 10),
                  if (state is UserActivityFetchedSuccess)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.userActivity.length,
                        itemBuilder: (context, i) {
                          final activity = state.userActivity[i];
                          return UserActivityCard(
                            trailType: activity!.trailType,
                            trailName: activity.trailName,
                            activityDate: activity.activityDate,
                            distanceCovered: activity.distanceCovered,
                            image: activity.images,
                            location: activity.location,
                            avgSpeed: activity.avgSpeed,
                            difficulty: activity.difficulty,
                            timeElapsed: activity.timeElapsed,
                          );
                        },
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
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
