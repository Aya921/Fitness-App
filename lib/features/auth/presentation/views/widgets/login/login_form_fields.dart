import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_intent.dart';
import 'package:flutter/material.dart';

class LoginFormFields extends StatelessWidget {
  final LoginCubit cubit;
  const LoginFormFields({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          icon: AssetsManeger.mail,
          onChanged: (val) {
            cubit.doIntent(intent: UpdateEmailIntent());
          },
          validator: (val) => Validator.validateEmail(context, val),
          controller: cubit.emailController,
          hintText: context.loc.email,
        ),
        SizedBox(height: context.setHight(16)),
        CustomTextField(
          icon: AssetsManeger.lock,
          onChanged: (val) {
            cubit.doIntent(intent: UpdatePasswordIntent());
          },
          validator: (val) => Validator.validatePassword(context, val),
          controller: cubit.passwordController,
          hintText: context.loc.password,
          isPassword: true,
        ),
        SizedBox(height: context.setHight(10)),
      ],
    );
  }
}
