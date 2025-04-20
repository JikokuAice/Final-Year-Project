import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:frontend/Features/Home/Domain/Entity/comment_entity.dart";
import "package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart";
import "package:gap/gap.dart";

class EditDeleteCommentCard extends StatefulWidget {
  const EditDeleteCommentCard(
      {super.key,
      required this.commentEntity,
      required this.homeBloc,
      required this.trailId});
  final CommentEntity commentEntity;
  final Bloc homeBloc;
  final int trailId;

  @override
  State<EditDeleteCommentCard> createState() => _EditDeleteCommentCardState();
}

class _EditDeleteCommentCardState extends State<EditDeleteCommentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/15937754/pexels-photo-15937754/free-photo-of-horses-behind-fence.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'), // Replace with the user's profile image URL
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.commentEntity
                                .userName, // Replace with dynamic user name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'March 25, 2025', // Replace with dynamic comment date
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Comment Text
                  Text(
                    widget.commentEntity.text,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  // Like Button and Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Like Button
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up,
                                color:
                                    const Color.fromARGB(255, 190, 190, 190)),
                            onPressed: () {
                              // Add logic to handle like action
                            },
                          ),
                          Text(
                            widget.commentEntity.likes
                                .toString(), // Number of likes (Replace dynamically)
                            style: TextStyle(fontSize: 14),
                          ),
                          Gap(20),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_sharp,
                              color: Color.fromARGB(255, 24, 163, 100),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.homeBloc.add(DeleteUserCommentEvent(
                                  commentId: widget.commentEntity.id,
                                  userId: widget.commentEntity.userId));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: const Color.fromARGB(255, 249, 93, 82),
                            ),
                          ),
                        ],
                      ),
                      // Optionally add more action buttons like reply, share, etc.
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
