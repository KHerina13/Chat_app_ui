import 'package:chat/Model/Chat_model.dart';
import 'package:chat/View/Screen/Individual_chat_screen.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;

  CustomCard({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatScreen(chatModel: chatModel,),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(
              chatModel.name ?? "No Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 3),
                Text(
                  chatModel.currentMessage.toString(),
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            trailing: Text(chatModel.time.toString()),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
