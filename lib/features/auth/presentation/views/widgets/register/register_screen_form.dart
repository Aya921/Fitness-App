import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreenForm extends StatelessWidget {
  const RegisterScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: registerCubit.registerFormKey,
          autovalidateMode: state.autoValidateMode,
          child: Column(
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
                controller: registerCubit.firstNameController,
                label: context.loc.firtNameRegister,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: context.loc.firtNameRegister,
                prefixIcon: SvgPicture.asset(AssetsManeger.userIcon),
                validator: Validator.validateUsername,
                onChanged: (_) {
                  registerCubit.doIntent(intent: const IsTypingIntent());
                },
              ),
              SizedBox(height: context.setHight(16)),
              CustomTextFormField(
                controller: registerCubit.lastNameController,
                label: context.loc.lastNameRegister,
                hintText: context.loc.lastNameRegister,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                prefixIcon: SvgPicture.asset(AssetsManeger.userIcon),
                validator: Validator.validateUsername,
                 onChanged: (_) {
                  registerCubit.doIntent(intent: const IsTypingIntent());
                }
              ),
              SizedBox(height: context.setHight(16)),
              CustomTextFormField(
                controller: registerCubit.emailController,
                label: context.loc.emailRegister,
                hintText: context.loc.emailRegister,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: SvgPicture.asset(AssetsManeger.emailIcon),
                validator: Validator.validateEmail,
                 onChanged: (_) {
                  registerCubit.doIntent(intent: const IsTypingIntent());
                }
              ),
              SizedBox(height: context.setHight(16)),
              CustomTextFormField(
                controller: registerCubit.passwordController,
                label: context.loc.passwordRegister,
                hintText: context.loc.passwordRegister,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: state.isObscure,
                prefixIcon: SvgPicture.asset(AssetsManeger.lockIcon),
                suffixIcon: IconButton(
                  onPressed: () {
                    registerCubit.doIntent(intent: const ToggleObscurePasswordIntent());
                  },
                  icon: Icon(state.isObscure? 
                    Icons.visibility_off_outlined :Icons.visibility_outlined),
                ),
                validator: Validator.validatePassword,
                 onChanged: (_) {
                  registerCubit.doIntent(intent: const IsTypingIntent());
                }
              ),
            ],
          ),
        );
      },
    );
  }
}
