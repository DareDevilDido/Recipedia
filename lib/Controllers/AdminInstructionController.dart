import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/instructionsRepo.dart';

class AdminInsrtuctionCntroller extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<instructionsRepo> insrtuctions = [];

  Future<void> AddAllInstructions(
      String RecipeID, List<instructionsRepo> instructions) async {
    await DeleteInstructionCollection(RecipeID);
    Future.forEach(instructions, (instruction) async {
      final responce = await _firestore
          .collection("recipes")
          .doc(RecipeID)
          .collection("instructions")
          .add({
        "Description": instruction.Description,
        "Step": instruction.Step,
      });
    });
    notifyListeners();
  }

  Future<void> AddInstruction(String RecipeID, instructionsRepo inst) async {
    final responce = await _firestore
        .collection("recipes")
        .doc(RecipeID)
        .collection("instructions")
        .add({
      "Description": inst.Description,
      "Step": inst.Step,
    });
    notifyListeners();
  }

  Future<void> DeleteInstructionCollection(String RecipeID) async {
    final responce = await _firestore
        .collection("recipes")
        .doc(RecipeID)
        .collection("instructions")
        .get();
    Future.forEach(responce.docs, (instruction) async {
      final subresponce = _firestore
          .collection("recipes")
          .doc(RecipeID)
          .collection("instructions")
          .doc(instruction.id);
      subresponce.delete();
    });
    notifyListeners();
  }
}
