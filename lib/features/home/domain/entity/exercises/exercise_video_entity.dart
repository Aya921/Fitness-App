import 'package:equatable/equatable.dart';

class ExerciseVideoEntity extends Equatable{
  final String? shortDemo;
  final String? inDepthExplanation;
  final String? shortDemoLink;
  final String? inDepthLink;

 const ExerciseVideoEntity({
    this.shortDemo,
    this.inDepthExplanation,
    this.shortDemoLink,
    this.inDepthLink,
  });

  @override
  List<Object?> get props => [shortDemo,inDepthExplanation,shortDemoLink,inDepthLink];
}
