import 'package:flutter/material.dart';

class TicTacToeLogo extends StatelessWidget {
  const TicTacToeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150),
      painter: _TicTacToePainter(),
    );
  }
}

class _TicTacToePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Outer circle
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);

    // Shrink grid to fit inside circle with padding
    final double padding = 20; // margin inside circle
    final double gridSize = size.width - (padding * 2);
    final double third = gridSize / 3;

    final double startX = padding;
    final double startY = padding;

    // Grid lines
    for (int i = 1; i < 3; i++) {
      // vertical
      canvas.drawLine(
        Offset(startX + third * i, startY),
        Offset(startX + third * i, startY + gridSize),
        paint,
      );
      // horizontal
      canvas.drawLine(
        Offset(startX, startY + third * i),
        Offset(startX + gridSize, startY + third * i),
        paint,
      );
    }

    // X in top-left
    canvas.drawLine(
      Offset(startX + 10, startY + 10),
      Offset(startX + third - 10, startY + third - 10),
      paint,
    );
    canvas.drawLine(
      Offset(startX + third - 10, startY + 10),
      Offset(startX + 10, startY + third - 10),
      paint,
    );

    // O in bottom-right
    canvas.drawCircle(
      Offset(startX + third * 2 + third / 2, startY + third * 2 + third / 2),
      third / 2 - 10,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}