import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.purple.withOpacity(.2),
          child: CustomPaint(
            painter: _MyPainter(),
            size: const Size(300, 200),
          ),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .1, size.height * .5)
      ..lineTo(size.width * .2, size.height * .2)
      ..lineTo(size.width * .3, size.height * .9)
      ..lineTo(size.width * .4, size.height * .3)
      ..lineTo(size.width * .5, size.height * .6)
      ..lineTo(size.width * .6, size.height * .3)
      ..lineTo(size.width * .7, size.height * .9)
      ..lineTo(size.width * .8, size.height * .5)
      ..lineTo(size.width * .9, size.height * .1)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MyPainter oldDelegate) => true;
}
