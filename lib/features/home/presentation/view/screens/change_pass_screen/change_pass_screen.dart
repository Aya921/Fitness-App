import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass/text_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/change_pass/change_pass_section.dart';
import 'package:flutter/material.dart';
class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: context.setWidth(16)),
                    CustomPopIcon(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    SizedBox(width: context.setWidth(100)),
                    const Logo(),
                  ],
                ),

                SizedBox(height: context.setHight(40)),

                TextSection(
                  text1: context.loc.makeSure8Char,
                  text2: context.loc.createNewPass,
                ),

                SizedBox(height: context.setHight(20)),

                const BlurContainer(
                  blurChild: ChangePassSection(),
                ),

                SizedBox(height: context.setHight(40)),

                SizedBox(height: context.setHight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
