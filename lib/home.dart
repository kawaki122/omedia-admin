import 'package:flutter/material.dart';
import 'Search/CustomBar.dart';
import 'Tasks/MyTasks.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomBar(),
      ),
      body: MyTasks(),
    );
  }
}
