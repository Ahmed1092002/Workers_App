class ChatModel {
  final String senderId;
  final String receiverId;
  final String receiverName;
  final String senderName;

  final String message;
  final String time;

  String? chatId;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    this.chatId,

    required this.message,
    required this.time,
    required this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderName': senderName,

      'message': message,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String chatId) {
    return ChatModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      senderName: map['senderName'] ?? '',
      message: map['message'] ?? '',
      chatId: chatId ,
      time: map['time'] ?? '',
    );
  }
}