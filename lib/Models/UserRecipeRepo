import 'DefaultIngredientsRepo.dart';

class UserRecipeRepo {
  String ID;
  String Name;
  String nutrition;
  String Category;
  String time;
  String Image;
  String Servings;
  List<DefaultIngredientsRepo> ingredients;

  UserRecipeRepo(
      {required this.ID,
      required this.Name,
      required this.Image,
      required this.nutrition,
      required this.Category,
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
        Category: data["Category"].toString(),
        time: data["Time"].toString(),
        ingredients: ing,
        Servings: data["Servings"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Name"] = Name;
    data["nutrition"] = nutrition;
    data["Category"] = Category;
    data["Servings"] = Servings;
    data["Image"] = Image;
    data["Time"] = time;
    return data;
  }
}
