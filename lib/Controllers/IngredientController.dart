import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/DefaultIngredientsRepo.dart';

class IngredientController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<DefaultIngredientsRepo> ingredients = [];

  Future<void> getIngredients(String? userID) async {
    if (userID != null) {
      ingredients = [];
      final responce = await _firestore.collection("DefaultIngredients").get();

      for (var Ingredient in responce.docs) {
        ingredients.add(
            DefaultIngredientsRepo.fromJson(Ingredient.id, Ingredient.data()));
      }
      notifyListeners();
    }
  }

  Future<DefaultIngredientsRepo> getIngredientById(
      String? userID, String IngID) async {
    DefaultIngredientsRepo? ingredient;
    if (userID != null) {
      final responce =
          await _firestore.collection("DefaultIngredients").doc(IngID).get();
      ingredient =
          DefaultIngredientsRepo.fromJson(responce.id, responce.data()!);
    }
    notifyListeners();
    return ingredient!;
  }
}
