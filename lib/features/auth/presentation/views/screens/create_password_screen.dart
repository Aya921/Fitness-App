import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/views/widgets/create_new_pass_section.dart';
import 'package:fitness/features/auth/presentation/views/widgets/text_section.dart';
import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatelessWidget {
  final String email;

  const CreatePasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              const Spacer(),
              TextSection(
                text1: context.loc.makeSure8Char,
                text2: context.loc.createNewPass,
              ),
               BlurContainer(blurChild: CreateNewPassSection(email:email)),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
