import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class VideoErrorDialog extends StatelessWidget {
  final String message;
  const VideoErrorDialog({required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AlertDialog(
        backgroundColor: AppColors.gray[80],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
             Icon(Icons.error_outline, color: AppColors.orange,size: context.setWidth(25),),
            SizedBox(width: context.setWidth(8)),
            Text(
              context.loc.error,
              style: getBoldStyle(
                color: AppColors.orange,
                fontSize: context.setSp(FontSize.s20),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: getRegularStyle(
            color: Colors.white,
            fontSize: context.setSp(FontSize.s18),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              context.loc.back,
              style: getBoldStyle(
                color: AppColors.orange,
                fontSize: context.setSp(FontSize.s18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
