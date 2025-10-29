sealed  class FoodIntent{}
final class FoodInitializationIntent extends FoodIntent{}
final class MealsByCategoriesIntent extends FoodIntent{
  String category;
  MealsByCategoriesIntent(this.category);
}