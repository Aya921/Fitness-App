import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/json_serializable_constants.dart';
import '../../domain/entities/meals_categories.dart';

part 'meal_categories.g.dart';

@JsonSerializable()
class MealCaregoriesResponse {
  @JsonKey(name: JsonSerializableConstants.categories)
  final List<MealCategories>? categories;

  MealCaregoriesResponse ({
    this.categories,
  });

  factory MealCaregoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealCaregoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealCaregoriesResponseToJson(this);
  }
}

@JsonSerializable()
class MealCategories {
  @JsonKey(name: JsonSerializableConstants.idCategory)
  final String? idCategory;
  @JsonKey(name: JsonSerializableConstants.strCategory)
  final String? strCategory;
  @JsonKey(name: JsonSerializableConstants.strCategoryThumb)
  final String? strCategoryThumb;
  @JsonKey(name: JsonSerializableConstants.strCategoryDescription)
  final String? strCategoryDescription;
  MealCategories ({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealCategories.fromJson(Map<String, dynamic> json) {
    return _$MealCategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealCategoriesToJson(this);
  }
  MealCategoryEntity toEntity(){
  return MealCategoryEntity(idCategory: idCategory!,
      strCategory: strCategory!,
      strCategoryThumb: strCategoryThumb!,
      strCategoryDescription: strCategoryDescription!)  ;
  }
}


