import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;

  const AppBackground({
    super.key,
    required this.child,
    this.blur = 8,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AssetsManeger.backGroundImage, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(color: AppColors.black.withValues(alpha: opacity)),
        ),
        child,
      ],
    );
  }
}
