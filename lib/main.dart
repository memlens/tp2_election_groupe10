import 'package:flutter/material.dart';
import 'package:tp2_election_groupe10/pages/showelect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Election App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowElectPage(),
    );
  }
}