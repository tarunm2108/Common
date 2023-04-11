class ChatNotification {
  String title;
  String body;
  String token;
  Map<String, dynamic>? data;

  ChatNotification({
    required this.title,
    required this.body,
    required this.token,
    this.data,
  });
}
