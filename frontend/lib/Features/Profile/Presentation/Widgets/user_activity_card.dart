import 'package:flutter/material.dart';
import 'package:frontend/Features/Profile/Presentation/Screen/activity_detail.dart';

class UserActivityCard extends StatelessWidget {
  final String trailName;
  final String distanceCovered;
  final String image;
  final String activityDate;
  final String location;
  final String avgSpeed;
  final String timeElapsed;
  final String difficulty;
  final String trailType;

  const UserActivityCard(
      {super.key,
      required this.trailName,
      required this.activityDate,
      required this.distanceCovered,
      required this.image,
      required this.location,
      required this.avgSpeed,
      required this.difficulty,
      required this.timeElapsed,
      required this.trailType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityDetail(
                trailName: trailName,
                distanceCovered: distanceCovered,
                image: image,
                activityDate: activityDate,
                location: location,
                avgSpeed: avgSpeed,
                difficulty: difficulty,
                timeElapsed: timeElapsed,
                trailType: trailType,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trailName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              activityDate.split("T")[0],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.directions_walk,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '$distanceCovered km',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
