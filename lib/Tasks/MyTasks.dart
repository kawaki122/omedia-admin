import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:o_media_rider/Tasks/TaskDetail.dart';
import 'package:o_media_rider/models/Location.dart';
import 'package:o_media_rider/providers/location_provider.dart';
import 'package:provider/provider.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<LocationProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: entryProvider.locations,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'Something went wrong',
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Location> locations = snapshot.data!.docs
            .map((DocumentSnapshot document) =>
                Location.fromJson(document.data()! as Map<String, dynamic>))
            .where((location) {
          if (entryProvider.query != "") {
            return location.address.contains(entryProvider.query);
          }
          return true;
        }).toList();
        print("render stream");
        return ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Image.asset("assets/telenor.png"),
                title: Text(locations[index].brand),
                subtitle: Text(locations[index].address),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TaskDetail(location: locations[index]),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
