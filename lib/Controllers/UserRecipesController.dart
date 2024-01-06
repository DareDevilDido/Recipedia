import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import '../Repo/DefaultIngredientsRepo.dart';
import '../Repo/DefaultReciperepo.dart';
import '../Repo/InstructionRepo.dart';
import 'UserIngredientsController.dart';

class UserRecipesController extends ChangeNotifier {
  List<DefaultRecipeRepo> Recipes = [];
  List<DefaultIngredientsRepo> ingredients = [];
  List<String> ingredientsID = [];
  List<InstructionsRepo> insrtuctions = [];
  int currentStep = 0;
  DefaultRecipeRepo? Recipe;
  final _firestore = FirebaseFirestore.instance;

  void addStep() {
    if (currentStep < (insrtuctions.length - 1)) {
      currentStep++;
    }
    notifyListeners();
  }

  void backStep() {
    if (currentStep >= 1) {
      currentStep--;
    }
    notifyListeners();
  }

  void restartStep() {
    currentStep = 0;
    notifyListeners();
  }
Future<void> getRecipeIngredients() async {
    ingredients = [];
    var ingredientID = [];
    final responce = await _firestore.collection("DefaultIngredients").get();
    for (var Ingredient in responce.docs) {
      ingredientID.add(Ingredient.id);
      ingredients.add(
          DefaultIngredientsRepo.fromJson(Ingredient.id, Ingredient.data()));
    }
    notifyListeners();
    }

  Future<void> getRecipes(String? userID) async {
    Recipes = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(userID)
          .collection("Recipe List")
          .get();
      Future.forEach(responce.docs, (Recipe) async {
        await getIngredients(Recipe.id);
        await getInsrtuctions(userID, Recipe.id);
        reorganizeInstructions();

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
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Ingredients")
        .get();
    Future.forEach(responce.docs, (Ingredient) async {
      ingredientsID.add(Ingredient.id);
      final responced = await UserIngredientController()
          .getIngredientById(kUserId, Ingredient.data()["Link"]);
      ingredients.add(responced);
      notifyListeners();
    });
  }

  Future<void> getSingleRecipe(String? userID, String RecipeID) async {
    ingredients = [];
    ingredientsID = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(kUserId)
          .collection("Recipe List")
          .doc(RecipeID)
          .get();
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
          .collection("UserRecipes")
          .doc(userID)
          .collection("Recipe List")
          .doc(RecipeID)
          .collection("Instructions")
          .get();
      for (var instruction in responce.docs) {
          insrtuctions.add(
              InstructionsRepo.fromJson(instruction.id, instruction.data()));
        }
    }
  }

  void reorganizeInstructions() {
    insrtuctions.sort((a, b) => a.Step.compareTo(b.Step));
  }

  Future<void> DeleteRecipe(RecipeID) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .get();

    responce.reference.delete();
  }

  Future<String> AddRecipe(String name, String Category, String nutrition,
      String Time, String Servings, String image,String VideoLink) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .add({
      "Name": name,
      "nutrition": nutrition,
      "Time": Time,
      "Servings": Servings,
      "Category": Category,
      "Image": image,
      "VideoLink":VideoLink
    });
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
  
     final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(Recipe?.ID).update({
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

  Future<QuerySnapshot> QueryCategoryRecipe(String Category) async {
    return await FirebaseFirestore.instance
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .where("Category", isEqualTo: Category)
        .get();
  }

  Future<void> FilterCategory(String Category) async {
    Recipes = [];
    QuerySnapshot snapshot = await QueryCategoryRecipe(Category);
    if (snapshot.docs.isNotEmpty) {
      Recipes += snapshot.docs.map((e) {
        return DefaultRecipeRepo.fromJson(
            e.id, e.data() as Map<String, dynamic>, [], []);
      }).toList();
    }
    notifyListeners();
  }
}

//Ingredient.data()["Link"])
