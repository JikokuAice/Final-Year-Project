import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Widget/Card.dart';
import 'package:frontend/Features/Home/Presentation/Widget/UserCard.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeBloc.add(GetAllTrailsEvent());
    });
  }

  Future<String> getPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("role") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error fetching role')),
          );
        }

        String role = snapshot.data ?? "";

        return Scaffold(
          appBar: AppBar(
            actions: [
              const Spacer(),
              const Text(
                "Let's Start Hiking 🥾🏕️📸",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
            toolbarHeight: 100,
            backgroundColor: const Color(0xFF008080),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: role == "Admin"
                ? const Color(0xFF008080)
                : const Color.fromARGB(159, 16, 175, 53),
            backgroundColor:
                role == "Admin" ? const Color(0xFF008080) : Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    // Home page logic
                  },
                  icon: const Icon(Icons.home),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    if (role == "Admin") {
                      Navigator.pushNamed(context, "create_trail");
                    }
                    // You can handle user differently if needed
                  },
                  icon: Icon(role == "Admin"
                      ? Icons.edit_location_sharp
                      : Icons.hiking),
                ),
                label: "Trail Nearby",
              ),
              if (role != "Admin")
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {
                      // Favorites page
                    },
                  ),
                  label: "Favorites",
                ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.person_2_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, "profile");
                  },
                ),
                label: "Profile",
              ),
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetAllTrailEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/No_Data.png"),
                        height: 300,
                      ),
                      const Gap(10),
                      const Text("No Trails Found"),
                      const Gap(10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008080),
                        ),
                        onPressed: () {
                          toastification.show(
                            context: context,
                            type: ToastificationType.info,
                            title:
                                const Text('Fetching data. Please wait 🌐🗄️'),
                            style: ToastificationStyle.minimal,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          homeBloc.add(GetAllTrailsEvent());
                        },
                        child: const Text("Try Again",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              if (state is GetAllTrialSucess) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.fetchedData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final data = state.fetchedData[index];
                    return role != "Admin"
                        ? Usercard(data: data, homeBloc: homeBloc)
                        : TrailCard(data: data, homeBloc: homeBloc);
                  },
                );
              }

              if (state is GetAllTrialFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/Server_Error.png"),
                        height: 300,
                      ),
                      const Gap(10),
                      const Text("Server error occurred."),
                      const Gap(10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008080),
                        ),
                        onPressed: () {
                          toastification.show(
                            context: context,
                            type: ToastificationType.info,
                            title:
                                const Text('Retrying to fetch data 🌐🗄️...'),
                            style: ToastificationStyle.minimal,
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          homeBloc.add(GetAllTrailsEvent());
                        },
                        child: const Text("Try Again",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              );
            },
          ),
        );
      },
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<String> suggestions = [
    "Everest Trail",
    "Manaslu Trail",
    "Annapurna Circuit",
    "Langtang Valley",
    "IIC"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Center(
       : Text("Search result for \"$query\""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> filteredSuggestions = suggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
