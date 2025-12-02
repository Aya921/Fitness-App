import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets_manager.dart';

class CustomPopIcon extends StatelessWidget {
  const CustomPopIcon({super.key,this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final appLanConfig = getIt.get<AppLanguageConfig>();
    return
    InkWell(
      onTap:onTap,
      child: SvgPicture.asset( appLanConfig.isEn() ? AssetsManager.popIconSvg : AssetsManager.popIconArSvg, width: context.setMinSize(24),
          ),
      
    );
  }
}
