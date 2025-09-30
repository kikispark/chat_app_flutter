import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // FutureBuilder → rebuild once when async task finishes
      // StreamBuilder → rebuild continuously as new data arrives
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt')
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => Text(chatDocs[index]['text']),
        );
      },
    );
  }
}
