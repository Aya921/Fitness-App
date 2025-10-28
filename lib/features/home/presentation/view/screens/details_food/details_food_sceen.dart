import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image.dart';
import 'package:fitness/features/home/presentation/view/widgets/details_food/details_food_recommendation.dart';
import 'package:fitness/features/home/presentation/view/widgets/details_food/food_details_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/details_food/ingredients_section.dart';
import 'package:flutter/material.dart';

class DetailsFoodSceen extends StatelessWidget {
  const DetailsFoodSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             CustomPopIcon(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
            const SmallImage(
              videoUrl: "https://www.youtube.com/watch?v=YMx8Bbev6T4", // will be removed when actual data came 
              imageUrl: AssetsManager.test,
              crossAxisAlignment: CrossAxisAlignment.start,
              txt1: 'Pasta With Meat', // will be removed when actual data came 
              txt2:
                  "Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi. ",   // will be removed when actual data came 
              widget: FoodDetailsSection(), 
            ),

            // ingredients section
            const IngredientsSection(),

            // recommendation section
            const DetailsFoodRecommendation(),
          ],
        ),
      ),
    );
  }
}

