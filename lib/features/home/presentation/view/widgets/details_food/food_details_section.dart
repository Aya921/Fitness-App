import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class FoodDetailsSection extends StatelessWidget {
  const FoodDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHight(44),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: context.setWidth(40)),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(context.setWidth(20)),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: context.setHight(4), horizontal: context.setWidth(10)),
              child: Column(
                children: [
                  Text("100 k", style: getRegularStyle(color: AppColors.white)), // will be removed when actual data came 
                  Text(
                    "Energy",
                    style: getRegularStyle(color: AppColors.orange), // will be removed when actual data came 
                  ), 
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
