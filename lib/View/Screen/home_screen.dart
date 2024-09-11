import 'package:chat/View/Screen/Chat_Screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          PopupMenuButton(
              onSelected: (val) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("New group"),
                    value: "New group",
                  ),
                  PopupMenuItem(
                    child: Text("New broadcast"),
                    value: "New broadcast",
                  ),
                  PopupMenuItem(
                    child: Text("Linked devices"),
                    value: "Linked devices",
                  ),
                  PopupMenuItem(
                    child: Text("Starred messages"),
                    value: "Starred messages",
                  ),
                  PopupMenuItem(
                    child: Text("Payments"),
                    value: "Payments",
                  ),
                  const PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  )
                ];
              }),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.chat_rounded),
              text: "Chats",
            ),
            Tab(
              icon: Icon(Icons.update),
              text: "Updates",
            ),
            Tab(
              icon: Icon(Icons.people_outline),
              text: "Communites",
            ),
            Tab(
              icon: Icon(Icons.call),
              text: "Calls",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatScreen(),
          Text("Update"),
          Text("Communite"),
          Text("Calls"),
        ],
      ),
    );
  }
}
