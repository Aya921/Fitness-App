import 'package:equatable/equatable.dart';

class BodyInfoEntity extends Equatable {
  final int? weight;
  final int? height;

  const BodyInfoEntity({
    this.weight,
    this.height,
  });

  @override
  List<Object?> get props => [weight,height];
}
