import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/meals_categories_entity/meals_categories_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meals_categories_model.g.dart';

@JsonSerializable()
class MealsCategoriesModel extends Equatable {
  @JsonKey(name: "idCategory")
  final String? idCategory;
  
  @JsonKey(name: "strCategory")
  final String? strCategory;
  
  @JsonKey(name: "strCategoryThumb")
  final String? strCategoryThumb;
  
  @JsonKey(name: "strCategoryDescription")
  final String? strCategoryDescription;

  const MealsCategoriesModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealsCategoriesModel.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCategoriesModelToJson(this);
  }

  @override
  List<Object?> get props => [
    idCategory,
    strCategory,
    strCategoryThumb,
    strCategoryDescription,
  ];

MealsCategoriesEntity toEntity() {
    return MealsCategoriesEntity(
      idCategory: idCategory,
      strCategory: strCategory,
      strCategoryThumb: strCategoryThumb,
      strCategoryDescription: strCategoryDescription,
    );
  }   
}
