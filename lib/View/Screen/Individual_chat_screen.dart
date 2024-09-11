import 'dart:io';

import 'package:chat/Model/Chat_model.dart';
import 'package:chat/View/Widget/OwnMessage_card.dart';
import 'package:chat/View/Widget/Reply_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

import '../../Model/msg_model.dart';

class IndividualChatScreen extends StatefulWidget {
  final ChatModel? chatModel;
  final ChatModel? sourchat;

  IndividualChatScreen({this.chatModel, this.sourchat});

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendBtn = false;
  List<MessageModel> messages = [];
  ScrollController _scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.0.106.5000", {
      "transport": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signIn", widget.sourchat?.id);
    socket.onConnect((data) {
      print("connect");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg['message']);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Icon(
        //   Icons.keyboard_backspace,
        //   color: Colors.black,
        // ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_backspace),
                    CircleAvatar(
                      child: Icon(
                        widget.chatModel?.isGroup == true
                            ? Icons.group
                            : Icons.person,
                        color: Colors.white,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel?.name??"No Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "last seen at 12:05",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.videocam),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call),
                ),
                PopupMenuButton(itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links and docs"),
                      value: "Media, links and docs",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                    PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                    PopupMenuItem(
                      child: Text("Disappering mesages"),
                      value: "Disappering mesages",
                    ),
                    PopupMenuItem(
                      child: Text("More"),
                      value: "More",
                    ),
                  ];
                })
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: defaultMessages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == defaultMessages.length) {
                          return Container(height: 70);
                        }
                        if (defaultMessages[index].type == "sender") {
                          return OwnMessageCard(
                            message: defaultMessages[index].message.toString(),
                            time: defaultMessages[index].time.toString(),
                          );
                        } else {
                          return ReplayCard(
                            time: defaultMessages[index].time.toString(),
                            message: defaultMessages[index].message.toString(),
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (val) {
                                      if (val.length > 0) {
                                        setState(() {
                                          sendBtn = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendBtn = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message..",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: IconButton(
                                          icon: Icon(show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined),
                                          onPressed: () {
                                            if (!show) {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                            }
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder: (builder) =>
                                                        bottomSheet());
                                              },
                                              icon: Icon(Icons.attach_file),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.camera_alt),
                                            )
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8, right: 2, left: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    icon:
                                        Icon(sendBtn ? Icons.send : Icons.mic),
                                    onPressed: () {
                                      if (sendBtn) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _controller.text,
                                            widget.sourchat?.id ?? 0,
                                            widget.chatModel?.id ?? 0);
                                        _controller.clear();
                                        setState(() {
                                          sendBtn = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          // show?emojiSelect:Container();
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        margin: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 40),
                  IconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 40),
                  IconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(width: 40),
                  IconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(width: 40),
                  IconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget IconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
