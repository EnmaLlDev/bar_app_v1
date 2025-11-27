import 'views/HomeView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BarApp());
}

class BarApp extends StatelessWidget {
  const BarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bar App v.1.0.1',
      home: const HomeView(),
    );
  }
}