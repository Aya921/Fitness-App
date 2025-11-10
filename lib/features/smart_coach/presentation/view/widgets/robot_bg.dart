import 'package:fitness/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class RobotLogo extends StatelessWidget {
  const RobotLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        from: 40,
        animate: true,

        duration: const Duration(milliseconds: 800),
        delay: const Duration(milliseconds: 400),
        child: Image.asset(
          AssetsManager.astron,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.45,

        ),
      ),
    );
  }

}
