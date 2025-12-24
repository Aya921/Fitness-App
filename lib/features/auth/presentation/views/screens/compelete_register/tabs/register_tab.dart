import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/font_style.dart';
import '../../../../../../../core/validator/validator.dart';
import '../../../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../../../core/widget/custom_text_form_field.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return         Column(
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
          prefixIcon: SvgPicture.asset(AssetsManager.userSvg),
          validator:(value)=>Validator.validateUsername(context, value),
        ),
        SizedBox(height: context.setHight(16)),
        CustomTextFormField(
            label: context.loc.lastNameRegister,
            hintText: context.loc.lastNameRegister,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: SvgPicture.asset(AssetsManager.userSvg),
            validator:(value)=>Validator.validateUsername(context, value)
        ),
        SizedBox(height: context.setHight(16)),
        CustomTextFormField(
            label: context.loc.emailRegister,
            hintText: context.loc.emailRegister,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: SvgPicture.asset(AssetsManager.mailSvg),
            validator:(value)=>Validator.validateEmail(context, value)
        ),
        SizedBox(height: context.setHight(16)),
        CustomTextFormField(
            label: context.loc.passwordRegister,
            hintText: context.loc.passwordRegister,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            prefixIcon: SvgPicture.asset(AssetsManager.lockSvg),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
            ),
            validator:(value)=>Validator.validatePassword(context, value)
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
                AssetsManager.facecbookSvg,
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
                AssetsManager.gooleSvg,
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
                AssetsManager.appleSvg,
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
    );
  }
}
