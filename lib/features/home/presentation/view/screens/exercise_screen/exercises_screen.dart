import 'package:fitness/features/home/domain/entity/exercises/mover_muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/exercises_list_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/header_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/level_tabs_section.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatefulWidget {
  final MoverMuscleEntity? primMoverMuscle;
  const ExercisesScreen({this.primMoverMuscle, super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.primMoverMuscle != null) {
      context.read<ExercisesCubit>().doIntent(
        intent: LoadLevelsByMuscleIntent(muscleId: widget.primMoverMuscle!.id),
      );
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<ExercisesCubit>().doIntent(
            intent: LoadMoreExercisesByMuscleAndLevelIntent(
              muscleId: widget.primMoverMuscle!.id,
              levelId: context.read<ExercisesCubit>().state.selectedLevelId ?? '',
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.homeBackground),
          fit: BoxFit.cover,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<ExercisesCubit, ExercisesStates>(
          builder: (context, state) {
            if (widget.primMoverMuscle == null) return const SizedBox();

            final levels = state.levelsByMuscleStatus.data ?? [];

            if (_tabController == null && levels.isNotEmpty) {
              _tabController = TabController(
                length: levels.length,
                vsync: this,
              );
            }

            return Column(
              children: [
                HeaderSection(
                  primeMoverMuscleName: widget.primMoverMuscle!.name,
                  primeMoverMuscleImage: widget.primMoverMuscle!.image,
                ),

                LevelTabsSection(
                  muscleId: widget.primMoverMuscle!.id,
                  tabController: _tabController,
                ),

                Expanded(
                  child: ExercisesListSection(
                    primeMoverMuscleImage: widget.primMoverMuscle!.image,
                    scrollController: _scrollController,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
