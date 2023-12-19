
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Repo/DefaultIngredientsRepo.dart';

class AdminIngredientController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<DefaultIngredientsRepo> ingredients = [];
  List<String> ingredientID = [];
  List<String> useringredientID = [];
  Future<void> getRecipeIngredients() async {
    ingredients = [];
    ingredientID = [];
    final responce = await _firestore.collection("DefaultIngredients").get();
    for (var Ingredient in responce.docs) {
      ingredientID.add(Ingredient.id);
      ingredients.add(
          DefaultIngredientsRepo.fromJson(Ingredient.id, Ingredient.data()));
    }
    notifyListeners();
    }

  Future<DefaultIngredientsRepo> getIngredientById(
      String? RecipeID, String IngID) async {
    DefaultIngredientsRepo? ingredient;
    final responce =
        await _firestore.collection("DefaultIngredients").doc(IngID).get();
    ingredient =
        DefaultIngredientsRepo.fromJson(responce.id, responce.data()!);
      notifyListeners();
    return ingredient;
  }

  Future<void> AddIngredient(String RecipeID, String ingid) async {
    final responce = await _firestore
        .collection("DefaultRecipe")
        .doc(RecipeID)
        .collection("Ingredients")
        .add({"Link": ingid});
    notifyListeners();
  }

  Future<void> AddIngredient2(
      String RecipeID, String Name, String Image) async {
    final responce = await _firestore
        .collection("DefaultIngredients")
        .add({"Name": Name, "Image": Image});
    notifyListeners();
  }

  Future<void> AddAllIngredient(
      String RecipeID, List<String> ingredientsId) async {
    await DeleteIngredientCollection(RecipeID);

    Future.forEach(ingredientsId, (Ingredient) async {
      final responce = await _firestore
          .collection("DefaultRecipe")
          .doc(RecipeID)
          .collection("Ingredients")
          .add({
        "Link": Ingredient,
      });
    });
    notifyListeners();
  }

  Future<void> DeleteIngredientCollection(String RecipeID) async {
    final responce = await _firestore
        .collection("DefaultRecipe")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();
    Future.forEach(responce.docs, (Ingredient) async {
      final subresponce = _firestore
          .collection("DefaultRecipe")
          .doc(RecipeID)
          .collection("Ingredients")
          .doc(Ingredient.id);
      subresponce.delete();
    });
    notifyListeners();
    }
}
