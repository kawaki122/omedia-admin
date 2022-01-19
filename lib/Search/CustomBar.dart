
import 'package:flutter/material.dart';
import 'package:o_media_rider/Search/HomeBar.dart';
import 'package:o_media_rider/Search/SearchBar.dart';
import 'package:o_media_rider/utils/constants.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  AppBarTypesEnum _selectedAppBar = AppBarTypesEnum.HOME_BAR;

  void _setAppBarType(AppBarTypesEnum barType) {
    setState(() {
      _selectedAppBar = barType;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_selectedAppBar == AppBarTypesEnum.HOME_BAR) {
      return HomeBar(onSearch: _setAppBarType);
    } else {
      return SearchBar(onBack: _setAppBarType);
    }
  }
}
