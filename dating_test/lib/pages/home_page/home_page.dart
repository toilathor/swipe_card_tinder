import 'package:dating_test/pages/home_page/content.dart';
import 'package:dating_test/pages/home_page/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        child: Stack(
          children: [
            Header(),
            Positioned.fill(
              child: Content(),
            ),
          ],
        ),
      ),
    );
  }
}

