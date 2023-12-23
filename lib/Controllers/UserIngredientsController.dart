import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Repo/DefaultIngredientsRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserIngredientController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<DefaultIngredientsRepo> ingredients = [];
  List<DefaultIngredientsRepo> Newingredients = [];
  List<String> ingredientID = [];
  int count = 0;

  Future<void> getIngredients(String? userID) async {
    if (userID != null) {
      ingredients = [];
      ingredientID = [];
      final responce = await _firestore
          .collection("UserIngredients")
          .doc(kUserId)
          .collection("Ingredient List")
          .get();
      for (var Ingredient in responce.docs) {
        ingredientID.add(Ingredient.id);
        ingredients.add(
            DefaultIngredientsRepo.fromJson(Ingredient.id, Ingredient.data()));
        notifyListeners();
      }
      notifyListeners();
    }
  }

  Future<DefaultIngredientsRepo> getIngredientById(
      String? userID, String IngID) async {
    DefaultIngredientsRepo? ingredient;
    if (userID != null) {
      final responce = await _firestore
          .collection("UserIngredients")
          .doc(kUserId)
          .collection("Ingredient List")
          .doc(IngID)
          .get();
      ingredient =
          DefaultIngredientsRepo.fromJson(responce.id, responce.data()!);
    }
    notifyListeners();
    return ingredient!;
  }

  Future<void> AddOriginalIngredient(DefaultIngredientsRepo IngID) async {
    final responce = await _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .add({"Image": IngID.image, "Name": IngID.Name, "TimesUsed": 0});
    notifyListeners();
  }

  Future<void> AddOriginalIngredient2(String name, String image) async {
    final responce = await _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .add({"Image": image, "Name": name, "TimesUsed": 0});
    notifyListeners();
  }

  Future<void> EditOriginalIngredient(
      DefaultIngredientsRepo Ing, String ID) async {
    final responce = _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .doc(ID);
    responce.update({"Image": Ing.image, "Name": Ing.Name});
    notifyListeners();
  }

  Future<void> DeleteOriginalIngredient(String ID) async {
    final responce = _firestore
        .collection("UserIngredients")
        .doc(kUserId)
        .collection("Ingredient List")
        .doc(ID);
    responce.delete();
    notifyListeners();
  }

  Future<void> getTop10Ingredients(String? userID) async {
    if (userID != null) {
      ingredients = [];
      final responce = await _firestore.collection("UserIngredients").get();
      Future.forEach(responce.docs, (UserInstance) async {
        final IngredientResponce = await _firestore
            .collection("UserIngredients")
            .doc(UserInstance.id)
            .collection("Ingredient List")
            .limit(10)
            .orderBy("TimesUsed", descending: false)
            .get();
        for (var Ingredient in IngredientResponce.docs) {
          ingredients.add(DefaultIngredientsRepo.fromJson(
              Ingredient.id, Ingredient.data()));
          reorganizeIngredients();
          notifyListeners();
        }
      });
    }
  }

  void reorganizeIngredients() {
    ingredients.sort((b, a) => a.timesused.compareTo(b.timesused));
  }
}