import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../src/app_root.dart';

class VideoFile extends StatefulWidget {
  final String? urlVideo;
  const VideoFile({super.key, this.urlVideo});

  @override
  State<VideoFile> createState() => _VideoFileState();
}

class _VideoFileState extends State<VideoFile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  String? fileName='';

  @override
  void initState() {
    super.initState();
    Uri uri = Uri.parse(widget.urlVideo.toString());
    fileName = uri.pathSegments.last.split('/').last;
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.urlVideo.toString()),
      )
      ..initialize().then((_) {
        setState(() {});
      });
    _initializeVideoPlayerFuture = _controller.initialize();

  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName!),
        titleTextStyle: TextStyle(color: greenColor, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: greenColor),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greenColor,
                          width: 2,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VideoProgressIndicator(_controller, padding: EdgeInsets.all(10),allowScrubbing: true,colors: VideoProgressColors(playedColor: greenColor,backgroundColor: backgroundColor)),
                  ),




                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // FloatingActionButton(
          //   onPressed: () {
          //     // Wrap the play or pause in a call to `setState`. This ensures the
          //     // correct icon is shown.
          //     setState(() {
          //       // If the video is playing, pause it.
          //       if (_controller.value.isPlaying) {
          //         _controller.pause();
          //       } else {
          //         // If the video is paused, play it.
          //         _controller.play();
          //       }
          //     });
          //   },
          //   backgroundColor: backgroundColor,
          //   // Display the correct icon depending on the state of the player.
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //     color: greenColor,
          //   ),
          // ),
          FloatingActionButton(
            onPressed: () {
              // Wrap the play or pause in a call to `setState`. This ensures the
              // correct icon is shown.
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            backgroundColor: backgroundColor,
            // Display the correct icon depending on the state of the player.
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: greenColor,
            ),
          ),

          // FloatingActionButton(
          //   backgroundColor: backgroundColor,
          //
          //   onPressed: () {
          //     // Wrap the play or pause in a call to `setState`. This ensures the
          //     // correct icon is shown.
          //     setState(() {
          //       // If the video is playing, pause it.
          //       if (_controller.value.isPlaying) {
          //         _controller.pause();
          //       } else {
          //         // If the video is paused, play it.
          //         _controller.play();
          //       }
          //     });
          //   },
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //     color: greenColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
