import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('logged user ${user}');
    return StreamBuilder(
      // FutureBuilder → rebuild once when async task finishes
      // StreamBuilder → rebuild continuously as new data arrives
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data!.docs;
        print('chat docs ${chatDocs[0]['userId']}');
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            (chatDocs[index]['text']),
            chatDocs[index]['userId'] == user!.uid,
            chatDocs[index]['userId'],
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
