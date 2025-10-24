import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomOtpField extends StatefulWidget {
  final int numberOfFields;
  ValueNotifier<bool> isOtpCompleted;
  ValueNotifier<String> codeValue;

  CustomOtpField({
    super.key,
    this.numberOfFields = 4,
    required this.isOtpCompleted,
    required this.codeValue,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.numberOfFields,
      (_) => TextEditingController(),
    );
    focusNodes = List.generate(widget.numberOfFields, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _checkSubmit() {
    final String otp = controllers.map((e) => e.text).join();
    widget.isOtpCompleted.value = otp.length == widget.numberOfFields;
    if (widget.isOtpCompleted.value) {
      widget.codeValue.value = otp;
    } else {
      widget.codeValue.value = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.numberOfFields, (index) {
        return Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: context.setWidth(8)),
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: getMediumStyle(
                color: AppColors.orange,
                fontSize: context.setSp(FontSize.s18),
              ),
              decoration: InputDecoration(
                counterText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: controllers[index].text.isNotEmpty
                        ? AppColors.orange
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orange, width: 2),
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  widget.isOtpCompleted.value = false;
                  setState(() {});
                  if (index > 0) FocusScope.of(context).previousFocus();
                  return;
                }

                final chars = value.split('');
                for (int i = 0; i < chars.length; i++) {
                  if (index + i < widget.numberOfFields) {
                    controllers[index + i].text = chars[i];
                  }
                }

                final nextFocus = index + chars.length;
                if (nextFocus < widget.numberOfFields) {
                  FocusScope.of(context).requestFocus(focusNodes[nextFocus]);
                } else {
                  FocusScope.of(context).unfocus();
                }

                _checkSubmit();
                setState(() {});
              },
            ),
          ),
        );
      }),
    );
  }
}
