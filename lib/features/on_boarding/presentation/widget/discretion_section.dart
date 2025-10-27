import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/responsive/device_utils.dart';
import '../../../../core/theme/app_colors.dart';

class DiscretionSection extends StatelessWidget {
  const DiscretionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(20),
        vertical: context.setHight(8),
      ),
      child: Text(
        Constants.descriptionOnBoarding,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: context.setSp(
            DeviceUtils.valueDecider(
              context,
              onMobile: 14.0,
              onTablet: 16.0,
              onDesktop: 18.0,
            ),
          ),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
