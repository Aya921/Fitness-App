import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/tab_bar_widget.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_intents.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_item.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreUpcomingListView extends StatelessWidget {
  const ExploreUpcomingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final cubit = context.read<ExploreCubit>();
        final items = state.musclesGroupState.data;
        final isLoading = state.musclesGroupById.isLoading;
        final muscles = state.musclesGroupById.data?.muscles ?? [];
       final bottomNavCubit = context.read<BottomNavigationCubit>();

        if ((state.musclesGroupState.data?.isNotEmpty ?? false) &&
            cubit.cachedMuscleGroups.isNotEmpty &&
            (bottomNavCubit.state.muscleGroupsData?.isEmpty ?? true)) {
          bottomNavCubit.doIntent(
            SyncDataIntent(
              muscleGroupsData: state.musclesGroupState.data,
              muscleByGroupId: cubit.cachedMuscleGroups,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    context.loc.upcomingWorkOutsText,
                    style: getSemiBoldStyle(color: AppColors.white).copyWith(
                      fontSize: FontSize.s16,
                      fontFamily: 'BalooThambi2',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (state.musclesGroupState.data == null ||
                        cubit.cachedMuscleGroups.isEmpty) {
                      return;
                    }
                    bottomNavCubit.doIntent(GoToTab(index: 2));
                  },
                  child: FittedBox(
                    child: Text(
                      context.loc.seeAllHomeText,
                      style: getRegularStyle(color: AppColors.orange).copyWith(
                        fontSize: FontSize.s14,
                        fontFamily: 'BalooThambi2',
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: context.setHight(8)),

            if (items != null && items.isNotEmpty)
              Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: AppColors.gray[AppColors.colorCode70]!,
                  highlightColor: AppColors.gray[AppColors.colorCode40]!,
                ),
                enabled: isLoading,
                child: SizedBox(
                  height: context.setHight(30),
                  child: TabBarWidget(
                    titles: items.map((muscle) => muscle.name ?? '').toList(),
                    onTabSelected: (value) {
                      final selectedId = items[value].id;
                      cubit.doIntent(
                        intent: GetMusclesGroupByIdIntent(id: selectedId),
                      );
                    },
                  ),
                ),
              ),

            SizedBox(height: context.setHight(8)),

            SizedBox(
              height: context.setHight(80),
              child: Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: AppColors.gray[AppColors.colorCode70]!,
                  highlightColor: AppColors.gray[AppColors.colorCode40]!,
                ),
                enabled: isLoading,
                child: Builder(
                  builder: (context) {
                    if (isLoading) {
                      return ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            const ExploreUpcomingListItem(
                              musclesentity: MuscleEntity(image: "", name: ""),
                            ),
                      );
                    }
                    return ListView.builder(
                      itemCount: muscles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ExploreUpcomingListItem(
                        musclesentity: muscles[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
