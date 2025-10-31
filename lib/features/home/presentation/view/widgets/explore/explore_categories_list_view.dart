import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ExploreCategoriesListView extends StatelessWidget {
   ExploreCategoriesListView({
    super.key,
  });

final List<String> title =[
  "Gym",
  "Fitness",
  "Yoga",
  "Aerobics",
  "Trainer"
];

final List<String> images =[
  AssetsManager.gymCategory1,
  AssetsManager.gymCategory2,
  AssetsManager.gymCategory3,
  AssetsManager.gymCategory4,
  AssetsManager.gymCategory5
];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(context.loc.categoryHomeText,
          style: getSemiBoldStyle(color: AppColors.white).copyWith(
            fontSize: FontSize.s16,
            fontFamily: 'BalooThambi2'
          ),),
        ),
        SizedBox(height:context.setHight(7)),
       ClipRRect(
         borderRadius: BorderRadius.all(Radius.circular(context.setMinSize(20))),
         child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
           child: Container(
            height: context.setHight(90),
            width: context.setWidth(342),
            decoration: BoxDecoration(
              color: AppColors.gray[AppColors.colorCode90]!.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(context.setMinSize(20))),
                boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
            ),
            child: Center(
              child: ListView.separated(
                 padding: EdgeInsets.symmetric(horizontal: context.setWidth(4),vertical: context.setHight(8) ),
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Container(
                 width: context.setWidth(1),
                 height: context.setHight(70),
                 color: AppColors.shearGray,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: context.setWidth(66),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Image.asset(images[index],
                        )),
                        SizedBox(height: context.setHight(4),),
                         FittedBox(child: Text(title[index],
                        style: getRegularStyle(color: AppColors.white).copyWith(fontFamily:'BalooThambi2')))
                      ],
                    ),
                  );
                },
              ),
            ),
           ),
         ),
       )
      ],
    );
  }
}