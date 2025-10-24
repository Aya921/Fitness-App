import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/core/widget/cusum_scaffold_messanger.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassSection extends StatefulWidget {
  const ForgetPassSection({super.key});

  @override
  State<ForgetPassSection> createState() => _ForgetPassSectionState();
}

class _ForgetPassSectionState extends State<ForgetPassSection> {
  final _emailController = TextEditingController();
  final ValueNotifier<bool> isEmailCorrect = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ForgetPassCubit _forgetPassBloc = getIt.get<ForgetPassCubit>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _forgetPassBloc,

      child: BlocListener<ForgetPassCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.forgetPasswordState.isSuccess) {
            isLoading.value = false;
            Navigator.pushNamed(
              context,
              AppRoutes.otpScreen,
              arguments: _emailController.text.trim(),
            );
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
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return CustomFieldsButton(
                  isLoading: isLoading.value,
                  valueNotify: isEmailCorrect,
                  myChild: Text(context.loc.sendOTP),
                  onPress: () {
                    if (isEmailCorrect.value) {
                      _forgetPassBloc.doIntent(
                        SendForgetPassEmailEvent(
                          forgetPassRequest: ForgetPassRequest(
                            email: _emailController.text.trim(),
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
