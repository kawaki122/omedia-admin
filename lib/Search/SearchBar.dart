import 'package:flutter/material.dart';
import 'package:o_media_rider/providers/location_provider.dart';
import 'package:o_media_rider/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final Function onBack;
  const SearchBar({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<LocationProvider>(context);
    print("state changed");
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          onBack(AppBarTypesEnum.HOME_BAR);
        },
      ),
      title: TextField(
        onSubmitted: (text) {entryProvider.changeQuery=text;},
        style: const TextStyle(color: Colors.white),
        autofocus: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintStyle: TextStyle(color: Colors.white),
          hintText: "Search locations",
          fillColor: Colors.white24,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        )
      ],
    );
  }
}
