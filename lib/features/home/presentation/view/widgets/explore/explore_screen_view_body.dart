import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/loaders/loaders.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/core/widget/tab_bar_widget.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_categories_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_training_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_profile_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_view.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreenViewBody extends StatelessWidget {
  const ExploreScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExploreCubit, ExploreState>(
      listenWhen: (previous, current) { 
       return (current.mealsCategorysState.isSuccess || current.mealsCategorysState.isFailure) ||
         (current.musclesGroupState.isSuccess || current.musclesGroupState.isFailure) ||
         (current.randomMusclesState.isSuccess || current.randomMusclesState.isFailure);
        },
      listener: (context, state) {
       if (state.randomMusclesState.isFailure) {
          Loaders.showErrorMessage(
            message: state.randomMusclesState.error?.message ?? "",
            context: context,
          );
        }else if (state.musclesGroupState.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesGroupState.error?.message ?? "",
            context: context,
          );
        } else if (state.mealsCategorysState.isFailure) {
          Loaders.showErrorMessage(
            message: state.mealsCategorysState.error?.message ?? "",
            context: context,
          );
        }
      },
      
       
     child: HomeBackground(
      alpha: .12,
       child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ExploreScreenProfileSection(),
                      SizedBox(height: context.setHight(24)),
                      ExploreCategoriesListView(),
                      SizedBox(height: context.setHight(24)),
                      const ExploreRecommendationListView(),
                      SizedBox(height: context.setHight(24)),
                      ExploreUpcomingListView(),
                      SizedBox(height: context.setHight(24)),
                      const ExploreFoodListView(),
                      SizedBox(height: context.setHight(24)),
                      const ExplorePopularTrainingListView(),
                    ],
                  ),
                ),
              ),
            ),
     ),
        
      
    );
  }
}
