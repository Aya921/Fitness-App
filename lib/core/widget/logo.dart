import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AssetsManeger.logo, height: context.setHight(70)),
    );
  }
}
