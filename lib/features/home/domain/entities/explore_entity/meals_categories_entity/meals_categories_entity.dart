import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


class MealsCategoriesEntity extends Equatable {

  final String? idCategory;
  

  final String? strCategory;
 
  final String? strCategoryThumb;
  
 
  final String? strCategoryDescription;

  const MealsCategoriesEntity({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  @override
  List<Object?> get props => [
    idCategory,
    strCategory,
    strCategoryThumb,
    strCategoryDescription,
  ];
}