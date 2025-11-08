import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTextFields extends StatelessWidget {
  final EditProfileCubit cubit;
  const ProfileTextFields({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(30)),
      child: Column(
        children: [
          CustomTextFormField(
            key:const Key(WidgetKey.firstNameFormField),
            controller: cubit.firstNameController,
            label: context.loc.firtNameRegister,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: SvgPicture.asset(AssetsManager.userSvg),
            validator: (value) => Validator.validateUsername(context, value),
          ),
          SizedBox(height: context.setHight(16)),
          CustomTextFormField(
            key: const Key(WidgetKey.lastNameFormField),
            controller: cubit.lastNameController,
            label: context.loc.lastNameRegister,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: SvgPicture.asset(AssetsManager.userSvg),
            validator: (value) => Validator.validateUsername(context, value),
          ),
          SizedBox(height: context.setHight(16)),
          CustomTextFormField(
            key:const Key(WidgetKey.emailFormField),
            controller: cubit.emailController,
            label: context.loc.emailRegister,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: SvgPicture.asset(AssetsManager.mailSvg),
            validator: (value) => Validator.validateEmail(context, value),
          ),
        ],
      ),
    );
  }
}
