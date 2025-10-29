import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_colors.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key, this.width, this.height, this.circleColor});
  final double? width, height;
  final Color? circleColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? context.setWidth(20),
        height: height ??context.setHight(20),
        child: LoadingAnimationWidget.staggeredDotsWave

          (color: circleColor ?? AppColors.white,size: context.setMinSize(30)),
      ),
    );
  }
}