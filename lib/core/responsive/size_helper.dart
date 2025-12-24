import 'dart:math';

import 'package:fitness/core/responsive/size_provider.dart';
import 'package:flutter/material.dart';

extension SizeHelperExtension on BuildContext {
  bool get isLandScape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenWidth => isLandScape
      ? MediaQuery.of(this).size.height
      : MediaQuery.of(this).size.width;
  double get screenHight => isLandScape
      ? MediaQuery.of(this).size.width
      : MediaQuery.of(this).size.height;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidth => sizeProvider.width / sizeProvider.baseSize.width;
  double get scaleHeight => sizeProvider.height / sizeProvider.baseSize.height;

  double setWidth(num w) {
    return scaleWidth * w;
  }
  double setHight(num h) {
    return scaleHeight * h;
  }
  double setSp(num fontSize) {
    return scaleWidth * fontSize;
  }
  double setMinSize(num size) {
    return size *min(scaleHeight,scaleWidth);
  }
}