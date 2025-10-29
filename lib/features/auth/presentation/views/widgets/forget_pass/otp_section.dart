import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_state.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass/custum_otp.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass/verification_question_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpSection extends StatelessWidget {
  final String email;
  OtpSection({super.key, required this.email});

  final ValueNotifier<bool> isOtpCompleted = ValueNotifier<bool>(false);
  final ForgetPassCubit _forgetPassBloc = getIt.get<ForgetPassCubit>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String> codeValue = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _forgetPassBloc,
      child: BlocListener<ForgetPassCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.forgetPasswordState.isSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(context, AppRoutes.resetPass, arguments: email);
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
            // otp
            CustomOtpField(
              numberOfFields: 6,
              isOtpCompleted: isOtpCompleted,
              codeValue: codeValue,
            ),

            SizedBox(height: context.setHight(30)),
            //button
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return CustomFieldsButton(
                  valueNotify: isOtpCompleted,
                  myChild: Text(context.loc.confirm),
                  isLoading: isLoading.value,
                  onPress: () {
                    if (isOtpCompleted.value) {
                      _forgetPassBloc.doIntent(
                        SendCodeEvent(
                          sendCodeRequest: SendCodeRequest(
                            otpCode: codeValue.value,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),

            //endSection
            VerifcationQuestionSection(
              email: email,
              forgetPassBloc: _forgetPassBloc,
            ),
          ],
        ),
      ),
    );
  }
}
