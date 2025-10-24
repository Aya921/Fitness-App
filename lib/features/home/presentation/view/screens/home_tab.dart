import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/chat_ai_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/explore_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/gym_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/profile_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/app_section_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Widget> screens = [
    const ExploreScreen(),
    const ChatAiScreen(),
    const GymScreen(),
    const ProfileScreen(),
  ];
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currIndex],
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AppSectionWidget(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            currIndex = index;
            setState(() {});
          },
          currentIndex: currIndex,

          selectedItemColor: AppColors.orange[AppColors.baseColor],
          unselectedItemColor: AppColors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          backgroundColor: AppColors.gray[AppColors.colorCode90],
          selectedLabelStyle: getRegularStyle(
            fontSize: context.setSp(13),
            color: AppColors.orange[AppColors.baseColor]!,
          ),
          items: [
            BottomNavigationBarItem(
              label: context.loc.explore,
              backgroundColor: AppColors.gray[AppColors.colorCode90],
              icon: const ImageIcon(AssetImage(AssetsManeger.homeIcon)),
            ),
            BottomNavigationBarItem(
              label: context.loc.chatAi,

              icon: const ImageIcon(AssetImage(AssetsManeger.chatAiIcon)),
            ),
            BottomNavigationBarItem(
              label: context.loc.gym,

              icon: const ImageIcon(AssetImage(AssetsManeger.gymIcon)),
            ),
            BottomNavigationBarItem(
              label: context.loc.profile,

              icon: const ImageIcon(AssetImage(AssetsManeger.profileIcon)),
            ),
          ],
        ),
      ),
    );
  }
}
