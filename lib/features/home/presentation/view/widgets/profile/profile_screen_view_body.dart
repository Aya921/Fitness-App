
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_profile_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_settings_section.dart';
import 'package:flutter/material.dart';

class ProfileScreenViewBody extends StatelessWidget {
  const ProfileScreenViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      image: AssetsManager.homeBackground,
      alpha: .12,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setMinSize(16)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const ProfileScreenProfileSection(),
               SizedBox(height: context.setHight(40),),
               const ProfileScreenSettingsSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


