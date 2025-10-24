import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

   const CustomBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: CustomPaint(
          size: Size(size, size),
          painter: BackButtonPainter(
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

class BackButtonPainter extends CustomPainter {
  final Color color;

  BackButtonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw the triangular arrow pointing left (increased size)
    path.moveTo(size.width * 0.25, size.height * 0.5); // Tip of arrow (moved left)
    path.lineTo(size.width * 0.45, size.height * 0.25); // Top corner (taller)
    path.lineTo(size.width * 0.45, size.height * 0.75); // Bottom corner (taller)
    path.close();

    canvas.drawPath(path, paint);

    // Draw the line/dash on the right
    final lineRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.55,
        size.height * 0.45,
        size.width * 0.25,
        size.height * 0.1,
      ),
      const Radius.circular(2),
    );

    canvas.drawRRect(lineRect, paint);
  }

  @override
  bool shouldRepaint(BackButtonPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}