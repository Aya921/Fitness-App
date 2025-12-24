import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.validator,
    this.textInputAction,
    this.hintStyle,
    this.contentPadding,
    this.style,
    this.onTap,
    this.enabled,
    this.suffixIconConstraints,
    this.maxLength,
    this.prefixIcon,
    this.prefixIconConstraints,
    required this.label,
    this.labelStyle,
    this.borderRadius = 100,
    this.disabledBorderColor,
    this.isReadOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });
  final String? hintText;
  final String label;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final void Function()? onTap;
  final bool? enabled;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLength;
  final double borderRadius;
  final Color? disabledBorderColor;
  final bool? isReadOnly;
  final FloatingLabelBehavior floatingLabelBehavior;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      style:
          style ??
          getRegularStyle(
            color: AppColors.white,
            fontSize: context.setSp(FontSize.s16),
          ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      readOnly: isReadOnly ?? false,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: context.setMinSize(16),
              vertical: context.setMinSize(4),
            ),
        filled: false,
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style:
                labelStyle ??
                getRegularStyle(
                  color: AppColors.gray[AppColors.colorCode10]!,
                  fontSize: context.setSp(FontSize.s12),
                ),
          ),
        ),
        hintStyle:
            hintStyle ??
            getRegularStyle(
              color: AppColors.gray[AppColors.colorCode10]!,
              fontSize: context.setSp(FontSize.s12),
            ),
        hintText: hintText,

        focusedBorder: buildOutlinedBorder(
          context: context,
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius,
        ),
        enabledBorder: buildOutlinedBorder(
          context: context,
          borderColor: AppColors.lightWhite,
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: buildOutlinedBorder(
          context: context,
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius,
        ),
        errorBorder: buildOutlinedBorder(
          context: context,
          borderColor: AppColors.red,
          borderRadius: borderRadius,
        ),
        disabledBorder: buildOutlinedBorder(
          context: context,
          borderColor:
              disabledBorderColor ?? Theme.of(context).colorScheme.onSecondary,
          borderRadius: borderRadius,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: prefixIcon,
        ),
        prefixIconConstraints:
            prefixIconConstraints ??
            BoxConstraints(
              maxWidth: context.setWidth(60),
              maxHeight: context.setHight(60),
            ),
        suffixIconConstraints:
            suffixIconConstraints ??
            BoxConstraints(
              maxWidth: context.setWidth(60),
              maxHeight: context.setHight(60),
            ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: suffixIcon,
        ),
        errorStyle: getRegularStyle(color: AppColors.red),
        errorMaxLines: 3,
      ),
      maxLength: maxLength,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      validator: validator,
      enabled: enabled,
    );
  }

  static OutlineInputBorder buildOutlinedBorder({
    required BuildContext context,
    required Color borderColor,
    required double borderRadius,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.setMinSize(borderRadius)),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
