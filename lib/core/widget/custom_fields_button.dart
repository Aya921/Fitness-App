import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustumFieldsButton extends StatelessWidget {
  const CustumFieldsButton({
    super.key,
    required this.valueNotify,
    this.onPress, required this.text,
  });

  final ValueNotifier<bool> valueNotify;
  final void Function()? onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotify,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: const ButtonStyle().copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    valueNotify.value ? AppColors.orange : AppColors.gray[70],
                  ),
                ),
                onPressed: onPress,
                child: Text(text),
              ),
            ),
          ],
        );
      },
    );
  }
}