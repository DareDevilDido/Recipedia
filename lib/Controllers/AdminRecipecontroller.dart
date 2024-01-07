import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/AdminIngredientController.dart';
import '../Models/Repo/DefaultIngredientsRepo.dart';
import '../Models/Repo/DefaultReciperepo.dart';
import '../Models/Repo/InstructionRepo.dart';

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
      final responce = await _firestore.collection("DefaultRecipe").get();
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
        .collection("DefaultRecipe")
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
          await _firestore.collection("DefaultRecipe").doc(RecipeID).get();
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
          .collection("DefaultRecipe")
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
        await _firestore.collection("DefaultRecipe").doc(RecipeID).get();
    responce.reference.delete();
    notifyListeners();
  }

  Future<String> AddRecipe(String name, String Category, String nutrition,
      String Time, String Servings, String image,String VideoLink) async {
    final responce = await _firestore.collection("DefaultRecipe").add({
      "Name": name,
      "nutrition": nutrition,
      "Time": Time,
      "Servings": Servings,
      "Category": Category,
      "Image": image,
      "VideoLink":VideoLink
    });
    notifyListeners();
    return responce.id.toString();
  }

  Future<void> EditRecipe(String name, String Category, String nutrition,
      String Time, String Servings, String image,String videoLink) async {
    Recipe!.Name = name;
    Recipe!.Category = Category;
    Recipe!.nutrition = nutrition;
    Recipe!.time = Time;
    Recipe!.Servings = Servings;
    Recipe!.Image = image;
    Recipe!.VideoLink=videoLink;
    final responce =
        await _firestore.collection("DefaultRecipe").doc(Recipe!.ID).update({
      "Name": name,
      "nutrition": nutrition,
      "Time": Time,
      "Servings": Servings,
      "Category": Category,
      "Image": image,
      "VideoLink":videoLink
    });
    notifyListeners();
  }
}

//Ingredient.data()["Link"])
