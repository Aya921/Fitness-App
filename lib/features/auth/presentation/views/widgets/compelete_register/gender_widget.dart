import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key, this.isSelected=false
    ,required this.iconData, required this.title,this.onTap});

  final IconData iconData;
  final String title;final
  void Function()? onTap;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap:onTap,
        child:Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:isSelected?AppColors.orange[AppColors.baseColor]
                : Colors.transparent,
            border: Border.all(width: context.setWidth(2),
                color: AppColors.white),
          ),
          child: Column(
            children: [
              Icon(iconData, color: AppColors.white, size: context.setMinSize(44)),
              SizedBox(height: context.setHight(8)),
              Text(title, style: getMediumStyle(color: AppColors.white,fontSize:
              context.setSp(16))),
            ],
          ),
        ) ,
      );
  }
}
