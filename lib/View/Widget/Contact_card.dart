import 'package:chat/Model/Chat_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;

  ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            contact.isSelect == true
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      title: Text(
        contact.name.toString(),
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact.status.toString(),
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
