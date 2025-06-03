import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: HomeScreen(),
    );
  }
}
