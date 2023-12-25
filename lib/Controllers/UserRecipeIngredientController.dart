import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserRecipeIngredientRepo.dart';
import '../constantVariables/Constant.dart';

class UserRecipeIngredientController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<UserRecipeIngredientRepo> ingredients = [];
  List<String> ingredientID = [];
  List<String> useringredientID = [];
  Future<void> getRecipeIngredients(String RecipeID) async {
    ingredients = [];
    ingredientID = [];
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();
    for (var Ingredient in responce.docs) {
      ingredientID.add(Ingredient.id);
      ingredients.add(
          UserRecipeIngredientRepo.fromJson(Ingredient.id, Ingredient.data()));
    }
    notifyListeners();
  }

  Future<UserRecipeIngredientRepo> getIngredientById(
      String? RecipeID, String IngID) async {
    UserRecipeIngredientRepo? ingredient;
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Ingredients")
        .doc(IngID)
        .get();
    ingredient =
        UserRecipeIngredientRepo.fromJson(responce.id, responce.data()!);
    notifyListeners();
    return ingredient;
  }

  Future<void> AddIngredient(String RecipeID, String IngId) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Ingredients")
        .add({
      "Link": IngId,
    });
  }

  Future<void> AddAllIngredient(
      String RecipeID, List<String> ingredientsId) async {
    await DeleteIngredientCollection(RecipeID);
    Future.forEach(ingredientsId, (Ingredient) async {
      await AddNumber(Ingredient);
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(kUserId)
          .collection("Recipe List")
          .doc(RecipeID)
          .collection("Ingredients")
          .add({
        "Link": Ingredient,
      });
    });
  }

  Future<void> DeleteIngredientCollection(String RecipeID) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();
    Future.forEach(responce.docs, (Ingredient) async {
      await DeductNumber(Ingredient["Link"]);
      final subresponce = _firestore
          .collection("UserRecipes")
          .doc(kUserId)
          .collection("Recipe List")
          .doc(RecipeID)
          .collection("Ingredients")
          .doc(Ingredient.id);
      subresponce.delete();
    });
    notifyListeners();
  }

  Future<void> AddNumber(String ID) async {
    final responce = _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .doc(ID);
    responce.update({"TimesUsed": FieldValue.increment(1)});
  }

  Future<void> DeductNumber(String ID) async {
    final responce = _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .doc(ID);
    responce.update({"TimesUsed": FieldValue.increment(-1)});
  }
}
