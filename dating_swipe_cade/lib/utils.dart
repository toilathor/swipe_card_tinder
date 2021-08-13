import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

// chạm nửa dưới kéo thì chếch dưới còn nửa trên chếch trên
extension MatrixExtension on Matrix4 {
  Matrix4 rotateDegrees(double angleDegrees, {Offset? origin}) {
    var angleRadians = degreesToRadian(angleDegrees);
    if (origin == null || (origin.dx == 0 && origin.dy == 0)) {
      return this..rotateZ(angleRadians);
    }

    return this
      ..translate(origin.dx, origin.dy)
      ..multiply(Matrix4.rotationZ(angleRadians))
      ..translate(-origin.dx, -origin.dy);
  }

  //Chuyển từ độ sang Radians

  Matrix4 scaleWithOrigin(double x, {double? y, Offset? origin}) {
    y ??= x;
    if (x == 1 && y == 1) {
      return this;
    }

    if (origin == null || (origin.dx == 0 && origin.dy == 0)) {
      return this..multiply(Matrix4.identity()..scale(x, y));
    }
    return this
      ..translate(origin.dx, origin.dy)
      ..multiply(Matrix4.identity()..scale(x, y))
      ..translate(-origin.dx, -origin.dy);
  }
}

degreesToRadian(double angleDegrees) => angleDegrees * (math.pi / 180.0);
