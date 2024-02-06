class ChatModel {
  final String senderId;
  final String receiverId;
  final String receiverName;
  final String senderName;
   String? massageId;
  List? images ;

  final String message;
  final String time;
  final bool? isWatched;
   bool? isTyping;

  String? chatId;


  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    this.chatId,
    this.images,
    this.isWatched,


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
      'images': images,
      'message': message,
      'isWatched': isWatched,
      'isTyping': isTyping,
      'time': time,

    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String chatId) {
    return ChatModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      images: map['images'] ?? [],
      senderName: map['senderName'] ?? '',
      message: map['message'] ?? '',
      chatId: chatId ,

      isWatched: map['isWatched'] ?? false,
      time: map['time'] ?? '',
    );
  }
}