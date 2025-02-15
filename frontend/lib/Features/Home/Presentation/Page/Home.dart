import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Widget/Card.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(GetAllTrailsEvent());
    });
  }

  Future<String> getPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get("role").toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPrefs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ); // Show a loading indicator while fetching role
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
                  "Lets Start Hiking,🥾🏕️📸",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => {
                          showSearch(
                            context: context,
                            delegate: MySeachDelegate(),
                          ),
                        },
                    icon: const Icon(
                      color: Colors.white,
                      Icons.search_rounded,
                      size: 35,
                    ))
              ],
              toolbarHeight: 100,
              backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            bottomNavigationBar: role == "Admin"
                ? BottomNavigationBar(
                    selectedItemColor: const Color.fromARGB(255, 218, 218, 218),
                    unselectedItemColor: const Color(0xFF008080),
                    items: [
                        BottomNavigationBarItem(
                          icon: IconButton(
                            onPressed: () => {
                              //   Navigator.pushReplacementNamed(context, ""),
                            },
                            icon: const Icon(Icons.home),
                          ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: IconButton(
                            icon: const Icon(Icons.edit_location_sharp),
                            onPressed: () => {
                              Navigator.pushNamed(context, "create_trail"),
                            },
                          ),
                          label: "Trail Nearby",
                        ),
                        BottomNavigationBarItem(
                            icon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person_2_outlined),
                            ),
                            label: "Profile")
                      ])
                : BottomNavigationBar(
                    selectedItemColor: const Color.fromARGB(255, 218, 218, 218),
                    unselectedItemColor: const Color.fromARGB(159, 16, 175, 53),
                    items: [
                        BottomNavigationBarItem(
                          backgroundColor: const Color(0xFF008080),
                          icon: IconButton(
                            onPressed: () => {
                              //   Navigator.pushReplacementNamed(context, ""),
                            },
                            icon: const Icon(Icons.home),
                          ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: IconButton(
                            icon: const Icon(Icons.hiking),
                            onPressed: () => {
                              // Navigator.popAndPushNamed(context, ""),
                            },
                          ),
                          label: "Trail Nearby",
                        ),
                        BottomNavigationBarItem(
                            icon: IconButton(
                              icon: const Icon(Icons.star),
                              onPressed: () {
                                //Navigator.popAndPushNamed(context, "");
                              },
                            ),
                            label: "Favorities"),
                        BottomNavigationBarItem(
                            icon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person_2_outlined),
                            ),
                            label: "Profile")
                      ]),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is GetAllTrailEmpty) {
                  return const Center(
                    child: Text("No Trials Exist to be fetched"),
                  );
                }
                if (state is GetAllTrialSucess) {
                  return GridView.builder(
                      itemCount: state.fetchedData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: TrailCard(
                            data: state.fetchedData[index],
                          ),
                        );
                      });
                }
                if (state is GetAllTrialFailure) {
                  return Center(
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage("assets/Server_Error.png"),
                          height: 350,
                          width: 350,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xFF008080),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "onboarding_screen");
                          },
                          child: const Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              },
            ),
          );
        });
  }
}

class MySeachDelegate extends SearchDelegate {
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
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> buildSuggestions = ["Everest Trail", "Manaslu Trail"];
    return Theme(
      data: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 226, 138, 138)),
      child: ListView.builder(
          itemCount: buildSuggestions.length,
          itemBuilder: (context, index) {
            String suggestion = buildSuggestions[index];
            return ListTile(
              splashColor: const Color.fromARGB(255, 224, 224, 224),
              style: ListTileStyle.list,
              title: Text(suggestion),
              onTap: () {
                query = suggestion;
              },
            );
          }),
    );
  }
}
