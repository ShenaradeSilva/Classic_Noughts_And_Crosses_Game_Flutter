import 'package:flutter/material.dart';
import '../logo/logo.dart';
import 'dart:math';

enum Player { x, o }

class PlayerCard extends StatelessWidget {
  final String name;
  final Player symbol;

  const PlayerCard({super.key, required this.name, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            symbol.name.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final Player playerSymbol;
  final String playerName;
  final String difficulty;

  const GameScreen({
    super.key,
    required this.playerSymbol,
    required this.playerName,
    required this.difficulty,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Player?> board = List.filled(9, null);
  late Player currentPlayer;
  bool gameOver = false;
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    currentPlayer = widget.playerSymbol;
  }

  void _makeMove(int index) {
    if (board[index] != null || gameOver) return;

    setState(() {
      board[index] = currentPlayer;

      if (_checkWinner(currentPlayer)) {
        gameOver = true;
        resultMessage = '${currentPlayer.name.toUpperCase()} Wins!';
      } else if (!board.contains(null)) {
        gameOver = true;
        resultMessage = 'Draw!';
      } else {
        currentPlayer = currentPlayer == Player.x ? Player.o : Player.x;
      }
    });
  }

  bool _checkWinner(Player player) {
    List<List<int>> winLines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var line in winLines) {
      if (line.every((index) => board[index] == player)) return true;
    }
    return false;
  }

  Widget _buildCell(int index) {
    return GestureDetector(
      onTap: () => _makeMove(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            board[index]?.name.toUpperCase() ?? '',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, null);
      gameOver = false;
      resultMessage = '';
      currentPlayer = widget.playerSymbol;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 237, 42, 247),
              Color.fromARGB(255, 97, 0, 89),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar: Back button | Logo + text | Player card
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),

                    // Logo + text
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: TicTacToeLogo(size: 40),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Tic Tac Toe Game',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Player card
                    PlayerCard(
                      name: widget.playerName,
                      symbol: widget.playerSymbol,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Player info
              Text(
                '${widget.playerName} vs AI (${widget.difficulty})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              // Center grid
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) => _buildCell(index),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Result & Restart button
              if (gameOver)
                Column(
                  children: [
                    Text(
                      resultMessage,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _resetGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Restart',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
