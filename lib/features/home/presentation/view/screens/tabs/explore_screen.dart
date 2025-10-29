
import 'package:fitness/features/home/presentation/view/screens/tabs/gym_screen.dart';
import 'package:fitness/features/home/presentation/view_model/workout_view_model/workout_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/workout_view_model/workout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutCubit>();

    // ✅ حمّلي المستويات + التمارين أول مرة فقط
    cubit.loadLevels();
    cubit.loadExercises();

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Level')),
      body: BlocBuilder<WorkoutCubit, WorkoutStates>(
        builder: (context, state) {
          final levels = state.levelsStatus.data ?? [];
          final counts = state.exercisesCountByLevel;

          if (state.levelsStatus.isLoading || state.exercisesStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (levels.isEmpty) {
            return const Center(child: Text('No levels found'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              final levelName = level.name ?? 'Unknown';
              final exerciseCount = counts?[levelName] ?? 0; // ✅ هنا العدد

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<WorkoutCubit>(),
                        child: ExercisesScreen(initialLevel: level.name ?? ''),
                      ),
                    ),
                  );

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        levelName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$exerciseCount Exercises', // ✅ عرض العدد
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
