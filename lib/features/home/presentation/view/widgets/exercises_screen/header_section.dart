import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String primeMoverMuscleName;
  final String primeMoverMuscleImage;
  const HeaderSection({
    required this.primeMoverMuscleName,
    required this.primeMoverMuscleImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
    Positioned.fill(
    child: Image.network(
      primeMoverMuscleImage,
      fit: BoxFit.cover,
    ),),
        Container(
          height: context.setHight(230),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.gray[90]!, Colors.transparent],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: context.setWidth(25),height: context.setHight(80),),
                CustomPopIcon(onTap: () => Navigator.pop(context)),
              ],
            ),
            SizedBox(height: context.setHight(148)),
            SizedBox(
              width: context.setWidth(344),
              child: Column(
                children: [
                  Text(
                    primeMoverMuscleName,
                    style: getMediumStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(FontSize.s24),
                    ),
                  ),
                  SizedBox(height: context.setHight(8)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(16),
                    ),
                    child: Text(
                      context.loc.exerciseSlug,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: AppColors.white,
                        fontSize: context.setSp(FontSize.s16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.setHight(8),
                      horizontal: context.setWidth(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.setWidth(10)),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: context.setWidth(1),
                              color: AppColors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(context.setWidth(20)),
                            ),
                          ),
                          child: Text(
                            context.loc.min,
                            style: getRegularStyle(
                              color: AppColors.white,
                              fontSize: context.setSp(FontSize.s12),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(context.setWidth(10)),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: context.setWidth(1),
                              color: AppColors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(context.setWidth(20)),
                            ),
                          ),
                          child: Text(
                            context.loc.cal,
                            style: getBoldStyle(
                              color: AppColors.orange,
                              fontSize: context.setSp(FontSize.s12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
