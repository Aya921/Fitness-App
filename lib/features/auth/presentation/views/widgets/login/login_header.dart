import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            context.loc.heyThere,
            style: getRegularStyle(
              color: AppColors.white,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            context.loc.welcomeBack,
            style: getExtraBoldStyle(
              color: AppColors.white,
              fontSize: context.setSp(FontSize.s20),
            ),
          ),
        ),
      ],
    );
  }
}
