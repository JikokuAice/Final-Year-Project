import "package:flutter/material.dart";
import "package:gap/gap.dart";

class TrailCard extends StatefulWidget {
  const TrailCard({super.key});

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
          const Text(
            "Heading Trail Name dfdf",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Manaslu Himalya, Nepal",
            style: TextStyle(),
          ),
          const Row(
            children: [
              Icon(Icons.star),
              Text(
                "4.5" ". ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Easy" ". ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "4.5" "KM",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
