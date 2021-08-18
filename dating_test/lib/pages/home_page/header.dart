import 'package:dating_test/style/my_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';

final double heightHeader = 52.0;

class Header extends StatefulWidget {
  @override
  _Header createState() => _Header();
}

class _Header extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: heightHeader,
      top: 44,
      right: 40,
      left: 40,
      child: Row(
        children: [
          Container(
            width: heightHeader,
            height: heightHeader,
            child: CupertinoButton(
              //TODO
              child: SvgPicture.asset(iconBack),
              onPressed: () => null,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color.fromARGB(255, 232, 230, 234))),
          ),
          Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Chicago, II',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
              ],
            )),
          ),
          Container(
            width: heightHeader,
            height: heightHeader,
            child: CupertinoButton(
              //TODO
              child: SvgPicture.asset(iconSetting),
              onPressed: () => null,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color.fromARGB(255, 232, 230, 234))),
          ),
        ],
      ),
    );
  }
}
