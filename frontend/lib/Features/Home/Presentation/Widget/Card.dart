import "package:flutter/material.dart";
import "package:frontend/Features/Home/Domain/Entity/Hiking_Card_Item.dart";
import "package:gap/gap.dart";

class TrailCard extends StatefulWidget {
  const TrailCard({super.key, required this.data});
  final HikingCardItem data;
  @override
  State<TrailCard> createState() => _TrailCardState();
}

class _TrailCardState extends State<TrailCard> {
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
            child: Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
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
                '${widget.data.length}' " KM",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
