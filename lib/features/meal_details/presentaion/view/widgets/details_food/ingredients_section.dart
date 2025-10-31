import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section_details.dart';
import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  final List<String> ingredients;
  final List<String> measures;
  const IngredientsSection({super.key, required this.ingredients, required this.measures});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.setWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(context.setWidth(10)),
            child: Text(
              context.loc.ingredients,
              style: getSemiBoldStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.setWidth(25)),
              color: const Color.fromARGB(184, 0, 0, 0),
            ),
            height: context.setHight(150),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: context.setHight(10)),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return  IngredientsSectionDetails(ingredient: ingredients[index],measure: measures[index],);
              },
            ),
          ),
        ],
      ),
    );
  }
}
