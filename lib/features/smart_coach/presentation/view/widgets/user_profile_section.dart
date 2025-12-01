import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key,required this.firstName});
final String firstName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: context.setHight(10),
        horizontal: context.setWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${context.loc.hiHomeText} $firstName\n",
                    style: getMediumStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(16),
                    ),
                  ),
                  TextSpan(
                    text: context.loc.iAmYourSmartCoach,
                    style: getBoldStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(16),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
