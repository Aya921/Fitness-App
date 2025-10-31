import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widget/custom_card_fitness.dart';
import '../../../domain/entities/meals_by_category.dart';
import '../../view_model/food_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../view_model/food_states.dart';

class FoodGridView extends StatelessWidget {
  const FoodGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodStates>(
      builder: (context, state) {
        return Expanded(
          child: GridView.builder(
            itemCount:
                state.mealsByCategorieStatus.data?.length ?? _dummyMeals.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: context.setHight(10),
              crossAxisSpacing: context.setHight(10),
            ),
            itemBuilder: (context, index) {
              final meals = state.mealsByCategorieStatus.data ?? _dummyMeals;

              return Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: AppColors.gray[AppColors.colorCode70]!,
                  highlightColor: AppColors.gray[AppColors.colorCode40]!,
                ),

                enabled:
                    state.mealsByCategorieStatus.isLoading ||
                    state.mealsByCategorieStatus.isInitial ||
                    state.mealsByCategorieStatus.isFailure,
                child:
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(AppRoutes.detailsFoodPage,
                  arguments:{
                    'meal': meals,
                    'index': index,
                  } );
                },
                child:   CustomCardFitness(
                  image: meals[index].strMealThumb ?? "",
                  title: meals[index].strMeal ?? "",
                ),
              )
              );
            },
          ),
        );
      },
    );
  }
}

final _dummyMeals = List.generate(
  8,
  (i) => const MealsByCategory(
    strMeal: "Tunisian Lamb Soup",
    strMealThumb:
        "https://www.themealdb.com/images/media/meals/t8mn9g1560460231.jpg",
    idMeal: "52972",
  ),
);
