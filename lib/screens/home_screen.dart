import 'package:flutter/material.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> fakeContacts = [
    {"id": "userA", "name": "Alice"},
    {"id": "userB", "name": "Bob"},
    {"id": "userC", "name": "Clara"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LocalLine")),
      body: ListView.builder(
        itemCount: fakeContacts.length,
        itemBuilder: (context, index) {
          final contact = fakeContacts[index];
          return ListTile(
            title: Text(contact["name"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    peerId: contact["id"]!,
                    peerName: contact["name"]!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}