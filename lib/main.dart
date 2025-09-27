import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      // Use the builder to apply gradient to all screens
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 237, 42, 247),
                Color.fromARGB(255, 97, 0, 89),
              ],
            ),
          ),
          child: child,
        );
      },
      home: const HomePage(),
    );
  }
}