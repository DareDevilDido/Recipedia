
import 'package:recipe_widget/Models/recipesRepo.dart';

class Categories {
  String? ID;
  String category_name;
  List<recipesRepo> recipes;

  Categories(
      {required this.ID,
      required this.category_name,
      required this.recipes,
      });

  static Categories fromJson(String RecipeID, Map<String, dynamic> data,
      List<recipesRepo> rec) {
    return Categories(
        ID: RecipeID,
        category_name: data["category_name"].toString(),
        recipes:rec
      );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category_name"] = category_name;
    
    return data;
  }
}
