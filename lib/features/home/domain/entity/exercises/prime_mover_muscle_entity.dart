import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entity/exercises/mover_muscle_entity.dart';

class PrimeMoverMuscleEntity extends Equatable{
  final String message;
  final int totalMuscles;
  final List<MoverMuscleEntity> muscles;

  const PrimeMoverMuscleEntity({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  @override
  List<Object?> get props => [message,totalMuscles,muscles];
}
