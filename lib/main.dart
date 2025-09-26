import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import the landing page

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
      // Use a builder to apply the gradient background globally
      home: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 237, 42, 247), // Pink
              Color.fromARGB(255, 97, 0, 89),     // Dark purple
            ],
          ),
        ),
        child: const HomePage(), // Landing page content
      ),
    );
  }
}
