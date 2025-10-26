import 'package:fitness/core/theme/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/responsive/size_helper.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.validator,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      obscuringCharacter: '•',
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: context.setWidth(20),
            right: context.setWidth(10),
          ),
          child: Image.asset(
            widget.icon,
            width: context.setWidth(20),
            height: context.setHight(20),
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
      ),
      style: getRegularStyle(
        color: AppColors.white,
        fontSize: context.setSp(FontSize.s16),
      ),
      validator: widget.validator,
    );
  }
}
