import 'package:flutter/material.dart';
import 'package:o_media_rider/utils/constants.dart';
import 'dart:io';

class MediaCard extends StatelessWidget {
  final Widget file;
  final MediaCardType type;
  final Function onClick;
  const MediaCard({Key? key, required this.file, required this.type, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(0)),
        ),
        onPressed: () {onClick();},
        child: file,
      ),
      width: 120,
      decoration: const BoxDecoration(
        color: Color(0xDCDCDCDC),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
