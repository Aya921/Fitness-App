import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class FoodDetailsSection extends StatelessWidget {
  final List<String> tags;
  const FoodDetailsSection({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.setHight(44),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Container(
            width: context.setWidth(54),
            height: context.setHight(44),
            
            margin: EdgeInsets.only(right: context.setWidth(40)),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(context.setWidth(20)),
            ),
            child: Center(
              child:
               Text(
              overflow: TextOverflow.ellipsis,
                   tags[index],
                    style: getRegularStyle(color: AppColors.orange),
                  ),
            ),
          );
        },
      ),
    );
  }
}
