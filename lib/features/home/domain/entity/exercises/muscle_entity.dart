import 'package:equatable/equatable.dart';

class MuscleEntity extends Equatable{
  final String? primeMover;
  final String? secondary;
  final String? tertiary;

  const MuscleEntity({
    this.primeMover,
    this.secondary,
    this.tertiary,
  });

  @override
  List<Object?> get props => [primeMover,secondary,tertiary];
}
