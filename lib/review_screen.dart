import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sw/processing_screen.dart';


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 40),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xff151515),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/arrow_back.png',
                        width: 17.7,
                        height: 17.7,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 51,),
                Text(
                  "Review your image",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "SF Pro",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(14.0), // Set the desired border radius
                  child: Image.file(
                    File(imagePath),
                    width: double.maxFinite, // Set the desired width
                    height: double.maxFinite, // Set the desired height
                    fit: BoxFit.cover, // Adjust the BoxFit as needed
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProcessingScreen(),
                    ),
                  );
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "SF Pro",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5917E7), // Set button color
                  fixedSize: Size(double.maxFinite, 56), // Set button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14), // Set border radius
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
