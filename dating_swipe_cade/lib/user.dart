import 'package:flutter/material.dart';
import 'dart:math' as math;
List<String> _names = [
  "Ánh Mai",
  "Anh Thư",
  "Bích Thoa",
  "Giáng Tiên",
  "Hải Sinh",
  "Hải Uyên",
  "Hoài Phương",
  "Hồng Thư",
  "Huyền Thoại",
  "Minh Nhi",
  "Mộng Vân",
  "Mỹ Hiệp",
  "Ngọc Tâm",
  "Thảo Hồng",
  "Thúy Vân",
  "Xuân Hương",
];

class User {
  static int _nameIndex = 0;
  String? name;
  int? age;
  ImageProvider image;


  User({this.name, this.age, required this.image}){
    //random tên
    name = name?? _names[(_nameIndex++) % _names.length];
    age = age?? 21 + math.Random().nextInt(10);
  }
}