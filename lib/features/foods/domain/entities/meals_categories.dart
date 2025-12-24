import 'package:equatable/equatable.dart';

class MealCategoryEntity extends Equatable{
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  const MealCategoryEntity({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  @override
  List<Object?> get props =>[
    idCategory,
    strCategory,
    strCategoryThumb,
    strCategoryDescription
  ];
}
