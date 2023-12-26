import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_widget/Controllers/AdminIngredientController.dart';
import 'package:recipe_widget/Models/DefaultIngredientsRepo.dart';
import 'package:recipe_widget/Models/instructionsRepo.dart';
import 'package:recipe_widget/Models/recipesRepo.dart';

import '../constantVariables/Constant.dart';

//import 'package:recipedia/Controllers/AdminIngredientController.dart';


class AdminRecipesController extends ChangeNotifier {
  List<recipesRepo> Recipes = [];
  List<DefaultIngredientsRepo> ingredients = [];
  List<String> ingredientsID = [];
  List<instructionsRepo> insrtuctions = [];
  int currentStep = 0;
  recipesRepo? Recipe;
  final _firestore = FirebaseFirestore.instance;

  void addStep() {
    currentStep++;
    notifyListeners();
  }

  void backStep() {
    currentStep--;
    notifyListeners();
  }

  void restartStep() {
    currentStep = 0;
    notifyListeners();
  }

  Future<void> getRecipes(String? userID) async {
    Recipes = [];
    if (userID != null) {
      final responce = await _firestore.collection("recipes").get();
      Future.forEach(responce.docs, (Recipe) async {
        Recipes.add(recipesRepo.fromJson(
            Recipe.id, Recipe.data(), ingredients, insrtuctions));
        notifyListeners();
      });
    }
  }

  Future<void> getIngredients(String RecipeID) async {
    ingredients = [];
    ingredientsID = [];
    final responce = await _firestore
        .collection("recipes")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();
    Future.forEach(responce.docs, (Ingredient) async {
      ingredientsID.add(Ingredient.id);
      final responced = await AdminIngredientController()
          .getIngredientById(RecipeID, Ingredient.data()["Link"]);
      ingredients.add(responced);
      notifyListeners();
    });
  }

  Future<void> getSingleRecipe(String? userID, String RecipeID) async {
    ingredients = [];
    ingredientsID = [];
    insrtuctions = [];
    if (userID != null) {
      final responce =
          await _firestore.collection("recipes").doc(RecipeID).get();
      await getIngredients(RecipeID);
      await getInsrtuctions(kUserId, RecipeID);// i need the if of the user
      reorganizeInstructions();
      Recipe = recipesRepo.fromJson(
          responce.id, responce.data()!, ingredients, insrtuctions);
    }
    notifyListeners();
  }

  Future<void> getInsrtuctions(String? userID, String RecipeID) async {
    insrtuctions = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("recipes")
          .doc(RecipeID)
          .collection("Instructions")
          .get();
      for (var instruction in responce.docs) {
          insrtuctions.add(
              instructionsRepo.fromJson(instruction.id, instruction.data()));
        }
      notifyListeners();
    }
  }

  void reorganizeInstructions() {
    insrtuctions.sort((a, b) => a.Step.compareTo(b.Step));
  }

  Future<void> DeleteRecipe(RecipeID) async {
    final responce =
        await _firestore.collection("recipes").doc(RecipeID).get();
    responce.reference.delete();
    notifyListeners();
  }

  Future<String> AddRecipe(String name, String Category, String nutrition,
      String Time, String Servings, String image) async {
    final responce = await _firestore.collection("recipes").add({
      "recipe_name": name,
      "nutrition": nutrition,
      "Time": Time,
      "Servings": Servings,
      
      "Image": image
    });
    notifyListeners();
    return responce.id.toString();
  }

  Future<void> EditRecipe(String name, String Category, String nutrition,
      String Time, String Servings, String image,String videoUrl) async {
    Recipe!.recipe_name = name;
    Recipe!.nutrition = nutrition;
    Recipe!.time = Time;
    Recipe!.Servings = Servings;
    Recipe!.Image = image;
    Recipe!.VideoUrl=videoUrl;
    final responce =
        await _firestore.collection("recipes").doc(Recipe!.ID).update({
      "recipe_name": name,
      "nutrition": nutrition,
      "Time": Time,
      "Servings": Servings,
      "VideoUrl":videoUrl,
      "Image": image
    });
    notifyListeners();
  }
}

// The 'Code-Under-Test' is a class called 'AdminRecipesController' that handles the management of recipes in a Flutter application. It includes methods for adding, editing, and deleting recipes, as well as retrieving recipes and their associated ingredients and instructions from a Firestore database.

// Inputs
// 'userID': A string representing the ID of the user.
// 'RecipeID': A string representing the ID of a recipe.
// 'name': A string representing the name of a recipe.
// 'Category': A string representing the category of a recipe.
// 'nutrition': A string representing the nutrition information of a recipe.
// 'Time': A string representing the cooking time of a recipe.
// 'Servings': A string representing the number of servings of a recipe.
// 'image': A string representing the image URL of a recipe.
// Flow
// The 'getRecipes' method retrieves all recipes from the Firestore database and adds them to the 'Recipes' list.
// The 'getIngredients' method retrieves the ingredients of a specific recipe from the Firestore database and adds them to the 'ingredients' list.
// The 'getSingleRecipe' method retrieves a specific recipe from the Firestore database, along with its ingredients and instructions, and creates a 'recipesRepo' object.
// The 'getInsrtuctions' method retrieves the instructions of a specific recipe from the Firestore database and adds them to the 'insrtuctions' list.
// The 'DeleteRecipe' method deletes a recipe from the Firestore database.
// The 'AddRecipe' method adds a new recipe to the Firestore database and returns its ID.
// The 'EditRecipe' method updates the details of a recipe in the Firestore database.
// Outputs
// 'Recipes': A list of 'recipesRepo' objects representing the retrieved recipes.
// 'ingredients': A list of 'DefaultIngredientsRepo' objects representing the retrieved ingredients of a recipe.
// 'insrtuctions': A list of 'instructionsRepo' objects representing the retrieved instructions of a recipe.
// 'Recipe': A 'recipesRepo' object representing a specific recipe


