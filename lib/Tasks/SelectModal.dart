import 'package:flutter/material.dart';
import 'package:o_media_rider/utils/constants.dart';

class SelectModal extends StatefulWidget {
  final Function onPickFile;
  const SelectModal({Key? key, required this.onPickFile}) : super(key: key);

  @override
  _SelectModalState createState() => _SelectModalState();
}

class _SelectModalState extends State<SelectModal> {
  int _stepIndex = 0;
  MediaSourceType _sourceType = MediaSourceType.camera;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      margin: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              _stepIndex == 0 ? "Select source" : "Select Media Type",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          _stepIndex == 0 ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _sourceType = MediaSourceType.camera;
                          _stepIndex = 1;
                        });
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _sourceType = MediaSourceType.gallery;
                          _stepIndex = 1;
                        });
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.photo,
                            size: 30,
                          ),
                          Text("Gallery", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ]
          ): Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  _stepIndex = 0;
                  widget.onPickFile(_sourceType, MediaFileType.video_media);
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.video_call_rounded,
                      size: 30,
                    ),
                    Text("Video", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _stepIndex = 0;
                  widget.onPickFile(_sourceType, MediaFileType.image_media);
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                    Text("Photo", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
