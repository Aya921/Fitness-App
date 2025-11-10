import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/chat_ai_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/explore_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/gym_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/profile_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_intents.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:fitness/features/home/presentation/view/widgets/app_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/assets_manager.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.index],
          extendBody: true,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppSectionWidget(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
               context.read<BottomNavigationCubit>().doIntent(GoToTab(index: index));
              },
              currentIndex: state.index,
              iconSize: context.setMinSize(30),
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
                  icon: const ImageIcon(Svg(AssetsManager.homeSvg)),
                ),
                BottomNavigationBarItem(
                  label: context.loc.chatAi,

                  icon: const ImageIcon(Svg(AssetsManager.chatSvg)),
                ),
                BottomNavigationBarItem(
                  label: context.loc.gym,

                  icon: const ImageIcon(Svg(AssetsManager.gymSvg)),
                ),
                BottomNavigationBarItem(
                  label: context.loc.profile,

                  icon: const ImageIcon(Svg(AssetsManager.profileSvg)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
