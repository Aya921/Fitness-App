import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class RegisterScreenOrRow extends StatelessWidget {
  const RegisterScreenOrRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.gray[AppColors.colorCode10],
            thickness: 1,
            indent: 65,
            endIndent: 20,
          ),
        ),
        Text(
          context.loc.or,
          style: getRegularStyle(
            color: AppColors.gray[AppColors.colorCode10]!,
            fontSize: context.setSp(FontSize.s12),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.gray[AppColors.colorCode10],
            thickness: 1,
            indent: 20,
            endIndent: 65,
          ),
        ),
      ],
    );
  }
}