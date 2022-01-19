import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_media_rider/Tasks/FullScreen.dart';
import 'package:o_media_rider/Tasks/MediaList.dart';
import 'package:o_media_rider/Tasks/SelectModal.dart';
import 'package:o_media_rider/models/Location.dart';
import 'package:o_media_rider/providers/location_provider.dart';
import 'package:o_media_rider/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class TaskDetail extends StatefulWidget {
  final Location location;
  const TaskDetail({Key? key, required this.location}) : super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final List<MediaItem> _images = [];

  _pickFile(MediaSourceType sourceType, MediaFileType mediaType) async {
    try {
      ImageSource source = sourceType == MediaSourceType.camera
          ? ImageSource.camera
          : ImageSource.gallery;
      XFile? _file = mediaType == MediaFileType.image_media
          ? await _picker.pickImage(source: source)
          : await _picker.pickVideo(source: source);
      if (_file != null) {
        final thumbnail = mediaType == MediaFileType.video_media
            ? await VideoThumbnail.thumbnailFile(
                video: _file.path,
                thumbnailPath: (await getTemporaryDirectory()).path,
                imageFormat: ImageFormat.PNG,
                quality: 75,
              )
            : _file.path;

        setState(() {
          _images.add(MediaItem(
              file: File(_file.path),
              thumbnail: thumbnail != null ? File(thumbnail) : File(_file.path),
              type: mediaType,downloadUrl: "",),);
        });
      } else {
        //TODO: handle Image pick failed
      }
    } catch (e) {
      //TODO: handle error
      print(e);
    }
  }

  _deleteFile(index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  _selectFileOptions(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SelectModal(
          onPickFile: _pickFile,
        );
      },
    );
  }

  _displayFullScreen(context, index) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return FullScreen(
          file: _images[index],
          deleteFile: () {
            _deleteFile(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Billboard Data"),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final locationProvider = Provider.of<LocationProvider>(context);
                locationProvider.addLocation(_images, widget.location);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            icon: const Icon(Icons.upload),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.asset("assets/telenor.png"),
                  title: Text(widget.location.brand),
                  subtitle: Text(widget.location.address),
                  isThreeLine: true,
                ),
              ),
              MediaList(
                images: _images,
                onPickFile: () {
                  _selectFileOptions(context);
                },
                onShowFull: (index) {
                  _displayFullScreen(context, index);
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Traffic flow',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter traffic flow';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
