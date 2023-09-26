class Chat {
  String id;
  String senderId;
  String receiverId;
  String message;
  DateTime createdAt;

  Chat(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.message,
      required this.createdAt});
}
