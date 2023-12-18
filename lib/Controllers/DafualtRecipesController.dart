import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/DefaultIngredientController.dart';
import 'package:recipedia/Repo/DefaultReciperepo.dart';
import '../Repo/DefaultIngredientsRepo.dart';
import '../Repo/InstructionRepo.dart';

class DefaultRecipesController extends ChangeNotifier {
  List<DefaultRecipeRepo> Recipes = [];
  List<DefaultRecipeRepo> NewRecipes = [];
  List<DefaultIngredientsRepo> ingredients = [];
  List<InstructionsRepo> insrtuctions = [];
  DefaultRecipeRepo? Recipe;
  String RecipeTime = "";
  int currentStep = 0;
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

  Future<void> getRecipes(String? userID) async {
    Recipes = [];
    if (userID != null) {
      final responce = await _firestore.collection("DefaultRecipes").get();
      Future.forEach(responce.docs, (Recipe) async {
        await getIngredients(Recipe.id);
        await getInsrtuctions(userID);
        reorganizeInstructions();
        Recipes.add(DefaultRecipeRepo.fromJson(
            Recipe.id, Recipe.data(), ingredients, insrtuctions));
        notifyListeners();
      });
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
      ingredients.add(responced);
      notifyListeners();
    });
  }

  Future<void> getSingleRecipe(String? userID, String RecipeID) async {
    ingredients = [];
    if (userID != null) {
      final responce =
          await _firestore.collection("DefaultRecipes").doc(RecipeID).get();
      await getIngredients(responce.id);
      await getInsrtuctions(responce.id);
      reorganizeInstructions();
      Recipe = DefaultRecipeRepo.fromJson(
          responce.id, responce.data()!, ingredients, insrtuctions);
    }
    notifyListeners();
  }

  Future<void> getInsrtuctions(String? userID) async {
    insrtuctions = [];
    if (userID != null) {
      final responce = await _firestore
          .collection("DefaultRecipes")
          .doc(userID)
          .collection("Instructions")
          .get();
      for (var instruction in responce.docs) {
        insrtuctions
            .add(InstructionsRepo.fromJson(instruction.id, instruction.data()));
      }
      notifyListeners();
    }
  }

  Future<QuerySnapshot> QueryRecipe(String Name) async {
    return await FirebaseFirestore.instance
        .collection("DefaultRecipes")
        .where("Name", isGreaterThanOrEqualTo: Name)
        .get();
  }

  Future<void> ProcessSearch(String Name) async {
    NewRecipes = [];
    QuerySnapshot snapshot = await QueryRecipe(Name);
    if (snapshot.docs.isNotEmpty) {
      NewRecipes += snapshot.docs.map((e) {
        return DefaultRecipeRepo.fromJson(
            e.id, e.data() as Map<String, dynamic>, [], []);
      }).toList();
    } else {
      await getRecipes(kUserId);
    }
    notifyListeners();
  }

  void reorganizeInstructions() {
    insrtuctions.sort((a, b) => a.Step.compareTo(b.Step));
  }

  Future<QuerySnapshot> QueryCategoryRecipe(String Category) async {
    return await FirebaseFirestore.instance
        .collection("DefaultRecipes")
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

  Future<void> AddNumber(String ID) async {
    final responce = _firestore.collection("DefaultRecipes").doc(ID);
    responce.update({"TimesFavorited": FieldValue.increment(1)});
  }

  Future<void> DeductNumber(String ID) async {
    final responce = _firestore.collection("DefaultRecipes").doc(ID);
    responce.update({"TimesFavorited": FieldValue.increment(-1)});
  }

  Future<void> getTop10Recipes(String? userID) async {
    if (userID != null) {
      Recipes = [];
      final responce = await _firestore
          .collection("DefaultRecipes")
          .limit(10)
          .orderBy("TimesFavorited", descending: true)
          .get();
      Future.forEach(responce.docs, (Recipe) async {
        Recipes.add(
            DefaultRecipeRepo.fromJson(Recipe.id, Recipe.data(), [], []));
        notifyListeners();
      });
      notifyListeners();
    }
  }
}

//Ingredient.data()["Link"])
