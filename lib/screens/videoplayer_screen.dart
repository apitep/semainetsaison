import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';

import '../controllers/app_controller.dart';
import '../controllers/sound_controller.dart';
import '../screens/home_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key, this.title, this.url, this.parentIsPortrait}) : super(key: key);
  static const routeName = '/videoplayer';
  final String url;
  final String title;
  final bool parentIsPortrait;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  SoundController soundController = AppController.to.soundController;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  bool _visibleButtons = false;

  @override
  void initState() {
    soundController.musicBackground(false);
    _controller = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.addListener(checkVideo);
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    if (widget.parentIsPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _visibleButtons = !_visibleButtons;
                        });
                      },
                      child: VideoPlayer(_controller),
                    ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _visibleButtons,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  });
                },
                child: Icon(
                  Icons.home,
                ),
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkVideo() {
    // video started
    if (_controller.value.position == Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    // video ended
    if (_controller.value.position == _controller.value.duration) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
