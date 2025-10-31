import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:flutter/material.dart';

class ExploreScreenProfileSection extends StatelessWidget {
   const ExploreScreenProfileSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  "${context.loc.hiHomeText} ${UserManager().currentUser?.personalInfo!.firstName},",
                  style: getMediumStyle(color: AppColors.white).copyWith(
                    fontSize: FontSize.s16,
                    fontFamily: 'BalooThambi2',
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  context.loc.letsStartDoingYourDay,
                  style: getBoldStyle(color: AppColors.white).copyWith(
                    fontSize: FontSize.s18,
                    fontFamily: 'BalooThambi2',
                  ),
                ),
              ),
            ],
          ),
        ),

        CircleAvatar(
          onBackgroundImageError: (exception, stackTrace) =>
              const Icon(Icons.info),
          radius: context.setMinSize(18),
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(UserManager().currentUser!.personalInfo!.photo ?? ""),
        ),
      ],
    );
  }
}
