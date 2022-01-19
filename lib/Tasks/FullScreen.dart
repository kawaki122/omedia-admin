import 'dart:io';

import 'package:flutter/material.dart';
import 'package:o_media_rider/models/Location.dart';
import 'package:o_media_rider/utils/constants.dart';
import 'package:video_player/video_player.dart';

class FullScreen extends StatefulWidget {
  final MediaItem? file;
  final Function deleteFile;
  const FullScreen({Key? key, required this.file, required this.deleteFile})
      : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.file!.type == MediaFileType.video_media) {
      _controller = VideoPlayerController.file(widget.file!.file);
      _controller.initialize().then((value) => setState(() {}));
      _controller.setLooping(true);
      _controller.play();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.file!.type == MediaFileType.video_media) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.file!.type == MediaFileType.image_media
                ? Image.file(widget.file!.file)
                : AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ClosedCaption(text: _controller.value.caption.text),
                        // _ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(bottom: 10),
              color: Colors.black38,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      widget.deleteFile();
                    },
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
            ),
          ),
          widget.file!.type == MediaFileType.video_media ? Center(
            child: IconButton(
              icon: Icon(_controller.value.isPlaying ? Icons.pause_circle_filled: Icons.play_circle_fill),
              onPressed: () {
                if(_controller.value.isPlaying){
                  _controller.pause();
                } else {
                  _controller.play();
                }
                setState(() {});
              },
              color: Colors.white70,
              iconSize: 100,
            ),
          ):Container(),
        ],
      ),
    );
  }
}
