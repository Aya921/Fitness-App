import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPassSection extends StatefulWidget {
  final String email;
  const CreateNewPassSection({super.key, required this.email});

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

  final ForgetPassCubit _forgetPassBloc = getIt.get<ForgetPassCubit>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _forgetPassBloc,
      child: BlocListener<ForgetPassCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.forgetPasswordState.isSuccess) {
            isLoading.value = false;
            Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
          } else if (state.forgetPasswordState.isFailure) {
            isLoading.value = false;
            showCustomSnackBar(
              context,
              state.forgetPasswordState.error!.message,
            );
          } else if (state.forgetPasswordState.isLoading) {
            isLoading.value = true;
          }
        },
        child: Column(
          children: [
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
                      _forgetPassBloc.doIntent(
                        ResetPassEvent(
                          resetPassRequest: ResetPassRequest(
                            email: widget.email,
                            newPass: _newPassController.text.trim(),
                          ),
                        ),
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
