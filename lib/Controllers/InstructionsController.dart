import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipedia/Repo/InstructionRepo.dart';

class InsrtuctionCntroller extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<InstructionsRepo> insrtuctions = [];

  Future<void> getInsrtuctions(String? userID) async {
    if (userID != null) {
      insrtuctions = [];
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

  Future<InstructionsRepo> getInsrtuctionById(
      String? userID, String IngID) async {
    InstructionsRepo? ingredient;
    if (userID != null) {
      final responce = await _firestore
          .collection("DefaultRecipes")
          .doc(userID)
          .collection("Instructions")
          .doc(IngID)
          .get();
      ingredient = InstructionsRepo.fromJson(responce.id, responce.data()!);
    }
    notifyListeners();
    return ingredient!;
  }
}
