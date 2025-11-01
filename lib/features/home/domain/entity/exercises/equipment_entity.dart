import 'package:equatable/equatable.dart';

class EquipmentEntity extends Equatable {
  final String? primaryEquipment;
  final int? primaryItems;
  final String? secondaryEquipment;
  final int? secondaryItems;

  const EquipmentEntity({
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
  });

  @override
  List<Object?> get props => [
    primaryEquipment,
    primaryEquipment,
    secondaryEquipment,
    secondaryItems,
  ];
}
