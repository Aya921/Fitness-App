import 'dart:ui';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class CustomCardFitness extends StatelessWidget {
  const CustomCardFitness({
    super.key,
    required this.image,
    required this.title,
    this.textWidth
  });

  final String image;
  final String title;
  final double? textWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.setMinSize(20)),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, color: Colors.white),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.5),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(color: Colors.transparent),
          ),

          Positioned(
            bottom: 15,

            child: SizedBox(
              width: textWidth?? context.setWidth(120),
              child: Text(
                title,
                maxLines: 2,

                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
