import 'package:flutter/material.dart';
import 'package:pomodoroschallenge/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromARGB(255, 224, 74, 86),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(
              0xFF232B55,
            ),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}
