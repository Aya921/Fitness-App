import 'package:equatable/equatable.dart';

class LevelEntity extends Equatable{
  final String? id;
  final String? name;

  const LevelEntity({this.id, this.name});

  @override
  List<Object?> get props => [id,name];
}
