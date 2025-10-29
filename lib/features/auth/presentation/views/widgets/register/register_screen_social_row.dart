import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class RegisterScreenSocialRow extends StatelessWidget {
  const RegisterScreenSocialRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: context.setWidth(32),
          height: context.setHight(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray[AppColors.colorCode90],
          ),
          child: SvgPicture.asset(
            AssetsManager.facecbookSvg,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: context.setWidth(16)),
        Container(
          width: context.setWidth(32),
          height: context.setHight(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray[AppColors.colorCode90],
          ),
          child: SvgPicture.asset(
            AssetsManager.gooleSvg,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: context.setWidth(16)),
        Container(
          width: context.setWidth(32),
          height: context.setHight(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray[AppColors.colorCode90],
          ),
          child: SvgPicture.asset(
            AssetsManager.appleSvg,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}