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
    final double third = size.width / 3;

    // Neon grid
    _drawNeonLine(canvas, Offset(third, 0), Offset(third, size.height));
    _drawNeonLine(canvas, Offset(third * 2, 0), Offset(third * 2, size.height));
    _drawNeonLine(canvas, Offset(0, third), Offset(size.width, third));
    _drawNeonLine(canvas, Offset(0, third * 2), Offset(size.width, third * 2));

    // Neon X
    _drawNeonLine(canvas, const Offset(15, 15), Offset(third - 15, third - 15));
    _drawNeonLine(canvas, Offset(third - 15, 15), Offset(15, third - 15));

    // Neon O
    _drawNeonCircle(
      canvas,
      Offset(third * 2 + third / 2, third * 2 + third / 2),
      third / 2 - 15,
    );
  }

  void _drawNeonLine(Canvas canvas, Offset start, Offset end) {
    // Subtle glow (thin but layered)
    for (int i = 3; i > 0; i--) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.15 * i)
        ..strokeWidth = i.toDouble() + 1 // 2px to 4px max
        ..style = PaintingStyle.stroke;
      canvas.drawLine(start, end, paint);
    }
    // Main thin border
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, paint);
  }

  void _drawNeonCircle(Canvas canvas, Offset center, double radius) {
    // Subtle glow
    for (int i = 3; i > 0; i--) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.15 * i)
        ..strokeWidth = i.toDouble() + 1 // 2px to 4px max
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, paint);
    }
    // Main thin border
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
