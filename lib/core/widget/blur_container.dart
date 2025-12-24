import 'dart:ui';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
 final  Widget blurChild;
  const BlurContainer({super.key,required this.blurChild});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.setWidth(50)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: context.setHight(25), horizontal: context.setWidth(18)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: blurChild,
        ),
      ),
    );
  }
}
