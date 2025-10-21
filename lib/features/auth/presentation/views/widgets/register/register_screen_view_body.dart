import 'dart:ui';

import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewBody extends StatelessWidget {
  const RegisterScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(AssetsManeger.backGroundImage),
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: AppColors.black.withOpacity(0.2)),
        ),
        SafeArea(
          child: Column(
            children: [
              Center(
                child: Image(
                  image: const AssetImage(AssetsManeger.logo),
                  height: context.setHight(100),
                 
                ),
              ),
              Column(
                children: [
                  Text(
                    context.loc.heyThere,
                  ),
                  SizedBox(height: context.setHight(8)),
                  Text(
                    'Create An Account', ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
