import 'package:chat/View/Screen/Select_contact_screen.dart';
import 'package:chat/View/Widget/Custom_Card.dart';
import 'package:flutter/material.dart';

import '../../Model/Chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SelectContactScreen()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: defaultChats.length,
          itemBuilder: (context, index) {
            return CustomCard(
              chatModel: defaultChats[index],
            );
          }),
    );
  }
}
