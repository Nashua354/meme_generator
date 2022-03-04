import 'package:flutter/material.dart';
import 'package:meme_generator/screens/home_screen.dart';
import 'package:meme_generator/utils/locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
