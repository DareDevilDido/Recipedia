import 'DefaultIngredientsRepo.dart';

class UserRecipeRepo {
  String ID;
  String Name;
  String nutrition;
  String category;
  String time;
  String Image;
  String Servings;
  List<DefaultIngredientsRepo> ingredients;

  UserRecipeRepo(
      {required this.ID,
      required this.Name,
      required this.Image,
      required this.nutrition,
      required this.category,
      required this.time,
      required this.Servings,
      required this.ingredients});

  static UserRecipeRepo fromJson(String RecipeID, Map<String, dynamic> data,
      List<DefaultIngredientsRepo> ing) {
    return UserRecipeRepo(
        ID: RecipeID,
        Name: data["Name"].toString(),
        Image: data["Image"].toString(),
        nutrition: data["nutrition"].toString(),
        category: data["category"].toString(),
        time: data["Time"].toString(),
        ingredients: ing,
        Servings: data["Servings"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Name"] = Name;
    data["nutrition"] = nutrition;
    data["category"] = category;
    data["Servings"] = Servings;
    data["Image"] = Image;
    data["Time"] = time;
    return data;
  }
}
