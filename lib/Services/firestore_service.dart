
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:o_media_rider/models/Location.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Entries
  Stream<QuerySnapshot> getLocations(){
    return _db
        .collection('locations')
        .snapshots();
  }

  //Upsert
  Future<void> setLocations(Location location){
    var options = SetOptions(merge:true);

    return _db
        .collection('locations')
        .doc(location.locationId)
        .set(location.toMap(),options);
  }
  addLocation(Location location) {
    FirebaseFirestore.instance.collection('locations').doc(location.locationId).set(
        {
          trafficFlow:
        });
  }
}