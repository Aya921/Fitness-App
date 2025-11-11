import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_event.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/chage_pass/change_pass_request.dart';

class ChangePassSection extends StatefulWidget {
  const ChangePassSection({super.key});

  @override
  State<ChangePassSection> createState() => _ChangePassSectionState();
}

class _ChangePassSectionState extends State<ChangePassSection> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _oldPassController = TextEditingController();
  final ValueNotifier<bool> isPasswordCorrect = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isOldPasswordCorrect = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isConfirmPassCorrect = ValueNotifier<bool>(false);
  final isFormValid = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    _oldPassController.dispose();
    super.dispose();
  }

  void updateFormValid() {
    isFormValid.value =
        isPasswordCorrect.value &&
        isConfirmPassCorrect.value &&
        isOldPasswordCorrect.value;
  }

  final ChangePassCubit _changePassCubit = getIt.get<ChangePassCubit>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _changePassCubit,
      child: BlocListener<ChangePassCubit, ChangePassState>(
        listener: (context, state) {
          if (state.changePassStatus.isSuccess) {
            isLoading.value = false;
           // Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
           showCustomSnackBar(context, context.loc.passwordChangedSuccess);
        
          } else if (state.changePassStatus.isFailure) {
            isLoading.value = false;
            showCustomSnackBar(
              context,
              state.changePassStatus.error!.message,
            );
          } else if (state.changePassStatus.isLoading) {
            isLoading.value = true;
          }
        },
        child: Column(
          children: [
            CustomTextField(
              controller: _oldPassController,
              hintText: context.loc.oldPassword,
              icon: AssetsManager.lockSvg,
              validator: (val) {
                final res = Validator.validatePassword(context, val);
                isOldPasswordCorrect.value = res == null;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  isOldPasswordCorrect.value = res == null;
                  updateFormValid();
                });
                return res;
              },
              isPassword: true,
            ),

            SizedBox(height: context.setHight(15)),
            CustomTextField(
              controller: _newPassController,
              hintText: context.loc.password,
              icon: AssetsManager.lockSvg,
              validator: (val) {
                final res = Validator.validatePassword(context, val);
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
              icon: AssetsManager.lockSvg,
              validator: (val) {
                final res = Validator.validateConfirmPassword(
                  context,
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

            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return CustomFieldsButton(
                  valueNotify: isFormValid,
                  myChild: Text(context.loc.done),
                  isLoading: isLoading.value,
                  onPress: () {
                    if (isFormValid.value) {
                      _changePassCubit.doIntent( SendPassAndNewPassEvent(
                        changePassRequest: ChangePassRequest(
                          password: _oldPassController.text,
                          newPassword: _newPassController.text,
                        ),
                      )
                       
                     
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
