import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/screen/complete_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenButton extends StatelessWidget {
  const RegisterScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomElevatedButton(
          onPressed: state.isTyping
              ? () {
                  final cubit = context.read<RegisterCubit>();
                  cubit.doIntent(intent: const ValidateBasicInfoIntent());
                  if (cubit.state.isBasicInfoValid) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return BlocProvider.value(
                            value: cubit,
                            child: const CompeleteRegisterScreen(),
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: Curves.easeInOut));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  }
                }
              : null,
          buttonTitle: context.loc.register,
        );
      },
    );
  }
}
