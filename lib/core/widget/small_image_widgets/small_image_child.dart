import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class SmallImageChild extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String txt1;
  final String txt2;
  final Widget widget;

  const SmallImageChild({
    super.key,
    required this.crossAxisAlignment,
    required this.txt1,
    required this.txt2,
    required this.widget
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.setHight(20),
      left: context.setWidth(10),
      right: context.setWidth(10),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            txt1,
             overflow: TextOverflow.ellipsis,
            style: getMediumStyle(
              color: AppColors.white,
              fontSize: context.setSp(FontSize.s24),
            ),
          ),
          SizedBox(
            width: context.setWidth(400),
            child: Text(
              txt2,
              maxLines: 2,
               overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
          ),

           SizedBox(height: context.setHight(15)),

          widget,
        ],
      ),
    );
  }
}
