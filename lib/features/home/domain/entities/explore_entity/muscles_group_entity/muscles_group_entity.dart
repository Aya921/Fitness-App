import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';



class MusclesGroupEntity extends Equatable {

  final String? id;
  

  final String? name;

  const MusclesGroupEntity({
    this.id,
    this.name,
  });


  @override
  List<Object?> get props => [id, name];
}