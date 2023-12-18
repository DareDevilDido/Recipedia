import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Controllers/DefaultIngredientController.dart';
import 'package:recipedia/Repo/DefaultReciperepo.dart';
import '../Constants/Constants.dart';
import '../Repo/InstructionRepo.dart';
import 'DafualtRecipesController.dart';

class FavortieRecipesController extends ChangeNotifier {
  List<DefaultRecipeRepo> favRecipes = [];
  List<InstructionsRepo> insrtuctions = [];
  List<InstructionsRepo> organizedInstructions = [];
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
      final responce2 = await _firestore.collection("DefaultRecipes").get();
      for (var Recipe in responce2.docs) {
        for (var FavRecipe in responce.docs) {
          if (Recipe.id == FavRecipe.id) {
            favRecipes.add(
                DefaultRecipeRepo.fromJson(Recipe.id, Recipe.data(), [], []));
            notifyListeners();
          }
        }
      }
    }
  }

  Future<void> getIngredients(String RecipeID) async {
    final responce = await _firestore
        .collection("DefaultRecipes")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();

    Future.forEach(responce.docs, (Ingredient) async {
      final responced = await DefaultIngredientCntroller()
          .getIngredientById(kUserId, Ingredient.data()["Link"]);
      DefaultRecipesController().ingredients.add(responced);
      notifyListeners();
    });
    notifyListeners();
  }

  Future<dynamic> getSingleRecipe(String? userID, String RecipeID) async {
    if (userID != null) {
      final responce =
          await _firestore.collection("DefaultRecipes").doc(RecipeID).get();
      await getIngredients(responce.id);
      await getInsrtuctions(responce.id);
      reorganizeInstructions();
      return DefaultRecipeRepo.fromJson(responce.id, responce.data()!,
          DefaultRecipesController().ingredients, insrtuctions);
    }
    notifyListeners();
  }

  Future<void> getInsrtuctions(String? userID) async {
    if (userID != null) {
      insrtuctions = [];
      final responce = await _firestore
          .collection("DefaultRecipes")
          .doc(userID)
          .collection("Instructions")
          .get();
      for (var instruction in responce.docs) {
        insrtuctions
            .add(InstructionsRepo.fromJson(instruction.id, instruction.data()));
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
    await DefaultRecipesController().DeductNumber(RecipeID);
    notifyListeners();
  }

  Future<void> AddRecipe(String RecipeId) async {
    final responce = await _firestore
        .collection("UserFavorites")
        .doc(kUserId)
        .collection("Recipes")
        .doc(RecipeId)
        .set({});
    await DefaultRecipesController().AddNumber(RecipeId);
    notifyListeners();
  }
}

//Ingredient.data()["Link"])
