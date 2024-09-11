class ChatModel {
  String? name;
  String? icon;
  String? time;
  bool? isGroup;
  String? currentMessage;
  String? status;
  int? id;
  bool? isSelect;

  ChatModel({
    this.id,
    this.name,
    this.icon,
    this.status,
    this.time,
    this.currentMessage,
    this.isGroup,
    this.isSelect,
  });
}

// Create a list of default chat data
List<ChatModel> defaultChats = [
  ChatModel(
    id: 1,
    name: "Alice",
    icon: "assets/images/alice.png",
    status: "Online",
    time: "10:30 AM",
    currentMessage: "Hello, how are you?",
    isGroup: false,
    isSelect: false,
  ),
  ChatModel(
    id: 2,
    name: "Bob",
    icon: "assets/images/bob.png",
    status: "Away",
    time: "11:00 AM",
    currentMessage: "Are we still meeting?",
    isGroup: false,
    isSelect: false,
  ),
  ChatModel(
    id: 3,
    name: "Work Group",
    icon: "assets/images/group.png",
    status: "Active",
    time: "1:00 PM",
    currentMessage: "Let's review the project.",
    isGroup: true,
    isSelect: false,
  ),
];
