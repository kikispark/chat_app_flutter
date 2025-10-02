import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.userId, {super.key});

  final String message;
  final bool isMe;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: !isMe ? Colors.teal : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        width: screenWidth * 0.4,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.012,
          horizontal: screenWidth * 0.04,
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.005, // 0.5%
          horizontal: screenWidth * 0.02, // 2%
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading ...');
                }
                return Text(
                  asyncSnapshot.data!['username'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).colorScheme.onSecondary,
                  ),
                );
              },
            ),
            Text(
              textAlign: isMe ? TextAlign.end : TextAlign.start,
              message,
              style: TextStyle(
                color: isMe
                    ? Colors.black
                    : Theme.of(context).colorScheme.onSecondary,
                // borderRadius:BorderRadius.only(topLeft: )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
