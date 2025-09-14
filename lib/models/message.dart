class Message {
  final String id;
  final String fromId;
  final String toId;
  final String text;
  final DateTime timestamp;
  String status; // pending, sent, received, relayed

  Message({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.text,
    required this.timestamp,
    this.status = "pending",
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'fromId': fromId,
    'toId': toId,
    'text': text,
    'timestamp': timestamp.toIso8601String(),
    'status': status,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    fromId: json['fromId'],
    toId: json['toId'],
    text: json['text'],
    timestamp: DateTime.parse(json['timestamp']),
    status: json['status'] ?? "pending",
  );
}