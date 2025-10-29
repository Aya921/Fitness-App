import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/responsive/size_helper.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key(WidgetKey.registerTextKey),
      onTap: () {
        // navigate to register screen
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: context.loc.doNotHaveAccount,
              style: getRegularStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s14),
              ),
            ),
            TextSpan(
              recognizer:TapGestureRecognizer()
              ..onTap =(){
                Navigator.pushReplacementNamed(context, AppRoutes.registerScreen);
              },
              text: context.loc.register,
              style: getExtraBoldStyle(
                color: AppColors.orange,
                fontSize: context.setSp(FontSize.s14),
              ).copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
