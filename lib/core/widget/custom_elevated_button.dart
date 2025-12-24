import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.backgroundColor,
    this.height,
    this.width,
    this.titleStyle,
    this.borderColor,
    this.isText = true,
    this.child,
  });

  final void Function()? onPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final double? height, width;
  final TextStyle? titleStyle;
  final Color? borderColor;
  final bool isText;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.setMinSize(100)),
        ),
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? context.setHight(38),
        ),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: isText
          ? FittedBox(
              child: Text(
                buttonTitle,
                style:
                    titleStyle ??
                    getExtraBoldStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(FontSize.s14),
                    ),
              ),
            )
          : child,
    );
  }
}
