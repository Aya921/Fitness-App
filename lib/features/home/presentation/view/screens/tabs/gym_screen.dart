import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_intents.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/assets_manager.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/theme/font_style.dart';
import '../../../../../../core/widget/tab_bar_widget.dart';
import '../../widgets/gym/gridview_widget.dart';
class GymScreen extends StatelessWidget {
  const GymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        final muscleGroups = state.muscleGroupsData ?? [];
        final musclesByGroup = state.muscleByGroupId ?? {};
        final selectedGroupId = state.selectedGroupId;
         final isLoading = muscleGroups.isEmpty || musclesByGroup.isEmpty;
          final selectedId = selectedGroupId ?? muscleGroups.first.id;
        final selectedMuscles =
            musclesByGroup[selectedId]?.muscles ?? [];

        if (muscleGroups.isEmpty) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.backGroundImageGym),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'No workouts available',
                  style: getRegularStyle(color: AppColors.white),
                ),
              ),
            ),
          );
        }
       

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.backGroundImageGym),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.setHight(20)),
                  Text(
                    Constants.workouts,
                    style: getBoldStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(30),
                    ),
                  ),
                  SizedBox(height: context.setHight(10)),
            
                  if (!isLoading && muscleGroups.isNotEmpty)
                  Container(
                    height: context.setHight(40),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.setWidth(16),
                    ),
                    child: isLoading
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColors.gray[AppColors.colorCode70],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ): TabBarWidget(
                      titles: muscleGroups.map((g) => g.name ?? '').toList(),
                      initialSelectedIndex: muscleGroups.indexWhere(
                        (g) => g.id == selectedId,
                      ),
                      onTabSelected: (index) {
                        final newId = muscleGroups[index].id;
                        if (newId != null) {
                          context.read<BottomNavigationCubit>().doIntent(
                                SelectGroupIntent(newId),
                              );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: context.setHight(10)),
            
                  Expanded(
                    child: selectedMuscles.isNotEmpty
                        ? GridviewWidget(
                            images: selectedMuscles
                                .map((m) => m.image ?? '')
                                .toList(),
                            titles: selectedMuscles
                                .map((m) => m.name ?? '')
                                .toList(),
                          )
                        : Center(
                            child: Text(
                              context.loc.notAvailable,
                              style: getRegularStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
