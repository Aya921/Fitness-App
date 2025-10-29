import 'dart:ui';

import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class ContainerDetialsCompleteRegister extends StatelessWidget {
  const ContainerDetialsCompleteRegister({super.key,
    required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.
      circular(context.setMinSize(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child:
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical:
          context.setWidth(24)),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.3),
            borderRadius:BorderRadius.circular
              (context.setMinSize(24)),
          ),
          child: child,
        ),
      ),
    );
  }
}
