import 'package:equatable/equatable.dart';

class PersonalInfoEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final String? photo;

  const PersonalInfoEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.photo,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    age,
    photo,
  ];
}
