import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/font_style.dart';
import '../../../../../core/widget/custom_pop_icon.dart';

class FoodRecommendationTitle extends StatelessWidget {
  const FoodRecommendationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return       Row(
      children: [
        CustomPopIcon(onTap: () {
          Navigator.of(context).pop();
        }),
        SizedBox(width: context.setWidth(48)),
        Text(
          context.loc.foodRecommendation,
          style: getBoldStyle(color: AppColors.white, fontSize: 
          context.setSp(FontSize.s24)
          ),
        ),
      ],
    );
  }
}
