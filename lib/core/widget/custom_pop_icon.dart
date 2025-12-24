import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets_manager.dart';

class CustomPopIcon extends StatelessWidget {
  const CustomPopIcon({super.key,this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return
    InkWell(
      onTap:onTap,
      child: SvgPicture.asset(AssetsManager.popIconSvg, width: context.setMinSize(24),
          ),
      
    );
  }
}
