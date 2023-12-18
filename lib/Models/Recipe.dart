import 'package:flutter/material.dart';
import '../Repo/DefaultIngredientsRepo.dart';
import '../Repo/InstructionRepo.dart';

class Recipe extends ChangeNotifier {
  List<DefaultIngredientsRepo> ingredients = [];
  List<String> ingredientID = [];
  List<InstructionsRepo> insrtuctions = [];

  void addIngredientToList(Ingredient, String id) {
    ingredients.add(Ingredient);
    addIngredientIDToList(id);
    notifyListeners();
  }

  void addIngredientIDToList(Ingredient) {
    ingredientID.add(Ingredient);
    notifyListeners();
  }

  void addInstructionsToList(Instruction) {
    insrtuctions.add(Instruction);
    notifyListeners();
  }

  void removeIngrecientFromList(Index) {
    ingredients.removeAt(Index);
    removeIngrecientIDFromList(Index);
    notifyListeners();
  }

  void removeIngrecientIDFromList(Index) {
    ingredientID.removeAt(Index);
    notifyListeners();
  }

  void removeInstructionsToList(Index) {
    insrtuctions.removeAt(Index);
    notifyListeners();
  }
}
