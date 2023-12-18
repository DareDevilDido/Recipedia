import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';

import '../Repo/DefaultReciperepo.dart';

class RandomRecipeOfTheDay extends ChangeNotifier {
  List<DefaultRecipeRepo> RecipeList = [];
  DefaultRecipeRepo? ROTD;
  String RecipeTime = "";
  Random random = Random();
  final _firestore = FirebaseFirestore.instance;
  Future<void> getRandomRecipe() async {
    final responce =
        await _firestore.collection("UserInformation").doc(kUserId).get();
    final responce2 =
        _firestore.collection("UserInformation").doc(kUserId);
    var currentTime = DateTime.now();
    RecipeTime = responce["ROTD Type"];
    if (currentTime.hour < 12 && responce["ROTD Type"] != "BreakFast") {
      await FilterCategory("BreakFast");
      int count = RecipeList.length == 1
          ? RecipeList.length - 1
          : random.nextInt(RecipeList.length - 1);
      responce2.update(
          {"ROTD Type": "BreakFast", "ROTD Link": RecipeList[count].ID});
    } else if (currentTime.hour >= 12 &&
        currentTime.hour < 18 &&
        responce["ROTD Type"] != "Lunch") {
      await FilterCategory("Lunch");
      int count = random.nextInt(RecipeList.length - 1);
      responce2
          .update({"ROTD Type": "Lunch", "ROTD Link": RecipeList[count].ID});
    } else if (currentTime.hour >= 18 && responce["ROTD Type"] != "Dinner") {
      await FilterCategory("Dinner");
      int count = random.nextInt(RecipeList.length - 1);
      responce2
          .update({"ROTD Type": "Dinner", "ROTD Link": RecipeList[count].ID});
    }
    getSingleRecipe();
    notifyListeners();
  }

  Future<QuerySnapshot> QueryRecipe(String Category) async {
    return await FirebaseFirestore.instance
        .collection("DefaultRecipes")
        .where("Category", isEqualTo: Category)
        .get();
  }

  Future<void> FilterCategory(String Category) async {
    QuerySnapshot snapshot = await QueryRecipe(Category);
    if (snapshot.docs.isNotEmpty) {
      RecipeList += snapshot.docs.map((Recipe) {
        return DefaultRecipeRepo.fromJson(
            Recipe.id, Recipe.data() as Map<String, dynamic>, [], []);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> getSingleRecipe() async {
    final responce =
        await _firestore.collection("UserInformation").doc(kUserId).get();
    final responce2 = await _firestore
        .collection("DefaultRecipes")
        .doc(responce["ROTD Link"])
        .get();
    ROTD = DefaultRecipeRepo.fromJson(responce2.id, responce2.data()!, [], []);
    notifyListeners();
  }
}
