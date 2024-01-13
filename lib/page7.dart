import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Page7 extends StatefulWidget {
  const Page7({super.key});

  @override
  State<Page7> createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  late List<CameraDescription> _cameras;
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _cameras = await availableCameras();

    final selectedCamera = _cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first);

    controller = CameraController(selectedCamera, ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildPage() {
    if (controller == null) {
      return const CircularProgressIndicator();
    }
    if (!controller!.value.isInitialized) {
      return const CircularProgressIndicator();
    }

    return Stack(
      children: [
        CameraPreview(controller!),
        CustomPaint(
          painter: _MyPainter(),
          size: const Size(double.infinity, double.infinity),
        )
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      backgroundColor: Colors.white,
      body: _buildPage(),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = Colors.purple.withOpacity(.9)
    //   ..style = PaintingStyle.fill;

    // final paintCircle = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.fill;

    // canvas.drawRect(Offset.zero & size, paint);
    // canvas.drawOval(
    //     Rect.fromCenter(
    //       center: Offset(size.width / 2, size.height / 2),
    //       width: 200,
    //       height: 250,
    //     ),
    //     paintCircle);

    final paint = Paint()
      ..color = Colors.purple.withOpacity(.9)
      ..style = PaintingStyle.fill;

    final bgPath = Path()..addRect(Offset.zero & size);
    final maskPath = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 250,
        height: 350,
      ));
    final combinePath =
        Path.combine(PathOperation.difference, bgPath, maskPath);
    canvas.drawPath(combinePath, paint);
  }

  @override
  bool shouldRepaint(covariant _MyPainter oldDelegate) => true;
}
