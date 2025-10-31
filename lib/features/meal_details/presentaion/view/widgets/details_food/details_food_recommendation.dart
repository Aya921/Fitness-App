import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_card_fitness.dart';
import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:flutter/material.dart';

class DetailsFoodRecommendation extends StatelessWidget {
  const DetailsFoodRecommendation({
    super.key,required this.meals
  });
final List<MealsByCategory>meals;

  @override
  Widget build(BuildContext context) {
    final foodMeadls=List.from(meals)..shuffle();

    return Padding(
      padding: EdgeInsets.all(context.setWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(context.setWidth(10)),
            child: Text(
              context.loc.recommendation,
              style: getSemiBoldStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
          ),
    
          SizedBox(
            height: context.setHight(160),
            width: context.setWidth(343),
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: foodMeadls.length,
              itemBuilder: (context, index) {

                return Container(
                  margin: EdgeInsets.only(right: context.setWidth(10)),
                  width: context.setWidth(163),
                  height: context.setHight(160),
                  child:  CustomCardFitness(
                    image: foodMeadls[index].strMealThumb??"",
                    title: foodMeadls[index].strMeal??"Pasta With chicks",

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
