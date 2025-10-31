import 'dart:ui';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class CustomCardFitness extends StatelessWidget {
  const CustomCardFitness({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.setMinSize(20)),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {

              return  Center(
                child: Icon(Icons.image_not_supported,
                color: AppColors.gray,
                  size: context.setMinSize(50),
                ),
              );
            },
           
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

          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: context.setMinSize(10),
              start: context.setMinSize(30),
              end: context.setMinSize(30),
            ),
            child: Text(
              title,
              maxLines: 2,

              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: getBoldStyle(
                color: AppColors.white,
                fontSize: context.setSp(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
