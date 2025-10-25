import 'dart:ui';

import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_already_have_an_account.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_button.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_form.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_or_row.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_social_row.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_welcome_message.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/assets_manager.dart';
import '../../../../../../core/widget/blur_container.dart';

class RegisterScreenViewBody extends StatelessWidget {
  const RegisterScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(AssetsManager.backGroundImage),
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: AppColors.black.withOpacity(0.2)),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(AssetsManager.logo),
                    height: context.setHight(70),
                    width: context.setWidth(48),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.setMinSize(16)),
                      child: const RegisterScreenWelcomeMessage(),
                    ),
                    BlurContainer(
                      blurChild: Column(
                        children: [
                          const RegisterScreenForm(),
                          SizedBox(height: context.setHight(24)),
                          const RegisterScreenOrRow(),
                          SizedBox(height: context.setHight(24)),
                          const RegisterScreenSocialRow(),
                          SizedBox(height: context.setHight(24)),
                          const RegisterScreenButton(),
                          SizedBox(height: context.setHight(8)),
                          const RegisterScreenAlreadyHaveAnAccount(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}












