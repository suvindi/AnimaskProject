import 'package:flutter/material.dart';
import 'package:sw/capture_screen.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:sw/processing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late CameraDescription firstCamera;

  @override
  void initState() {
    super.initState();
    initCamera();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
      );
    });
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/face generator.png',
                width: 126,
                height: 126,
              ),
              SizedBox(height: 8),
              Text(
                "Animask",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "SF Pro",
                ),
              ),
            ],
          ),
        ),

    );
  }
}
