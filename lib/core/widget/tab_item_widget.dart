import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.setMinSize(8),
        ),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: isSelected==true
              ? AppColors.orange[AppColors.baseColor]
              : Colors.transparent,
          borderRadius: BorderRadiusDirectional.circular(
            context.setMinSize(20),
          ),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.bounceInOut,
        child: Text(title,
            style: getBoldStyle(color: AppColors.white,
            fontSize: context.setSp(14)
            )),
      ),
    );
  }
}
