import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:o_media_rider/firebase_options.dart';
import 'package:o_media_rider/home.dart';
import 'package:o_media_rider/providers/location_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: MaterialApp(
        title: 'OMedia Rider',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const Home(),
      ),
    );
  }
}
