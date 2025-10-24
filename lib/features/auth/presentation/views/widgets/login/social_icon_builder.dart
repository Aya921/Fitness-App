import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialIconBuilder extends StatelessWidget {
  final String icon;
   const SocialIconBuilder ({required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.setWidth(32),
      height: context.setHight(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.gray[AppColors.colorCode90],
      ),
      child: SvgPicture.asset(
       icon,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
