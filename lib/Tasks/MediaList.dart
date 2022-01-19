import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_media_rider/Tasks/MediaCard.dart';
import 'package:o_media_rider/models/Location.dart';
import 'package:o_media_rider/utils/constants.dart';

class MediaList extends StatelessWidget {
  final List<MediaItem> images;
  final Function onPickFile;
  final Function onShowFull;
  const MediaList(
      {Key? key,
      required this.images,
      required this.onPickFile,
      required this.onShowFull})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> imageChildren = images
        .map(
          (file) => MediaCard(
            file: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    file.thumbnail,
                    fit: BoxFit.fill,
                    width: 120,
                    height: 120,
                  ),
                ),
                file.type == MediaFileType.video_media
                    ? const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white70,
                          size: 50,
                        ),
                      )
                    : Container(),
              ],
            ),
            type: MediaCardType.image_media,
            onClick: () {
              onShowFull(images.indexOf(file));
            },
          ),
        )
        .toList();
    imageChildren.add(
      MediaCard(
        file: const Icon(Icons.add, size: 60),
        type: MediaCardType.empty_media,
        onClick: () {
          onPickFile();
        },
      ),
    );

    return Container(
      height: 120,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imageChildren,
      ),
    );
  }
}
