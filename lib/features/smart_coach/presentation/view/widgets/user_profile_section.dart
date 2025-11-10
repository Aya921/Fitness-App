import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key,required this.firstName});
final String firstName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.setWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPopIcon(onTap: () {}),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: "${context.loc.hiHomeText} $firstName\n",

                  style: getMediumStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(16),
                  ),
                ),
                TextSpan(
                  text: context.loc.iAmYourSmartCoach,
                  style: getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(16),
                  ),
                ),
              ],
            ),
          ),
          ImageIcon(
            const Svg(AssetsManager.menuIcon),
            color: AppColors.orange[AppColors.baseColor],
            size: context.setMinSize(24),
          ),
        ],
      ),
    );
  }
}
