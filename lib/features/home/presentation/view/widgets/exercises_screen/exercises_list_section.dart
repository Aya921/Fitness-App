import 'dart:ui';
import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/exercise_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/skeleton_loading_exercises.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';

class ExercisesListSection extends StatelessWidget {
  final ScrollController scrollController;
  final String primeMoverMuscleImage;

  const ExercisesListSection({
    super.key,
    required this.scrollController,
    required this.primeMoverMuscleImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesCubit, ExercisesStates>(
      builder: (context, state) {
        final exercisesState = state.exercisesByLevelAndMuscleStatus;

        if (exercisesState.isLoading) {
          return const SkeletonLoadingExercises(
            key: Key(WidgetKey.exercisesListLoadingKey),
          );
        }

        if (exercisesState.isFailure) {
          return Center(
            key: const Key(WidgetKey.exercisesListErrorKey),
            child: Text(
              context.loc.errorLoadingExercises,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final exercises = exercisesState.data ?? [];
        if (exercises.isEmpty) {
          return Center(
            key: const Key(WidgetKey.exercisesListEmptyKey),
            child: Text(
              context.loc.noExercises,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return Padding(
          key: const Key(WidgetKey.exercisesListContainerKey),
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(16),
            vertical: context.setHight(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.setWidth(20)),
            child: Container(
              width: context.setWidth(343),
              height: context.setHight(430),
              decoration: BoxDecoration(
                color: AppColors.gray[90]?.withValues(alpha: 0.7),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ListView.separated(
                  key: const Key(WidgetKey.exercisesListViewKey),
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: exercises.length,
                  separatorBuilder: (_, __) => Divider(
                    color: AppColors.gray[50],
                    thickness: context.setHight(0.2),
                  ),
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Padding(
                      key: Key('${WidgetKey.exerciseListItemKey}_$index'),
                      padding: EdgeInsets.all(context.setWidth(8)),
                      child: ExerciseListItem(
                        primeMoverMuscleImage: primeMoverMuscleImage,
                        exerciseName:
                        exercise.name ?? context.loc.exercise,
                        videoLink: exercise.video?.inDepthLink ?? "",
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
