import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart";
import "package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart";
import "package:frontend/Features/Home/Presentation/Page/TrailDetailPage.dart";
import "package:frontend/Features/Travel_Route/Presentation/Screen/Travel_Route_Screen.dart";
import "package:frontend/contrant/Network_Route.dart";

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
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetTrailDetailSucess &&
            state.trailDetailEntity.name == widget.data.name &&
            state.trailDetailEntity.difficulty == widget.data.difficulty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Traildetailpage(
                homeBloc: widget.homeBloc,
                taailId: widget.data.id,
                entity: state.trailDetailEntity,
              ),
            ),
          );
        }
      },
      child: SizedBox(
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
                  GestureDetector(
                    onTap: () {
                      widget.homeBloc
                          .add(GetTrailDetailEvent(trailId: widget.data.id));
                    },
                    child: Container(
                      height: 110,
                      width: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '$localHostUrl${widget.data.images![0]}'),
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                    ),
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
      ),
    );
  }
}
