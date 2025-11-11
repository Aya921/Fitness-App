import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';

class LogoutDialog extends StatelessWidget {
  final ProfileCubit cubit;

  const LogoutDialog({super.key, required this.cubit});


  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(context.setWidth(30)),
        decoration: BoxDecoration(
          color: AppColors.gray[90]?.withAlpha(220),
          borderRadius: BorderRadius.circular(context.setWidth(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.loc.sureToLogout,
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
            SizedBox(height: context.setHight(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    context.loc.no,
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
                    cubit.doIntent(LogoutBtnSubmitted());
                  },
                  child: Text(
                    context.loc.yes,
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
  }
}
