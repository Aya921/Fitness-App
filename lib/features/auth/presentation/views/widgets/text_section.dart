import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String _text1;
  final String _text2;
  final bool reverseStyles;
  const TextSection({
    super.key,
    required String text1,
    required String text2,
    this.reverseStyles = false,
  }) : _text2 = text2,
       _text1 = text1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(12),
        vertical: context.setHight(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _text1,
            style: reverseStyles
                ? getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s24),
                  )
                : getRegularStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s18),
                  ),
          ),
          Text(
            _text2,

            style: reverseStyles
                ? getRegularStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s18),
                  )
                : getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s24),
                  ),
          ),
        ],
      ),
    );
  }
}
