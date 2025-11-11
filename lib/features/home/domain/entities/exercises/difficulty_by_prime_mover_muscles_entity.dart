import 'package:equatable/equatable.dart';

import 'difficulty_level_entity.dart';

class DifficultyByPrimeMoverMusclesEntity extends Equatable{
  final String? message;
  final int? totalLevels;
  final List<LevelEntity>? difficultyLevels;

  const DifficultyByPrimeMoverMusclesEntity({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  @override
  List<Object?> get props => [message,totalLevels,difficultyLevels];
}