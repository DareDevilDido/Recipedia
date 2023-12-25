import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/instructionsRepo.dart';
import '../constantVariables/Constant.dart';

class UserInsrtuctionCntroller extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<instructionsRepo> insrtuctions = [];

  Future<void> getInsrtuctions(String? userID) async {
    if (userID != null) {
      insrtuctions = [];
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(userID)
          .collection("Instructions")
          .get();

      for (var instruction in responce.docs) {
        insrtuctions
            .add(instructionsRepo.fromJson(instruction.id, instruction.data()));
      }
      notifyListeners();
    }
  }

  Future<instructionsRepo> getInsrtuctionById(
      String? userID, String IngID) async {
    instructionsRepo? ingredient;
    if (userID != null) {
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(userID)
          .collection("Instructions")
          .doc(IngID)
          .get();
      ingredient = instructionsRepo.fromJson(responce.id, responce.data()!);
    }
    notifyListeners();
    return ingredient!;
  }

  Future<void> AddInstruction(String RecipeID, instructionsRepo inst) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Instructions")
        .add({
      "Description": inst.Description,
      "Step": inst.Step,
    });
    notifyListeners();
  }

  Future<void> AddAllInstructions(
      String RecipeID, List<instructionsRepo> Instructions) async {
    await DeleteInstructionCollection(RecipeID);
    Future.forEach(Instructions, (Instruction) async {
      final responce = await _firestore
          .collection("UserRecipes")
          .doc(kUserId)
          .collection("Recipe List")
          .doc(RecipeID)
          .collection("Instructions")
          .add({
        "Description": Instruction.Description,
        "Step": Instruction.Step,
      });
    });
    notifyListeners();
  }

  Future<void> DeleteInstructionCollection(String RecipeID) async {
    final responce = await _firestore
        .collection("UserRecipes")
        .doc(kUserId)
        .collection("Recipe List")
        .doc(RecipeID)
        .collection("Instructions")
        .get();
    Future.forEach(responce.docs, (Instruction) async {
      final subresponce = _firestore
          .collection("UserRecipes")
          .doc(kUserId)
          .collection("Recipe List")
          .doc(RecipeID)
          .collection("Instructions")
          .doc(Instruction.id);
      subresponce.delete();
    });
    notifyListeners();
  }
}
