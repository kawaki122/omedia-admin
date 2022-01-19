import 'dart:io';

import 'package:flutter/material.dart';
import 'package:o_media_rider/utils/constants.dart';

class Location {
  final String locationId;
  final String address;
  final String logo;
  final String brand;

  Location({
    required this.locationId,
    required this.address,
    required this.logo,
    required this.brand,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        locationId: json['locationId'],
        address: json['address'],
        logo: json['logo'],
        brand: json['brand']);
  }

  Map<String, dynamic> toMap() {
    return {
      'locationId': locationId,
      'address': address,
      'logo': logo,
      'brand': brand
    };
  }
}

class MediaItem {
  MediaFileType type;
  File file;
  File thumbnail;
  String downloadUrl;
  MediaItem({required this.file, required this.thumbnail, required this.type, required this.downloadUrl});

  set fileUrl(String url){
    downloadUrl = url;
  }
}

class MediaItem {
  MediaFileType type;
  File file;
  File thumbnail;
  String downloadUrl;
  MediaItem({required this.file, required this.thumbnail, required this.type, required this.downloadUrl});

  set fileUrl(String url){
    downloadUrl = url;
  }
}