import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/views/widgets/otp_section.dart';
import 'package:fitness/features/auth/presentation/views/widgets/text_section.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const  Logo(),
      
              const Spacer(),
              TextSection(
                text1: context.loc.oTPCode,
                text2: context.loc.enterYourOtp,
                reverseStyles: true,
              ),
      
               BlurContainer(blurChild: OtpSection()),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
