import 'package:recipedia/Repo/InstructionRepo.dart';

import 'DefaultIngredientsRepo.dart';

class DefaultRecipeRepo {
  String ID;
  String Name;
  String nutrition;
  String Category;
  String time;
  String Image;
  String Servings;
  String TimesFavorited;
  List<DefaultIngredientsRepo> ingredients;
  List<InstructionsRepo> instructions;

  DefaultRecipeRepo(
      {required this.ID,
      required this.Name,
      required this.Image,
      required this.nutrition,
      required this.Category,
      required this.time,
      required this.Servings,
      required this.ingredients,
      required this.TimesFavorited,
      required this.instructions});

  static DefaultRecipeRepo fromJson(String RecipeID, Map<String, dynamic> data,
      List<DefaultIngredientsRepo> ing, List<InstructionsRepo> inst) {
    return DefaultRecipeRepo(
        ID: RecipeID,
        Name: data["Name"].toString(),
        Image: data["Image"].toString(),
        nutrition: data["nutrition"].toString(),
        Category: data["Category"].toString(),
        time: data["Time"].toString(),
        ingredients: ing,
        Servings: data["Servings"].toString(),
        TimesFavorited: data["TimesFavorited"].toString(),
        instructions: inst);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Name"] = Name;
    data["nutrition"] = nutrition;
    data["Category"] = Category;
    data["Servings"] = Servings;
    data["Image"] = Image;
    data["Time"] = time;
    data["TimesFavorited"] = 0;
    return data;
  }
}
