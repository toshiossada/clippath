import 'dart:math' as math;

import 'package:flutter/material.dart';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> with SingleTickerProviderStateMixin {
  late final animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late final animationArc =
      Tween<double>(begin: 0, end: 2 * math.pi).animate(animationController);
  late final animationText =
      IntTween(begin: 0, end: 100).animate(animationController);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      animationController.reset();
                    },
                    child: const Text('Reset')),
                ElevatedButton(
                    onPressed: () {
                      animationController.reset();
                      animationController.forward();
                    },
                    child: const Text('Start')),
              ],
            ),
            AnimatedBuilder(
                animation: animationController,
                builder: (
                  context,
                  snapshot,
                ) {
                  return CustomPaint(
                    painter: _ProgressBarPainter(
                      progressArc: animationArc.value,
                      progressText: animationText.value,
                    ),
                    size: const Size(200, 200),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  final double progressArc;
  final int progressText;

  _ProgressBarPainter({
    required this.progressArc,
    required this.progressText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Offset.zero & size,
      3 * math.pi / 2,
      progressArc,
      false,
      paint,
    );

    final textSpan = TextSpan(
      text: '$progressText %',
      style: const TextStyle(
        color: Colors.deepPurple,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final middleX = size.width / 2 - textPainter.width / 2;
    final middleY = size.height / 2 - textPainter.height / 2;
    textPainter.paint(canvas, Offset(middleX, middleY));
  }

  @override
  bool shouldRepaint(covariant _ProgressBarPainter oldDelegate) =>
      oldDelegate.progressArc != progressArc ||
      oldDelegate.progressText != progressText;
}
