import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomLoadingCircleProgressIndictor extends StatelessWidget {
  const CustomLoadingCircleProgressIndictor({super.key,
    required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: context.setMinSize(24),
      backgroundColor: Colors.transparent,
      backgroundWidth: context.setWidth(5),
      percent: index / 6,
      center: Text(
        "$index/6",
        style: getMediumStyle(
          color: AppColors.white,
          fontSize: context.setSp(14),
        ),
      ),
      progressColor: AppColors.orange[AppColors.baseColor],
      lineWidth: context.setWidth(3),
    );
  }
}
