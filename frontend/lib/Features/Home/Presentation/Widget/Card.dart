import "dart:io";

import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:frontend/Features/Admin/presentation/Bloc/admin_bloc.dart";
import "package:frontend/Features/Admin/presentation/Screen/Update_trial.dart";
import "package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart";
import "package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart";
import "package:gap/gap.dart";

class TrailCard extends StatefulWidget {
  const TrailCard({super.key, required this.data, required this.homeBloc});
  final HomeBloc homeBloc;
  final HikingCardItem data;
  @override
  State<TrailCard> createState() => _TrailCardState();
}

class _TrailCardState extends State<TrailCard> {
  late AdminBloc _adminBloc;

// make sure to initialize before map loading

  @override
  void initState() {
    _adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(widget.data.images![0]))),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateTrial(id: widget.data.id)));
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                        style: const ButtonStyle(
                            iconColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 31, 150, 71))),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          _adminBloc
                              .add(DeleteTrailWithMapEvent(id: widget.data.id));
                          widget.homeBloc.add(GetAllTrailsEvent());
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                        ),
                        style: const ButtonStyle(
                            iconColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 255, 136, 136))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Gap(5),
          Text(
            widget.data.name ?? "Empty",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                style: TextStyle(fontWeight: FontWeight.w500),
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
