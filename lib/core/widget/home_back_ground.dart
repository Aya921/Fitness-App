import 'dart:ui';

import 'package:fitness/core/constants/assets_manager.dart';
import 'package:flutter/widgets.dart';

import '../theme/app_colors.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key,required this.child,
    required this.alpha});
  final Widget child;final double alpha;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AssetsManager.homeBackground,
          fit: BoxFit.fill,
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: AppColors.black.withValues(alpha: alpha),
          ),
        ),

        child,
      ],
    );
  }
}