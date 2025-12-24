import 'package:equatable/equatable.dart';



class MealsByCategory extends Equatable {

  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  const MealsByCategory({
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
  });


  @override
  List<Object?> get props => [
    idMeal,
    strMeal,
    strMealThumb,
  ];
}
