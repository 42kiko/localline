import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LocalLineApp());
}

class LocalLineApp extends StatelessWidget {
  const LocalLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LocalLine",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}