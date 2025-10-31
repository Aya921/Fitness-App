import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class IngredientsSectionDetails extends StatelessWidget {
  final String ingredient;
  final String measure;
  const IngredientsSectionDetails({
    super.key, required this.ingredient, required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.setHight(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 ingredient,
                  style: getBoldStyle(
                    color: AppColors.white,
                    fontSize: FontSize.s16,
                  ),
                ),
    
                Text(
                 measure,  
                  style: getBoldStyle(color: AppColors.orange),
                ),
              ],
            ),
          ),
    
          const Divider(color: Color(0xFF2D2D2D)),
        ],
      ),
    );
  }
}
