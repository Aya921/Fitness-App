import 'package:equatable/equatable.dart';



class MusclesRandomEntity extends Equatable {

  final String? id;
  
  
  final String? name;
  
  
  final String? image;

  const MusclesRandomEntity({
    this.id,
    this.name,
    this.image,
  });


  @override
  List<Object?> get props => [id, name, image];
}