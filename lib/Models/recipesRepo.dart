import 'package:recipe_widget/Models/DefaultIngredientsRepo.dart';
import 'package:recipe_widget/Models/instructionsRepo.dart';

class recipesRepo{
  String? ID;
  String nutrition;
  String recipe_name;
  String Servings;
  String Image;
  String time;
  String VideoUrl;
  String category;
  List<instructionsRepo> instructions;
  List<DefaultIngredientsRepo> ingredients;
  recipesRepo(
      {required this.ID,
      required this.recipe_name,
      required this.Image,
      required this.nutrition,
      required this.time,
      required this.Servings,
      required this.ingredients,
      required this.instructions,
      required this.VideoUrl,
      required this.category});
   static recipesRepo fromJson(String RecipeID, Map<String, dynamic> data,
      List<DefaultIngredientsRepo> ing,List<instructionsRepo> ins) {
    return recipesRepo(
        ID: RecipeID,
        recipe_name: data["recipe_name"].toString(),
        Image: data["Image"].toString(),
        nutrition: data["nutrition"].toString(),
        time: data["Time"].toString(),
        ingredients: ing,
        instructions:ins,
        Servings: data["Servings"].toString(),
        VideoUrl:data["VideoUrl"].toString(),
        category:data["category"].toString());
        
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["recipe_name"] = recipe_name;
    data["nutrition"] = nutrition;
    data["Servings"] = Servings;
    data["Image"] = Image;
    data["Time"] = time;
    data["VideoUrl"]=VideoUrl;
    data["category"]=category;
    return data;
  }
}

