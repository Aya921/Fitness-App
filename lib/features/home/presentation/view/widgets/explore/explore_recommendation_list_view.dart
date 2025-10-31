import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_item.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreRecommendationListView extends StatelessWidget {
  const ExploreRecommendationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            context.loc.recommendationTodyText,
            style: getSemiBoldStyle(
              color: AppColors.white,
            ).copyWith(fontSize: FontSize.s16, fontFamily: 'BalooThambi2'),
          ),
        ),
        SizedBox(height: context.setHight(8)),
        BlocBuilder<ExploreCubit, ExploreState>(
          builder: (context, state) {
            return SizedBox(
              height: context.setHight(104),
              child: ListView.builder(
                itemCount: state.randomMusclesState.data?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Skeletonizer(
                    effect: ShimmerEffect(
                  baseColor: AppColors.gray[AppColors.colorCode70]!,
                  highlightColor: AppColors.gray[AppColors.colorCode40]!,
                ),
                     enabled:
                    state.randomMusclesState.isLoading ||
                    state.randomMusclesState.isInitial ||
                    state.randomMusclesState.isFailure,
                    child: ExploreRecommendationListItem(randomMusclesData:state.randomMusclesState.data![index]));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
