import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class RegisterScreenWelcomeMessage extends StatelessWidget {
  const RegisterScreenWelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            context.loc.heyThere,
            style: getRegularStyle(
              color: AppColors.white,
              fontSize: context.setSp(FontSize.s18),
            ),
          ),
        ),
        SizedBox(height: context.setHight(8)),
        FittedBox(
          child: Text(
            context.loc.createAnAccount,
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