import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:flutter/material.dart';

class CreateNewPassSection extends StatefulWidget {
  const CreateNewPassSection({super.key});

  @override
  State<CreateNewPassSection> createState() => _CreateNewPassSectionState();
}

class _CreateNewPassSectionState extends State<CreateNewPassSection> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final ValueNotifier<bool> isPasswordCorrect = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isConfirmPassCorrect = ValueNotifier<bool>(false);
  final isFormValid = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void updateFormValid() {
    isFormValid.value = isPasswordCorrect.value && isConfirmPassCorrect.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
        controller: _newPassController,
        hintText: context.loc.password,
        icon: AssetsManeger.lock,
        validator: (val) {
          final res = Validator.validatePassword(context,val);
          isPasswordCorrect.value = res == null;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isPasswordCorrect.value = res == null;
            updateFormValid();
          });
          return res;
        },
        isPassword: true,
      ),
    
        SizedBox(height: context.setHight(15)),
    
      CustomTextField(
        controller: _confirmPassController,
        hintText: context.loc.confirmPass,
        icon: AssetsManeger.lock,
        validator: (val) {
          final res = Validator.validateConfirmPassword(context,
            val,
            _newPassController.text,
          );
        
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isConfirmPassCorrect.value = res == null;
            updateFormValid();
          });
          return res;
        },
        isPassword: true,
      ),
        SizedBox(height: context.setHight(35)),
    
        CustumFieldsButton(valueNotify: isFormValid, text: context.loc.done,)
      ],
    );
  }

  
}

