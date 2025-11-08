import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
class SmartCoachProfile extends StatelessWidget {
  const SmartCoachProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return    CircleAvatar(
      radius: context.setMinSize(30),
      backgroundImage:
      const AssetImage(AssetsManager.smartCoachProfile),
      backgroundColor: Colors.transparent,
    );
  }
}
