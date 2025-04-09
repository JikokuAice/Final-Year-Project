import 'package:flutter/material.dart';

class ActivityDetail extends StatefulWidget {
  const ActivityDetail(
      {super.key,
      required this.trailName,
      required this.distanceCovered,
      required this.image,
      required this.activityDate,
      required this.location,
      required this.avgSpeed,
      required this.timeElapsed,
      required this.difficulty,
      required this.trailType});
  final String trailName;
  final String distanceCovered;
  final String image;
  final String activityDate;
  final String location;
  final String avgSpeed;
  final String timeElapsed;
  final String difficulty;
  final String trailType;

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  var iconList = [
    Icons.speed,
    Icons.hiking,
    Icons.timer_outlined,
    Icons.battery_2_bar_rounded,
    Icons.turn_sharp_left_outlined
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Text(
              widget.trailName,
              style: const TextStyle(fontSize: 30),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, int i) {
                    var itemText = "";
                    switch (i) {
                      case 0:
                        itemText = "${widget.avgSpeed} km/hr";
                        break;
                      case 1:
                        itemText = "${widget.distanceCovered} km";
                        break;
                      case 2:
                        itemText = "${widget.timeElapsed} min";
                        break;
                      case 3:
                        itemText = widget.difficulty;
                        break;
                      case 4:
                        itemText = widget.trailType;
                        break;
                    }

                    return Container(
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            iconList[i],
                            size: 32,
                          ),
                          Text(itemText,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600))
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
