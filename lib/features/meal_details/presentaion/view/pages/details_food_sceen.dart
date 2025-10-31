import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/custom_snack_bar.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image.dart';
import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/details_food_recommendation.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/food_details_section.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_cubit.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_event.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsFoodScreen extends StatefulWidget {
  final List<MealsByCategory> meals;final int index;
  const DetailsFoodScreen({super.key, required this.meals,required this.index});

  @override
  State<DetailsFoodScreen> createState() => _DetailsFoodScreenState();
}

class _DetailsFoodScreenState extends State<DetailsFoodScreen> {
  late DetailsFoodCubit _detailsFoodCubit;
  @override
  void initState() {
    super.initState();
    _detailsFoodCubit = getIt.get<DetailsFoodCubit>();
    _detailsFoodCubit.doIntent(GetMealDetailsEvent(mealId:
    widget.meals[widget.index].idMeal.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _detailsFoodCubit,

      child: Scaffold(
        body: AppBackground(
          child: BlocConsumer<DetailsFoodCubit, DetailsFoodState>(
            listener: (context, state) {
              if (state.detailsFoodState.isFailure) {
                showCustomSnackBar(
                  context,
                  state.detailsFoodState.error!.message,
                );
              }
            },

            builder: (context, state) {
              if (state.detailsFoodState.isSuccess) {
                final data =
                    state.detailsFoodState.data as MealResponseEntity;
                final mealInfo = data.meal[0];
          
                return SingleChildScrollView(
                  child: Column(
                    children: [
                     
                      SmallImage(
                        videoUrl: mealInfo.media.strYoutube,
                        imageUrl: mealInfo.media.strMealThumb,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        txt1: mealInfo.strMeal,
                        txt2: mealInfo.strInstructions,
                        widget: FoodDetailsSection(
                          tags: mealInfo.info.strTags,
                        ),
                      ),
                            
                      IngredientsSection(
                        ingredients: mealInfo.ingredients,
                        measures: mealInfo.measures,
                      ),
                            
                       DetailsFoodRecommendation(
                         meals: widget.meals,
                       ),
                    ],
                  ),
                );
              }
              if (state.detailsFoodState.isLoading) {
                return const Center(child: LoadingCircle());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
