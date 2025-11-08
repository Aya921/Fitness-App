
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view_model/logout_view_model/logout_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/logout_view_model/logout_intent.dart';
import 'package:fitness/features/home/presentation/view_model/logout_view_model/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LogoutCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.orange,
        body: BlocConsumer<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state.logoutStatus?.isSuccess == true) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.loginRoute,
                (route) => false,
              );
            } else if (state.logoutStatus?.isFailure == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.logoutStatus?.error?.message ?? "can not logout now",
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<LogoutCubit>();
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  ///start
                  showDialog(
                    context: context,
                    barrierColor: AppColors.gray[80]?.withAlpha(150),
                    barrierDismissible: false,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(context.setWidth(30)),
                          decoration: BoxDecoration(
                            color: AppColors.gray[90]?.withAlpha(220),
                            borderRadius: BorderRadius.circular(
                              context.setWidth(20),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Are You Sure To Close The Application?",
                                textAlign: TextAlign.center,
                                style: getSemiBoldStyle(
                                  color: AppColors.white,
                                  fontSize: context.setSp(FontSize.s20),
                                ),
                              ),
                              SizedBox(height: context.setHight(24)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: AppColors.orange,
                                        width: context.setWidth(2),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          context.setWidth(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.setWidth(30),
                                        vertical: context.setHight(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "NO",
                                      style: getExtraBoldStyle(
                                        color: AppColors.white,
                                        fontSize: context.setSp(FontSize.s16),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.setWidth(30),
                                        vertical: context.setHight(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      cubit.doIntent(
                                        intent: LogoutBtnSubmitted(),
                                      );
                                    },
                                    child: Text(
                                      "Yes",
                                      style: getExtraBoldStyle(
                                        color: AppColors.white,
                                        fontSize: context.setSp(FontSize.s16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      ///end
                    },
                  );
                },
                child: const Text("Logout"),
              ),
            );
          },
        ),
      ),
    );
  }
}
