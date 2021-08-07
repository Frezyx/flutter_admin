import 'package:flutter/material.dart';

class AlignmentHelper {
  Alignment getAlignment(Alignment align) {
    final isLeft = align.x < 0.5;
    final isTop = align.y < 0.5;

    if (isLeft && isTop) {
      return Alignment.topLeft;
    } else if (isLeft && !isTop) {
      return Alignment.bottomLeft;
    } else if (!isLeft && isTop) {
      return Alignment.topRight;
    } else {
      return Alignment.bottomRight;
    }
  }
}
