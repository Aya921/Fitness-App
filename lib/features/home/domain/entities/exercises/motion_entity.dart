import 'package:equatable/equatable.dart';

class MotionEntity extends Equatable{
  final String? movementPattern;
  final String? planeOfMotion;
  final String? mechanics;
  final String? forceType;
  final String? posture;

  const MotionEntity({
    this.movementPattern,
    this.planeOfMotion,
    this.mechanics,
    this.forceType,
    this.posture,
  });

  @override
  List<Object?> get props => [movementPattern,planeOfMotion,movementPattern,forceType,posture];
}
