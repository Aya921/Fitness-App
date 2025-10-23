import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class SelectWidgetItem extends StatelessWidget {
 const SelectWidgetItem({super.key, required this.title,
    this.isSelected = false,required this.onTap});

  final String title;
 final  bool isSelected;
final Function()onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.lightGray.withValues(
          alpha: 0.3
        ),
        border: Border.all(
          width: context.setWidth(2),
          color: AppColors.shadeWhite,
        ),
      ),
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: context.setWidth(16),
          vertical: context.setHight(8)
      ),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHight(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
          title,
          style: getBoldStyle(
            color: AppColors.white,
            fontSize: context.setSp(18),
          ),
        ),
      GestureDetector(
        onTap:onTap,
        child:     Container(
            width: context.setWidth(20),
            height: context.setHight(20),
            padding: const EdgeInsetsDirectional.all(4),
            decoration: BoxDecoration(

                shape: BoxShape.circle,
                border: Border.all(

                    width: context.setWidth(2),
                    color: AppColors.shadeWhite
                )
            ),
            child: isSelected?CircleAvatar(
              radius: 8,
              backgroundColor: AppColors.orange[AppColors.baseColor],
            ):const SizedBox.shrink()
        ),
      )

        ],
      ),
    );
  }
}
