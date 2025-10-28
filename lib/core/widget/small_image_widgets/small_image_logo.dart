import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SmallImageLogo extends StatefulWidget {
  final String videoUrl;
  const SmallImageLogo({super.key, required this.videoUrl});

  @override
  State<SmallImageLogo> createState() => _SmallImageLogoState();
}

class _SmallImageLogoState extends State<SmallImageLogo> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.setHight(115),
      left: 0,
      right: 0,
      child: Center(
        child: IconButton(
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.videoPage,arguments: widget.videoUrl
          
          ),
          icon: Icon(
            Icons.play_circle_fill_outlined,
            size: context.setWidth(65),
            color: AppColors.orange,
          ),
        ),
      ),
    );
  }
}
