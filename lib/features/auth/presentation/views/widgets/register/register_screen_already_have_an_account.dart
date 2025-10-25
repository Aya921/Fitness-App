import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreenAlreadyHaveAnAccount extends StatelessWidget {
  const RegisterScreenAlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: context.loc.alreadyHaveAnAccount,
              style: getRegularStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s14),
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
              ..onTap =(){
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              },
              text: context.loc.loginRegister,
              style:
                  getBoldStyle(
                    color: AppColors.lightOrange,
                    fontSize: context.setSp(FontSize.s14),
                  ).copyWith(
                    decoration: TextDecoration.underline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}