import 'package:flutter/material.dart';
import 'package:o_media_rider/providers/location_provider.dart';
import 'package:o_media_rider/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeBar extends StatelessWidget {
  final Function onSearch;
  const HomeBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<LocationProvider>(context);
    return AppBar(
      title: const Text("O Rider"),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {

          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            onSearch(AppBarTypesEnum.SEARCH_BAR);
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () {},
        )
      ],
    );
  }
}
