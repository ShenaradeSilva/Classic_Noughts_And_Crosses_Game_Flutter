import 'package:flutter/material.dart';
import '../logo/logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Keep transparent so main.dart gradient shows
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tic Tac Toe Game',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const TicTacToeLogo(),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                // Navigate to your GameScreen here later
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25, // smaller width
                  vertical: 12,  // smaller height
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Game',
                style: TextStyle(fontSize: 16), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
