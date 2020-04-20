import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controllerFront;

  final double mirror = 3.1415;

  @override
  void initState() {
    super.initState();

    //Front camera initialization
    controllerFront = CameraController(cameras[1], ResolutionPreset.medium);
    controllerFront.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controllerFront?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controllerFront.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controllerFront.value.aspectRatio,
        child: Transform(
            alignment: Alignment.center,
            child: CameraPreview(controllerFront),
            transform: Matrix4.rotationZ(-mirror/2)*Matrix4.rotationY(mirror)
        )
    );
  }
}