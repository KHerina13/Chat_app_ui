class MessageModel {
  String? type;   // 'sender' or 'receiver'
  String? message;
  String? time;

  MessageModel({this.time, this.message, this.type});
}

// Sample default message data
List<MessageModel> defaultMessages = [
  MessageModel(
    type: "sender",
    message: "Hey! How are you?",
    time: "10:30 AM",
  ),
  MessageModel(
    type: "receiver",
    message: "I'm good! How about you?",
    time: "10:32 AM",
  ),
  MessageModel(
    type: "sender",
    message: "Doing well, thanks for asking.",
    time: "10:34 AM",
  ),
  MessageModel(
    type: "receiver",
    message: "That's great to hear!",
    time: "10:35 AM",
  ),
];
