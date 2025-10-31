import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/food_grid_view.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/tab_bar_food.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../domain/entities/meals_categories.dart';
import '../../view_model/food_cubit.dart';
import '../../view_model/food_states.dart';
import 'food_recommendation_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class FoodDetialsBody extends StatelessWidget {
  final int index;
  const FoodDetialsBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.setWidth(20),
      ),
      child: Column(
        children: [
          const FoodRecommendationTitle(),
          SizedBox(height: context.setHight(20)),
          BlocBuilder<FoodCubit, FoodStates>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.mealsCategories.isLoading,
                child: TabBarFood(
                  selecteIndex: index,
                  titles: state.mealsCategories.data ?? _dummyCategories,
                ),
              );
            },
          ),
          SizedBox(height: context.setHight(20)),
          const FoodGridView(),
        ],
      ),
    );
  }
}

final _dummyCategories = List.generate(
  8,
      (i) => const MealCategoryEntity(
    strCategory: 'Chest',
    idCategory: '',
    strCategoryThumb: '',
    strCategoryDescription: '',
  ),
);



