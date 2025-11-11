import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:flutter/material.dart';

class ExploreRecommendationListItem extends StatelessWidget {
  final MuscleEntity randomMusclesData;
  const ExploreRecommendationListItem({
     required this.randomMusclesData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.exercises,
      arguments:randomMusclesData ),
      child: Padding(
        padding:  EdgeInsets.only(right: context.setWidth(16)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: context.setMinSize(104),
              height: context.setMinSize(104),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(context.setMinSize(20))),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(AppColors.black.withValues(alpha: 0.2)
                  , BlendMode.darken),
                  child: CachedNetworkImage(imageUrl:randomMusclesData.image ?? ""
                  ,fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container(
          color: AppColors.gray.withValues(alpha: 0.2),
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: context.setHight(25)),
          child: Icon(
            Icons.image_not_supported,
            color: AppColors.gray,
            size: context.setMinSize(50),
          ),
        );
                  }),
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
      ),
    );
  }
}