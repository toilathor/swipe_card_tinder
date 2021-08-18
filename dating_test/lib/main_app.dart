import 'dart:ui';

import 'package:dating_test/pages/home_page/home_page.dart';
import 'package:dating_test/pages/like_page.dart';
import 'package:dating_test/pages/message_page.dart';
import 'package:dating_test/pages/people_page.dart';
import 'package:dating_test/style/my_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';

enum NavIndex { Home, Like, Message, People }

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static int _selectedIndex = 0;
  static List _page = [
    HomePage(),
    LikePage(),
    MessagePage(),
    PeoplePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: Container(
        height: 57.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(iconHomeActive, iconHomeInactive, NavIndex.Home),
            buildNavBarItem(iconLikeActive, iconLikeInactive, NavIndex.Like),
            buildNavBarItem(
                iconMessageActive, iconMessageInactive, NavIndex.Message),
            buildNavBarItem(
                iconPeopleActive, iconPeopleInactive, NavIndex.People),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(
      String iconActive, String iconInactive, NavIndex index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      width: MediaQuery.of(context).size.width / 4 * 0.7,
      child: IconButton(
          highlightColor: Colors.white,
          tooltip: '${index.index}',
          onPressed: () {
            setState(() {
              _selectedIndex = index.index;
            });
          },
          icon: index.index == _selectedIndex
              ? SvgPicture.asset(iconActive)
              : SvgPicture.asset(iconInactive)),
      decoration: index.index == _selectedIndex
          ? BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromARGB(255, 232, 64, 87), width: 2.0),
              ),
            )
          : null,
    );
  }
}
