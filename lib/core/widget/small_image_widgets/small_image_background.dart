import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SmallBackGroundImage extends StatelessWidget {
  final String smallImage;
  const SmallBackGroundImage({super.key,required this.smallImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.setHight(375),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.setMinSize(40)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.setMinSize(40)),
        child: Stack(
          children: [
            Image.network(
             smallImage,
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.4),
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.black,
                    Color.fromARGB(232, 0, 0, 0),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.1, 0.6],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
