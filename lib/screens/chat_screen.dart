import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton<String>(
            underline:
                SizedBox(), //Don’t draw anything below the button==>removes the weird short line in your AppBar
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem<String>(
                value: 'logout', // Unique value for this item
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app_sharp), // Logout icon
                    SizedBox(width: 8), // Space between icon and text
                    Text('Logout'), // Text label
                  ],
                ),
              ),
            ],
            // Called when an item is selected
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
