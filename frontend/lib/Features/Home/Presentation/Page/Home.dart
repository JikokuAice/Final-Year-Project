import 'package:flutter/material.dart';
import 'package:frontend/Features/Home/Presentation/Widget/Card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Spacer(),
          const Text(
            "Lets Start Hiking,🥾🏕️📸",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
        backgroundColor: const Color(0xFF008080),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 218, 218, 218),
          unselectedItemColor: const Color.fromARGB(159, 16, 175, 53),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF008080),
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
      body: GridView.builder(
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: TrailCard(),
            );
          }),
    );
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
              splashColor: Color.fromARGB(255, 224, 224, 224),
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
