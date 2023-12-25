import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/instructionsRepo.dart';
import '../Models/recipesRepo.dart';
import '../constantVariables/Constant.dart';

import 'IngredientController.dart';
import 'RecipesController.dart';

class FavortieRecipesController extends ChangeNotifier {
  List<recipesRepo> favRecipes = [];
  List<instructionsRepo> insrtuctions = [];
  List<instructionsRepo> organizedInstructions = [];
  bool isFavorited = false;
  final _firestore = FirebaseFirestore.instance;

  Future<void> getRecipes(String? userID) async {
    favRecipes = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("UserFavorites")
          .doc(userID)
          .collection("Recipes")
          .get();
      final responce2 = await _firestore.collection("recipes").get();
      for (var Recipe in responce2.docs) {
        for (var FavRecipe in responce.docs) {
          if (Recipe.id == FavRecipe.id) {
            favRecipes.add(
                recipesRepo.fromJson(Recipe.id, Recipe.data(), [], []));
            notifyListeners();
          }
        }
      }
    }
  }

  Future<void> getIngredients(String RecipeID) async {
    final responce = await _firestore
        .collection("recipes")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();

    Future.forEach(responce.docs, (Ingredient) async {
      final responced = await IngredientController()
          .getIngredientById(kUserId, Ingredient.data()["Link"]);
      RecipesController().ingredients.add(responced);
      notifyListeners();
    });
    notifyListeners();
  }

  Future<dynamic> getSingleRecipe(String? userID, String RecipeID) async {
    if (userID != null) {
      final responce =
          await _firestore.collection("recipes").doc(RecipeID).get();
      await getIngredients(responce.id);
      await getInsrtuctions(responce.id);
      reorganizeInstructions();
      return recipesRepo.fromJson(responce.id, responce.data()!,
          RecipesController().ingredients, insrtuctions);
    }
    notifyListeners();
  }

  Future<void> getInsrtuctions(String? userID) async {
    if (userID != null) {
      insrtuctions = [];
      final responce = await _firestore
          .collection("recipes")
          .doc(userID)
          .collection("instructions")
          .get();
      for (var instruction in responce.docs) {
        insrtuctions
            .add(instructionsRepo.fromJson(instruction.id, instruction.data()));
      }
    }
    notifyListeners();
  }

  void reorganizeInstructions() {
    insrtuctions.sort((a, b) => a.Step.compareTo(b.Step));
  }

  Future<void> CheckIfFavorited(String RecipeID) async {
    final responce = await _firestore
        .collection("UserFavorites")
        .doc(kUserId)
        .collection("Recipes")
        .doc(RecipeID)
        .get();

    if (responce.exists) {
      isFavorited = true;
    } else {
      isFavorited = false;
    }
    notifyListeners();
  }

  Future<void> DeleteRecipe(RecipeID) async {
    final responce = await _firestore
        .collection("UserFavorites")
        .doc(kUserId)
        .collection("Recipes")
        .doc(RecipeID)
        .get();
    responce.reference.delete();
    await RecipesController().DeductNumber(RecipeID);
    notifyListeners();
  }

  Future<void> AddRecipe(String RecipeId) async {
    final responce = await _firestore
        .collection("UserFavorites")
        .doc(kUserId)
        .collection("Recipes")
        .doc(RecipeId)
        .set({});
    await RecipesController().AddNumber(RecipeId);
    notifyListeners();
  }
}

//Ingredient.data()["Link"])
