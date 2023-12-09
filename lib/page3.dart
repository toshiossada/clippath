import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wave'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          painter: _MyPainter(),
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintPurple = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, paintPurple);
    final paintGreen = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .5, 0)
      ..quadraticBezierTo(
          size.width * .2, size.height * .2, size.width * .5, size.height * .5)
      ..quadraticBezierTo(
          size.width * .7, size.height * .7, size.width * .5, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.clipPath(path);
    canvas.drawRect(Offset.zero & size, paintGreen);
  }

  @override
  bool shouldRepaint(covariant _MyPainter oldDelegate) => true;
}
