import 'dart:ui';

import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreenViewBody extends StatelessWidget {
  const RegisterScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(AssetsManeger.backGroundImage),
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
                    image: const AssetImage(AssetsManeger.logo),
                    height: context.setHight(70),
                    width: context.setWidth(48),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.setMinSize(16)),
                      child: Column(
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
                      ),
                    ),
                    BlurContainer(
                      blurChild: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              context.loc.register,
                              style: getExtraBoldStyle(
                                color: AppColors.white,
                                fontSize: context.setSp(FontSize.s24),
                              ),
                            ),
                          ),
                          SizedBox(height: context.setHight(16)),
                          CustomTextFormField(
                            label: context.loc.firtNameRegister,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            hintText: context.loc.firtNameRegister,
                            prefixIcon: SvgPicture.asset(AssetsManeger.userIcon),
                            validator:(value) =>Validator.validateUsername(context, value),
                          ),
                          SizedBox(height: context.setHight(16)),
                          CustomTextFormField(
                            label: context.loc.lastNameRegister,
                            hintText: context.loc.lastNameRegister,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            prefixIcon: SvgPicture.asset(AssetsManeger.userIcon),
                            validator:(value) =>Validator.validateUsername(context, value)
                          ),
                          SizedBox(height: context.setHight(16)),
                          CustomTextFormField(
                            label: context.loc.emailRegister,
                            hintText: context.loc.emailRegister,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: SvgPicture.asset(AssetsManeger.emailIcon),
                            validator:(value) =>Validator.validateEmail(context, value)
                          ),
                          SizedBox(height: context.setHight(16)),
                          CustomTextFormField(
                            label: context.loc.passwordRegister,
                            hintText: context.loc.passwordRegister,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            prefixIcon: SvgPicture.asset(AssetsManeger.lockIcon),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility_outlined),
                            ),
                            validator:(value) =>Validator.validatePassword(context, value)
                          ),
                          SizedBox(height: context.setHight(24)),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.gray[AppColors.colorCode10],
                                  thickness: 1,
                                  indent: 65,
                                  endIndent: 20,
                                ),
                              ),
                              Text(
                                context.loc.or,
                                style: getRegularStyle(
                                  color: AppColors.gray[AppColors.colorCode10]!,
                                  fontSize: context.setSp(FontSize.s12),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.gray[AppColors.colorCode10],
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 65,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.setHight(24)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: context.setWidth(32),
                                height: context.setHight(32),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.gray[AppColors.colorCode90],
                                ),
                                child: SvgPicture.asset(
                                  AssetsManeger.facebookIcon,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              SizedBox(width: context.setWidth(16)),
                              Container(
                                width: context.setWidth(32),
                                height: context.setHight(32),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.gray[AppColors.colorCode90],
                                ),
                                child: SvgPicture.asset(
                                  AssetsManeger.googleIcon,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              SizedBox(width: context.setWidth(16)),
                              Container(
                                width: context.setWidth(32),
                                height: context.setHight(32),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.gray[AppColors.colorCode90],
                                ),
                                child: SvgPicture.asset(
                                  AssetsManeger.appleIcon,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.setHight(24)),
                          CustomElevatedButton(
                            onPressed: () {},
                            buttonTitle: context.loc.register,
                          ),
                          SizedBox(height: context.setHight(8)),
                          FittedBox(
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
                          ),
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
