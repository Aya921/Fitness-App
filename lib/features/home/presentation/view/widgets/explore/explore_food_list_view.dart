import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_item.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

//ff
class ExploreFoodListView extends StatelessWidget {
  const ExploreFoodListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                context.loc.recommendationForYouText,
                style: getSemiBoldStyle(
                  color: AppColors.white,
                ).copyWith(fontSize: FontSize.s16, fontFamily: 'BalooThambi2'),
              ),
            ),
            FittedBox(
              child: Text(
                context.loc.seeAllHomeText,
                style: getRegularStyle(color: AppColors.orange).copyWith(
                  fontSize: FontSize.s14,
                  fontFamily: 'BalooThambi2',
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.setHight(8)),
        BlocBuilder<FoodCubit,FoodStates>(
          builder: (context, state) {
            return SizedBox(
              height: context.setHight(104),
              child: ListView.builder(
                itemCount: state.mealsCategories.data?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Skeletonizer(
                     enabled:
                    state.mealsCategories.isLoading ||
                    state.mealsCategories.isInitial ||
                    state.mealsCategories.isFailure,
                    effect: ShimmerEffect(
                  baseColor: AppColors.gray[AppColors.colorCode70]!,
                  highlightColor: AppColors.gray[AppColors.colorCode40]!,
                ),

                    child: ExploreFoodListItem(
                      mealCategoryEntity:
                          state.mealsCategories.data![index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
