import 'dart:async';

import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:flutter/material.dart';

class VerifcationQuestionSection extends StatefulWidget {
  final String email;
  final ForgetPassCubit forgetPassBloc;

  const VerifcationQuestionSection({
    super.key,
    required this.email,
    required this.forgetPassBloc,
  });

  @override
  State<VerifcationQuestionSection> createState() =>
      _VerifcationQuestionSectionState();
}

class _VerifcationQuestionSectionState
    extends State<VerifcationQuestionSection> {
  int _seconds = 30;
  Timer? _timer;
  bool _canResend = false;

  void _startTimer() {
    setState(() {});
    _canResend = false;

    _seconds = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  String get timerText {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.setHight(15)),
      child: Column(
        children: [
          Text(
            context.loc.didnotReciveCode,
            style: getRegularStyle(
              color: AppColors.white,
              fontSize: context.setSp(FontSize.s16),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_canResend) {
                    _startTimer();
                    widget.forgetPassBloc.doIntent(
                      SendForgetPassEmailEvent(
                        forgetPassRequest: ForgetPassRequest(
                          email: widget.email,
                        ),
                      ),
                    );
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    context.loc.resendCode,
                    style:
                        getBoldStyle(
                          color: _canResend
                              ? AppColors.orange
                              : AppColors.gray[70]!,
                          fontSize: context.setSp(FontSize.s16),
                        ).copyWith(
                          decoration: _canResend
                              ? TextDecoration.underline
                              : null,
                          decorationColor: AppColors.orange,
                          decorationThickness: 2,
                        ),
                  ),
                ),
              ),
              SizedBox(width: context.setWidth(10)),
              if (_seconds != 0)
                Text(timerText, style: getRegularStyle(color: AppColors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
