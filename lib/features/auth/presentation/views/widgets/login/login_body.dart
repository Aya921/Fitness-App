import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/home/presentation/view/screens/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_snack_bar.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:fitness/features/auth/presentation/views/screens/home_screen.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_form_fields.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_header.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/register_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_section.dart';

class LoginBody extends StatelessWidget {
  final LoginCubit cubit;
  const LoginBody({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loginStatus.isFailure) {
          showCustomSnackBar(context, state.loginStatus.error!.message);
        }
        if (state.loginStatus.isSuccess) {
          showCustomSnackBar(context, context.loc.loginSuccess);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeTab()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          key: const Key(WidgetKey.loginBodyScrollKey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Logo(key: Key(WidgetKey.logoKey)),
              SizedBox(height: context.setHight(50)),
              const LoginHeader(key: Key(WidgetKey.loginHeaderKey)),
              BlurContainer(
                blurChild: Column(
                  children: [
                    Text(
                      context.loc.login,
                      key: const Key(WidgetKey.loginTitleTextKey),
                      style: getExtraBoldStyle(
                        color: AppColors.white,
                        fontSize: context.setSp(FontSize.s24),
                      ),
                    ),
                    SizedBox(height: context.setHight(20)),
                    LoginFormFields(cubit: cubit),
                    GestureDetector(
                      key: const Key(WidgetKey.forgetPasswordKey),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgetPassScreen,
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          context.loc.forgetPass,
                          style:
                              getRegularStyle(
                                color: AppColors.orange,
                                fontSize: context.setSp(FontSize.s14),
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.orange,
                              ),
                        ),
                      ),
                    ),
                    const SocialSection(key: Key(WidgetKey.socialSectionKey)),
                    SizedBox(
                      height: context.setHight(40),
                      child: CustomFieldsButton(
                        key: const Key(WidgetKey.loginButtonKey),
                        valueNotify: ValueNotifier(state.isLoginValid),
                        isLoading: state.loginStatus.isLoading,
                        myChild: Text(
                          context.loc.login,
                          style: getExtraBoldStyle(
                            color: AppColors.white,
                            fontSize: context.setSp(FontSize.s16),
                          ),
                        ),
                        onPress: () {
                          cubit.doIntent(
                            intent: LoginWithEmailAndPasswordIntent(),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: context.setHight(8)),
                    const RegisterText(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
