import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipedia/Repo/InstructionRepo.dart';

class AdminInsrtuctionCntroller extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<InstructionsRepo> insrtuctions = [];

  Future<void> AddAllInstructions(
      String RecipeID, List<InstructionsRepo> Instructions) async {
    await DeleteInstructionCollection(RecipeID);
    Future.forEach(Instructions, (Instruction) async {
      final responce = await _firestore
          .collection("DefaultRecipes")
          .doc(RecipeID)
          .collection("Instructions")
          .add({
        "Description": Instruction.Description,
        "Step": Instruction.Step,
      });
    });
    notifyListeners();
  }

  Future<void> AddInstruction(String RecipeID, InstructionsRepo inst) async {
    final responce = await _firestore
        .collection("DefaultRecipes")
        .doc(RecipeID)
        .collection("Instructions")
        .add({
      "Description": inst.Description,
      "Step": inst.Step,
    });
    notifyListeners();
  }

  Future<void> DeleteInstructionCollection(String RecipeID) async {
    final responce = await _firestore
        .collection("DefaultRecipes")
        .doc(RecipeID)
        .collection("Instructions")
        .get();
    Future.forEach(responce.docs, (Instruction) async {
      final subresponce = _firestore
          .collection("DefaultRecipes")
          .doc(RecipeID)
          .collection("Instructions")
          .doc(Instruction.id);
      subresponce.delete();
    });
    notifyListeners();
  }
}
