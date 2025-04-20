import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Features/Home/Domain/Entity/add_comment_entity.dart';
import 'package:frontend/Features/Home/Domain/Entity/trail_detail_entity.dart';
import 'package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Widget/CommentCard.dart';
import 'package:frontend/Features/Home/Presentation/Widget/Edit_Delete_Comment_Card.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

/// This Dart class named Home extends StatefulWidget.
class Traildetailpage extends StatefulWidget {
  const Traildetailpage(
      {super.key,
      required this.homeBloc,
      required this.taailId,
      required this.entity});
  final HomeBloc homeBloc;
  final int taailId;
  final TrailDetailEntity entity;

  @override
  State<Traildetailpage> createState() => _TraildetailPageState();
}

class _TraildetailPageState extends State<Traildetailpage> {
  String text =
      "The Annapurna Circuit is a legendary trek in Nepal 🇳🇵, crossing valleys, rivers, and peaks ⛰️, passing villages and monasteries 🏘️🙏, reaching the world’s highest pass, Thorong La at 5,416m 🗻🥶, with fast-changing weather 🌤️❄️, stunning views of Annapurna, Dhaulagiri & Manaslu 🏞️, friendly locals and dal bhat for energy 🥘👣, offering a true Himalayan adventure that touches the soul ❤️🧘; layer with base layers, fleece, down jacket, waterproof shell, thermal underwear, gloves, hat, UV sunglasses, eat high-carb meals, drink water, avoid alcohol, bring trekking poles, sturdy boots, a -10°C sleeping bag, water purification, first aid kit, headlamp, power bank, and offline GPS.";
  bool isExpanded = false;
  final TextEditingController _commentController = TextEditingController();
  late String userId = "0";
  String commentError = "";

  @override
  void initState() {
    widget.homeBloc.add(GetTrailCommentEvent(trailId: widget.taailId));
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                CarouselSlider(
                    options: CarouselOptions(height: 250, autoPlay: true),
                    items: widget.entity.images.map((e) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('$localHostUrl$e'))),
                        );
                      });
                    }).toList()),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 40),
                  child: GestureDetector(
                    onTap: () {
                      widget.homeBloc.add(GetAllTrailsEvent());
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Colors.white),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.entity.name,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.entity.location,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 180,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.entity.difficulty,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat("Altitude", "${widget.entity.altitude} Km"),
                  _buildStat(
                      "Distance", "${widget.entity.distance.toString()} km"),
                  _buildStat("Trail Type", widget.entity.trailType),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  const Text(
                    "Description ℹ️",
                    style: TextStyle(fontSize: 24),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Text(
                    maxLines: 20,
                    overflow: TextOverflow.clip,
                    isExpanded
                        ? widget.entity.description
                        : widget.entity.description.substring(0, 5),
                    style: const TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? "Read Less" : "Read More",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Reviews 📌",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 85, 85, 85),
                      fontWeight: FontWeight.w500),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Multiline Text Field for Comment
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: TextField(
                      // You need to define this controller
                      controller: _commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Write your comment...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    commentError,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {
                      if (_commentController.text.isEmpty) {
                        setState(() {
                          commentError = "Please Add comment";
                        });
                      } else if (_commentController.text.length < 6) {
                        setState(() {
                          commentError = "please add few more words";
                        });
                      } else {
                        commentError = "";
                        widget.homeBloc.add(
                          AddUserCommentEvent(
                            entity: AddCommentEntity(
                              commentText: _commentController.text,
                              trailId: widget.taailId,
                              userId: int.parse(userId),
                            ),
                          ),
                        );

                        _commentController.text = "";
                        toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          title: const Text('Comment Added'),
                          style: ToastificationStyle.minimal,
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                      }
                    }, // Call your logic here to handle the comment
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Comment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is GetTrailCommentSuccess) {
                  widget.homeBloc
                      .add(GetTrailCommentEvent(trailId: widget.taailId));
                }

                if (state is DeleteUserCommentSucess) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    title: const Text('Comment Deleted Sucessfully'),
                    style: ToastificationStyle.minimal,
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: widget.homeBloc,
                builder: (context, state) {
                  if (state is GetTrailCommentFailure) {
                    return const Text("Failed to load Reviews.");
                  }

                  if (state is GetTrailCommentSuccess) {
                    if (state.trailCommentList.isEmpty) {
                      return const Text("No Review available.");
                    }

                    return Column(
                      children: state.trailCommentList.map((e) {
                        if (e.userId.toString() == userId) {
                          return EditDeleteCommentCard(
                            commentEntity: e,
                            homeBloc: widget.homeBloc,
                            trailId: widget.taailId,
                          );
                        }
                        return Commentcard(
                          commentEntity: e,
                        );
                      }).toList(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.homeBloc
                            .add(GetTrailCommentEvent(trailId: widget.taailId));
                      },
                      icon: const Icon(Icons.refresh), // Material refresh icon
                      label: const Text("🔄 Fetch Comments"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("pId")!;
    });
  }
}
