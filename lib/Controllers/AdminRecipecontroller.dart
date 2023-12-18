import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/AdminIngredientController.dart';
import '../Repo/DefaultIngredientsRepo.dart';
import '../Repo/DefaultReciperepo.dart';
import '../Repo/InstructionRepo.dart';

class AdminRecipesController extends ChangeNotifier {
  List<DefaultRecipeRepo> Recipes = [];
  List<DefaultIngredientsRepo> ingredients = [];
  List<String> ingredientsID = [];
  List<InstructionsRepo> insrtuctions = [];
  int currentStep = 0;
  DefaultRecipeRepo? Recipe;
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
      final responce = await _firestore.collection("DefaultRecipes").get();
      Future.forEach(responce.docs, (Recipe) async {
        Recipes.add(DefaultRecipeRepo.fromJson(
            Recipe.id, Recipe.data(), ingredients, insrtuctions));
        notifyListeners();
      });
    }
  }

  Future<void> getIngredients(String RecipeID) async {
    ingredients = [];
    ingredientsID = [];
    final responce = await _firestore
        .collection("DefaultRecipes")
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
          await _firestore.collection("DefaultRecipes").doc(RecipeID).get();
      await getIngredients(RecipeID);
      await getInsrtuctions(kUserId, RecipeID);
      reorganizeInstructions();
      Recipe = DefaultRecipeRepo.fromJson(
          responce.id, responce.data()!, ingredients, insrtuctions);
    }
    notifyListeners();
  }

  Future<void> getInsrtuctions(String? userID, String RecipeID) async {
    insrtuctions = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("DefaultRecipes")
          .doc(RecipeID)
          .collection("Instructions")
          .get();
      for (var instruction in responce.docs) {
          insrtuctions.add(
              InstructionsRepo.fromJson(instruction.id, instruction.data()));
        }
      notifyListeners();
    }
  }

  void reorganizeInstructions() {
    insrtuctions.sort((a, b) => a.Step.compareTo(b.Step));
  }

  Future<void> DeleteRecipe(RecipeID) async {
    final responce =
        await _firestore.collection("DefaultRecipes").doc(RecipeID).get();
    responce.reference.delete();
    notifyListeners();
  }

  Future<String> AddRecipe(String name, String Category, String Calories,
      String Time, String Servings, String image) async {
    final responce = await _firestore.collection("DefaultRecipes").add({
      "Name": name,
      "Calories": Calories,
      "Time": Time,
      "Servings": Servings,
      "Category": Category,
      "Image": image
    });
    notifyListeners();
    return responce.id.toString();
  }

  Future<void> EditRecipe(String name, String Category, String Calories,
      String Time, String Servings, String image) async {
    Recipe!.Name = name;
    Recipe!.Category = Category;
    Recipe!.Calories = Calories;
    Recipe!.time = Time;
    Recipe!.Servings = Servings;
    Recipe!.Image = image;
    final responce =
        await _firestore.collection("DefaultRecipes").doc(Recipe!.ID).update({
      "Name": name,
      "Calories": Calories,
      "Time": Time,
      "Servings": Servings,
      "Category": Category,
      "Image": image
    });
    notifyListeners();
  }
}

//Ingredient.data()["Link"])
