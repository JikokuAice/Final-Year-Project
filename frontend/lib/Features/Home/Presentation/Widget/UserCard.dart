import "package:flutter/material.dart";

import "package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart";
import "package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart";
import "package:frontend/Features/Travel_Route/Presentation/Screen/Travel_Route_Screen.dart";

class Usercard extends StatefulWidget {
  const Usercard({super.key, required this.data, required this.homeBloc});
  final HomeBloc homeBloc;
  final HikingCardItem data;
  @override
  State<Usercard> createState() => _UsercardState();
}

class _UsercardState extends State<Usercard> {
// make sure to initialize before map loading

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 110,
                  width: 180,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: FileImage(File(widget.data.images![0]))),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TravelRouteScreen(
                                id: widget.data.id,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.hiking_rounded,
                        ),
                        style: const ButtonStyle(
                            iconColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 31, 150, 71))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            widget.data.name ?? "Empty",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Manaslu circuit",
            style: TextStyle(),
          ),
          Row(
            children: [
              const Icon(Icons.star),
              Text(
                '${widget.data.rating}' ". ",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '${widget.data.difficulty}' ". ",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '${widget.data.length}' "KM",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
