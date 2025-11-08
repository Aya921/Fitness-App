import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../theme/app_colors.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key,required this.child,
    required this.image,
    required this.alpha});
  final String image;
  final Widget child;final double alpha;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
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