import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomOtpField extends StatefulWidget {
  final int numberOfFields;
  final Function(String)? onSubmit;
  ValueNotifier<bool> isOtpCompleted;

  CustomOtpField({
    super.key,
    this.numberOfFields = 4,
    this.onSubmit,
    required this.isOtpCompleted,
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

    super.dispose();
  }

  void _checkSubmit() {  // will put in bloc when made it
    final String otp = controllers.map((e) => e.text).join();
    if (otp.length == widget.numberOfFields) {
      widget.isOtpCompleted.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.numberOfFields, (index) {
       
        return Container(
          width: 55,
          margin:  EdgeInsets.symmetric(horizontal: context.setWidth(10)),
          child: 
          TextField(
            focusNode: focusNodes[index],
            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: getMediumStyle(
              color: AppColors.orange,
              fontSize: context.setSp(FontSize.s22),
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

              
              final int startIndex = index;
              for (int i = 0; i < value.length; i++) {
                if (startIndex + i < widget.numberOfFields) {
                  controllers[startIndex + i].text = value[i];
                }
              }

            
             final  int nextFocus = index + value.length;
              if (nextFocus < widget.numberOfFields) {
                FocusScope.of(context).requestFocus(focusNodes[nextFocus]);
              } else {
                FocusScope.of(context).unfocus();
              }

              _checkSubmit();
              setState(() {});
            },
          ),
        );
      }),
    );
  }
}
