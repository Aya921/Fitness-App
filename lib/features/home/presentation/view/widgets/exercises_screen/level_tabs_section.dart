import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/tab_bar_widget.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';

class LevelTabsSection extends StatelessWidget {
  final String muscleId;
  final TabController? tabController;

  const LevelTabsSection({
    super.key,
    required this.muscleId,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesCubit, ExercisesStates>(
      builder: (context, state) {
        final levels = state.levelsByMuscleStatus.data ?? [];
        return Container(
          width: double.infinity,
          height: context.setHight(55),
          decoration: BoxDecoration(
            color: AppColors.gray[90],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(context.setWidth(20)),
              bottomLeft: Radius.circular(context.setWidth(20)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.setHight(9)),
            child: TabBarWidget(
              titles: levels.map((level) => level.name ?? '').toList(),
              onTabChanged: (selectedIndex) {
                final selectedLevelId = levels[selectedIndex].id;
                if (selectedLevelId == null) return;
                context.read<ExercisesCubit>().doIntent(
                  intent: ChangeSelectedLevelIntent(
                    levelId: selectedLevelId,
                    muscleId: muscleId,
                  ),
                );
                tabController?.animateTo(selectedIndex);
              },
            ),
          ),
        );
      },
    );
  }
}
