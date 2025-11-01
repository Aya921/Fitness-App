import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class ExerciseListItem extends StatelessWidget {
  final String primeMoverMuscleImage;
  final String exerciseName;
  final String videoLink;

  const ExerciseListItem({
    required this.primeMoverMuscleImage,
    required this.exerciseName,
    required this.videoLink,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.exeVideoScreen,
          arguments: videoLink);


      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(context.setWidth(30)),
            child: Image.network(
              primeMoverMuscleImage,
              height: context.setHight(88),
              width: context.setWidth(81),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: context.setWidth(10)),
          SizedBox(
            width: context.setWidth(180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s18),
                  ),
                ),
                Text(
                 context.loc.exerciseGroup,
                  style: getRegularStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s14),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: context.setWidth(24),
            height: context.setWidth(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.setWidth(25)),
              color: AppColors.orange,
            ),
            child: Icon(
              Icons.play_arrow,
              size: context.setWidth(20),
              color: AppColors.gray[90],
            ),
          ),
          SizedBox(width: context.setWidth(10)),
        ],
      ),
    );
  }
}