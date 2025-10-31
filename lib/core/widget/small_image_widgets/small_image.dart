import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image_background.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image_child.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image_logo.dart';
import 'package:flutter/material.dart';

class SmallImage extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String videoUrl;
  final String txt1;
  final String txt2;
  final Widget widget;
  final String imageUrl;
  final void Function()? onPressed;

  const SmallImage({
    super.key,
    required this.crossAxisAlignment,
    required this.txt1,
    required this.txt2,
    required this.widget,
    required this.imageUrl,
    this.onPressed,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SmallBackGroundImage(smallImage: imageUrl),
        Positioned(
          top: context.setHight(30),
          left: context.setWidth(20),
          child: CustomPopIcon(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        SmallImageLogo(videoUrl: videoUrl),
        SmallImageChild(
          txt1: txt1,
          txt2: txt2,
          widget: widget,
          crossAxisAlignment: crossAxisAlignment,
        ),
      ],
    );
  }
}
