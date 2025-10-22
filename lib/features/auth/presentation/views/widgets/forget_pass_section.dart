import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPassSection extends StatefulWidget {
  const ForgetPassSection({super.key});

  @override
  State<ForgetPassSection> createState() => _ForgetPassSectionState();
}

class _ForgetPassSectionState extends State<ForgetPassSection> {
  final _emailController = TextEditingController();
  final ValueNotifier<bool> isEmailCorrect = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          hintText: context.loc.email,
          icon: AssetsManeger.mail,
          validator: (val) {
            final res = Validator.validateEmail(context, val);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              isEmailCorrect.value = res == null;
            });
            return res;
          },
        ),

        SizedBox(height: context.setHight(20)),
        CustumFieldsButton(
          valueNotify: isEmailCorrect,
          text: context.loc.sendOTP,
        ),
      ],
    );
  }
}
