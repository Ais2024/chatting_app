class Message {
  String message;
  final String id;

  Message({required this.message , required this.id});

  factory Message.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Message(message: '', id: '');
    }
    return Message(message: json['message'] as String? ??'', id: '');
  }
}


