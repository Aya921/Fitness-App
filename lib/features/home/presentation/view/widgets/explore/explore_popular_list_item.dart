import 'dart:ui';

import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class ExplorePopularListItem extends StatelessWidget {
  const ExplorePopularListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.setWidth(16)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: context.setWidth(200),
            height: context.setHight(176),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.setMinSize(20)),
              ),
              image: DecorationImage(
                image: const AssetImage(AssetsManager.popularTrainingImg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.black.withValues(alpha: 0.2),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Exercises That\nStrengthen Your Chest",
                style: getSemiBoldStyle(color: AppColors.white).copyWith(
                  fontFamily: "BalooThambi2",
                  fontSize: context.setSp(FontSize.s14),
                ),
              ),
              SizedBox(height: context.setHight(8)),
              SizedBox(
                width: context.setWidth(200),
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    vertical: context.setHight(8),
                    horizontal: context.setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(context.setMinSize(20)),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              alignment: Alignment.center,
                               padding: EdgeInsets.symmetric(
                                horizontal: context.setWidth(8),
                                vertical: context.setHight(8)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(context.setMinSize(20)),
                                ),
                                color: AppColors.gray[AppColors.colorCode90]!
                                    .withValues(alpha: 0.5),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                "24 Tasks",
                                style: getRegularStyle(
                                  color: AppColors.white,
                                ).copyWith(fontFamily: "BalooThambi2",
                                fontSize: context.setSp(FontSize.s12)),
                              ),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(width: context.setWidth(28)),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(context.setMinSize(20)),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.setWidth(8),
                                vertical: context.setHight(8)
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(context.setMinSize(20)),
                                ),
                                color: AppColors.gray[AppColors.colorCode90]!
                                    .withValues(alpha: 0.5),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Beginner",
                                style: getBoldStyle(
                                  color: AppColors.orange,
                                ).copyWith(fontFamily: "BalooThambi2",
                                fontSize: context.setSp(FontSize.s12)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
