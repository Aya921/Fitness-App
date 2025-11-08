import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
class ChatSection extends StatelessWidget {
  const ChatSection({super.key,required this.onTap});
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.setWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPopIcon(onTap: () {
            Navigator.of(context).pop();
          }),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [

                TextSpan(
                  text: context.loc.smartCoach,
                  style: getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(16),
                  ),
                ),
              ],
            ),
          ),
         InkWell(
           onTap: onTap,
           child:  ImageIcon(
             const Svg(AssetsManager.menuIcon),
             color: AppColors.orange[AppColors.baseColor],
             size: context.setMinSize(24),
           ),
         )
        ],
      ),
    );
  }
}
