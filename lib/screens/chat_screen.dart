import 'package:flutter/material.dart';
import '../models/message.dart';
import '../utils/id_generator.dart';
import '../services/db_service.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerName;

  ChatScreen({required this.peerId, required this.peerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final loaded = await DBService.getMessages();
    setState(() {
      messages = loaded.where((m) =>
        (m.fromId == "me123" && m.toId == widget.peerId) ||
        (m.fromId == widget.peerId && m.toId == "me123")
      ).toList();
    });
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    final msg = Message(
      id: generateMessageId(),
      fromId: "me123",
      toId: widget.peerId,
      text: _controller.text,
      timestamp: DateTime.now(),
      status: "pending",
    );

    setState(() {
      messages.insert(0, msg);
    });

    DBService.saveMessage(msg);
    _controller.clear();

    // BLEService.sendMessage(peerDevice, msg); // später
  }

  Widget _buildBubble(Message msg, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.peerName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg.fromId == "me123";
                return _buildBubble(msg, isMe);
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(hintText: "Nachricht schreiben..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}