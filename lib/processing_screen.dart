import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sw/preview_download_screen.dart';

class ProcessingScreen extends StatefulWidget {
  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>VideoApp()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 280,),
              Image.asset(
                'assets/face generator.png',
                width: 126,
                height: 126,
              ),
              SizedBox(height: 8),
              Text(
                "Preparing your generation...",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "SF Pro",
                ),
              ),
              Spacer(),
              Text(
                "Please wait, while we work our Magic!\n"
                    "It can take around 20 seconds.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "SF Pro",
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),

    );
  }
}
