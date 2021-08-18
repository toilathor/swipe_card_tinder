import 'dart:ui';

import 'package:dating_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DatingCard extends StatelessWidget {
  User user;

  DatingCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //Lớp chứa ảnh
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/profile${user.image}.jpg"),
              fit: BoxFit.cover,
            ),
            color: Colors.green.withOpacity(0.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        Positioned(
          //Thông tin khoảng cách
          height: 34.0,
          top: 20.0,
          left: 16.0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Wrap(
                  children: [
                    SvgPicture.asset('assets/home/local_two.svg'),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    Text(
                      "${this.user.location} km",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Modernist"),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
          //lớp phủ blur
          height: 84.0,
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 24,
                sigmaY: 24,
              ),
              child: Container(
                color: Colors.transparent.withOpacity(0),
              ),
            ),
          ),
        ),
        Positioned(
          //thông tin cá nhân
          height: 84.0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${this.user.name}, ${this.user.age}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Modernist"),
                ),
                Text(
                  "${this.user.job}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Modernist"),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))),
          ),
        ),
      ],
    );
  }
}
