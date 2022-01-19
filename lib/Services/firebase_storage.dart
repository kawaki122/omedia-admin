import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:o_media_rider/models/Location.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;


  Future<List<MediaItem>> uploadFiles(List<MediaItem> images) async {
    List<MediaItem> _newImages = [];

    await Future.forEach(images, (MediaItem image) async {
      UploadTask uploadTask = _storage.ref().child('locations/${image.file.path}').putFile(image.file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      image.fileUrl = await taskSnapshot.ref.getDownloadURL();
      _newImages.add(image);
    });

    return _newImages;
  }
}
