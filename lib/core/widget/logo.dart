import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';

import '../constants/assets_manager.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AssetsManager.logo, height: context.setHight(70)),
    );
  }
}
