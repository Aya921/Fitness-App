import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_list_item.dart';
import 'package:flutter/material.dart';

class ExplorePopularTrainingListView extends StatelessWidget {
  const ExplorePopularTrainingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            context.loc.popularTrainingText,
            style: getSemiBoldStyle(color: AppColors.white)
                .copyWith(
                  fontSize: FontSize.s16,
                  fontFamily: 'BalooThambi2',
                ),
          ),
        ),
        SizedBox(height: context.setHight(8)),
        SizedBox(
          height: context.setHight(176),
          child:  ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder:(context, index) {
            return  const ExplorePopularListItem();
          }, ),
        )
      ],
    );
  }
}