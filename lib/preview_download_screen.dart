import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    // Listen for video changes
    _controller.addListener(() {
      print('Video Player State: ${_controller.value}');
    });
  }

  // Function to open the video URL in the default browser
  _launchURL() async {
    const url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _downloadVideo() async {
    final url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final file = File('${appDocumentsDirectory.path}/downloaded_video.mp4');

      await file.writeAsBytes(response.bodyBytes);

      print('Video downloaded successfully!');
    } else {

      print('Failed to download video. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Spacer(),
            Spacer(),
            if (_controller.value.isInitialized) Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14), // Set border radius
                  child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height*0.70,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_controller),
                          Opacity(
                            opacity: 0.8,
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: Icon(
                                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.black,
                                size: 36.0,
                              ),
                              mini: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) else CircularProgressIndicator(),
            Spacer(), // Add spacer to push the buttons to the bottom
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  _downloadVideo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/download.png',
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Download Video",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "SF Pro",
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5917E7), // Set button color
                  fixedSize: Size(double.maxFinite, 56), // Set button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // Set border radius
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Add your second button click logic here
                },
                child: Text(
                  "Create New",
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
                    borderRadius: BorderRadius.circular(14), // Set border radius
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
