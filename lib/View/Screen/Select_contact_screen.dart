import 'package:chat/Model/Chat_model.dart';
import 'package:chat/View/Widget/Button_card.dart';
import 'package:chat/View/Widget/Contact_card.dart';
import 'package:flutter/material.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contact = [
      ChatModel(name: "Dev Stack", status: "Flutter Developer"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "256 Contacts",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem(
                child: Text("Invite a friend"),
                value: "Invite a friend",
              ),
              const PopupMenuItem(
                child: Text("Contacts"),
                value: "Contacts",
              ),
              const PopupMenuItem(
                child: Text("Refresh"),
                value: "Refresh",
              ),
              const PopupMenuItem(
                child: Text("Help"),
                value: "Help",
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
          itemCount: contact.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {},
                child: ButtonCard(
                  icon: Icons.group,
                  name: "New Group",
                ),
              );
            } else if (index == 1) {
              return ButtonCard(icon: Icons.person_add, name: "New Contact");
            }
            return ContactCard(
              contact: contact[index - 2],
            );
          }),
    );
  }
}
