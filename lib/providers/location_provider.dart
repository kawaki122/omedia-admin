
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:o_media_rider/Services/firebase_storage.dart';
import 'package:o_media_rider/Services/firestore_service.dart';
import 'package:o_media_rider/models/Location.dart';
import 'package:uuid/uuid.dart';

class LocationProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  final storageService = StorageService();

  String _query = "";
  var uuid = const Uuid();
  //Getters
  String get query => _query;
  Stream<QuerySnapshot> get locations => firestoreService.getLocations();

  //Setters
  set changeQuery(String param){
    _query = param;
    notifyListeners();
  }


  addLocation(List<MediaItem> images, Location location) async {
    List<MediaItem> uploadImages = await storageService.uploadFiles(images);


  }

  editLocation(Location location){
      firestoreService.setLocations(location);
  }
  seedDataBase(){
    firestoreService.addLocation(Location(locationId: uuid.v1(), address: "bla bla blah blah", logo: "blah/bla.png", brand: "Telenor"));
  }
}