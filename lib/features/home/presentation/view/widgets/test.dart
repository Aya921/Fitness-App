import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.gray[AppColors.colorCode90],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navItem(
            index: 0,
            icon: AssetsManager.homeSvg,
            label: context.loc.explore,
            context: context,
          ),
          navItem(
            index: 1,
            icon: AssetsManager.chatSvg,
            label: context.loc.chatAi,
             context: context,
          ),
          navItem(
            index: 2,
            icon: AssetsManager.gymSvg,
            label: context.loc.gym,
             context: context,
          ),
          navItem(
            index: 3,
            icon: AssetsManager.profileSvg,
            label: context.loc.profile,
             context: context,
          ),
        ],
      ),
    );
  }

  Widget navItem({
    required int index,
    required String icon,
    required String label,
    required BuildContext context,
  }) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: context.setHight(26),
            color: isSelected
                ? AppColors.orange[AppColors.baseColor]!
                : AppColors.white,
          ),
           SizedBox(height: context.setHight(4)),
          Text(
            label,
            style: TextStyle(
              fontSize:context.setSp(12) ,
              color: isSelected
                  ? AppColors.orange[AppColors.baseColor]
                  : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
