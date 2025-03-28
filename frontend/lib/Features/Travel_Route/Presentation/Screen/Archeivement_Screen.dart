import "package:flutter/material.dart";
import "package:gap/gap.dart";

class ArcheivementScreen extends StatefulWidget {
  const ArcheivementScreen(
      {super.key,
      required this.speed,
      required this.distanceTravelled,
      required this.timeTaken});
  final String speed;
  final String timeTaken;
  final String distanceTravelled;
  @override
  State<ArcheivementScreen> createState() => _ArcheivementScreenState();
}

class _ArcheivementScreenState extends State<ArcheivementScreen> {
  var detailTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  double iconSize = 32;
  String distanceTravelled = "0";
  String timeTaken = "0";
  String speed = "0";
  String hikeName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/you-did-it.png",
              fit: BoxFit.cover,
            ),
          ),
          const Gap(15),
          const Text(
            "Congratulation 🥳",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.hiking_outlined,
                    size: iconSize,
                  ),
                  Text(
                    "${widget.distanceTravelled} km",
                    style: detailTextStyle,
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: iconSize,
                  ),
                  Text(
                    "${widget.timeTaken}",
                    style: detailTextStyle,
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.speed_outlined,
                    size: iconSize,
                  ),
                  Text(
                    "${widget.speed} km/hr",
                    style: detailTextStyle,
                  )
                ],
              )
            ],
          ),
          const Gap(15),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Congrats on completing your hike! 🎉 You just conquered [Hike Name]! Keep exploring and pushing your limits! 🚶‍♂️🏞️",
              style: TextStyle(
                  color: Color.fromARGB(255, 84, 117, 134),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  wordSpacing: 1),
            ),
          ),
          const Gap(30),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "");
              },
              child: Text("Proceed"))
        ],
      ),
    );
  }
}
