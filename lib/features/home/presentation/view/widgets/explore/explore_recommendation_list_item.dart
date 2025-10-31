import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';
import 'package:flutter/material.dart';

class ExploreRecommendationListItem extends StatelessWidget {
  final MusclesRandomEntity randomMusclesData;
  const ExploreRecommendationListItem({
     required this.randomMusclesData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: context.setWidth(16)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: context.setMinSize(104),
            height: context.setMinSize(104),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.setMinSize(20)),
              ),
              image: DecorationImage(
                image: NetworkImage(randomMusclesData.image ?? ""),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.black.withValues(alpha: 0.2),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(context.setMinSize(20)),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                                horizontal: context.setWidth(8),
                                vertical: context.setHight(8)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(context.setMinSize(20)),
                    ),
                    color: AppColors.gray[AppColors.colorCode90]!
                        .withValues(alpha: 0.5),
                  ),
                  child: FittedBox(
                    child: Text(
                      randomMusclesData.name?? "",
                      style: getRegularStyle(
                        color: AppColors.white,
                      ).copyWith(fontFamily: "BalooThambi2"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}