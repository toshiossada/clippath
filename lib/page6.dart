import 'dart:math' as math;

import 'package:flutter/material.dart';

class Page6 extends StatefulWidget {
  const Page6({super.key});

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  final txtHour = TextEditingController(text: DateTime.now().hour.toString());
  final txtMinutes =
      TextEditingController(text: DateTime.now().minute.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtHour,
                    keyboardType: TextInputType.number,
                    onSubmitted: (s) => setState(() {}),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Horas',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(':'),
                ),
                Expanded(
                  child: TextField(
                    controller: txtMinutes,
                    keyboardType: TextInputType.number,
                    onSubmitted: (s) => setState(() {}),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Minutos',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      txtHour.text = DateTime.now().hour.toString();
                      txtMinutes.text = DateTime.now().minute.toString();
                      setState(() {});
                    },
                    child: const Text('Set Time to Now'),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: CustomPaint(
              painter: _MyPainter(
                  hour: int.parse(txtHour.text),
                  minute: int.parse(txtMinutes.text)),
              size: const Size(300, 300),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  final int hour;
  final int minute;

  _MyPainter({
    required this.hour,
    required this.minute,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arcPaint = Paint()
      ..color = Colors.black45.withOpacity(.4)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final tickPaint = Paint()
      ..color = Colors.black45
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final circlePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Offset.zero & size,
      0,
      math.pi * 2,
      false,
      arcPaint,
    );

    final midleSize = size.width / 2;

    for (var i = 0; i < 12; i++) {
      final angle = i * (math.pi * 2 / 12);

      final start = Offset(
        midleSize + math.cos(angle) * (size.width * 0.48),
        midleSize + math.sin(angle) * (size.width * 0.48),
      );

      final end = Offset(
        midleSize + math.cos(angle) * (size.width * 0.45),
        midleSize + math.sin(angle) * (size.width * 0.45),
      );

      canvas.drawLine(start, end, tickPaint);
    }

    final (angles) = timeToAngles(hours: hour, minutes: minute);

    final startHour = Offset(midleSize + math.cos(angles.angleHour),
        midleSize + math.sin(angles.angleHour));
    final endHour = Offset(
        midleSize + math.cos(angles.angleHour) * (size.width * 0.2),
        midleSize + math.sin(angles.angleHour) * (size.width * 0.2));

    final startMinutes = Offset(midleSize + math.cos(angles.angleMinutes),
        midleSize + math.sin(angles.angleMinutes));
    final endMinutes = Offset(
        midleSize + math.cos(angles.angleMinutes) * (size.width * .4),
        midleSize + math.sin(angles.angleMinutes) * (size.width * .4));

    final armHourPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final armMinPaint = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(startHour, endHour, armHourPaint);
    canvas.drawLine(startMinutes, endMinutes, armMinPaint);

    canvas.drawCircle(Offset(midleSize, midleSize), 6, circlePaint);
  }

  @override
  bool shouldRepaint(covariant _MyPainter oldDelegate) => true;

  ({double angleHour, double angleMinutes}) timeToAngles({
    required int hours,
    required int minutes,
  }) {
    const baseAngle = math.pi * 2;
    final minute = ((minutes / 60));
    final hour = (((hours % 12) / 12) + ((1 / 12) * minute));
    final angleMinutes = baseAngle * minute - math.pi / 2;
    final angleHour = baseAngle * hour - math.pi / 2;

    return (angleHour: angleHour, angleMinutes: angleMinutes);
  }
}
