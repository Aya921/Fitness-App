import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_icon_builder.dart';
import 'package:flutter/material.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.setHight(20)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: AppColors.white.withOpacity(0.5),
                thickness: 1,
                indent: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                context.loc.or,
                style: getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s12),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.white.withOpacity(0.5),
                thickness: 1,
                endIndent: 40,
              ),
            ),
          ],
        ),

        SizedBox(height: context.setHight(25)),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIconBuilder(icon: AssetsManeger.facebookIcon),
            SizedBox(width: 10),
            SocialIconBuilder(icon: AssetsManeger.googleIcon),
            SizedBox(width: 10),
            SocialIconBuilder(icon: AssetsManeger.appleIcon),
          ],
        ),

        SizedBox(height: context.setHight(30)),
      ],
    );
  }
}
