// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SizeProvider extends InheritedWidget {
  final Size baseSize;
  final double width;
  final double height;
  const SizeProvider({
    super.key,
    required this.baseSize,
    required this.width,
    required this.height,
    required super.child,
  });

  static SizeProvider of(BuildContext context) {
    // هايقعد يدور ع اقرب sizeprovider
    return context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant SizeProvider oldWidget) {
    // if any thing cheange  like width , height   --> then this fn will decide to change its child or not
    return baseSize != oldWidget.baseSize ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        child != oldWidget.child;
  }
}