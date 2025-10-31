import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_card_fitness.dart';
import 'package:flutter/material.dart';

class DetailsFoodRecommendation extends StatelessWidget {
  // will take list of recommdations   recommendtionList
  const DetailsFoodRecommendation({
    super.key,
  });

  // list<Recommdtion> randomRecommendtionList= List.from(recommendtionList)..shuffle

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
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: context.setWidth(10)),
                  width: context.setWidth(163),
                  height: context.setHight(160),
                  child: CustomCardFitness(
                    image: AssetsManager.test,
                    title: 'Pasta With chicks', // will be removed when actual data came 
                    textWidth: context.setWidth(200),
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
