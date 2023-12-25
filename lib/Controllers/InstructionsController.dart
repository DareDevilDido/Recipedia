import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/instructionsRepo.dart';

class InsrtuctionCntroller extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<instructionsRepo> insrtuctions = [];

  Future<void> getInsrtuctions(String? userID) async {
    if (userID != null) {
      insrtuctions = [];
      final responce = await _firestore
          .collection("recipes")
          .doc(userID)
          .collection("instructions")
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
          .collection("DefaultRecipe")
          .doc(userID)
          .collection("Instructions")
          .doc(IngID)
          .get();
      ingredient = instructionsRepo.fromJson(responce.id, responce.data()!);
    }
    notifyListeners();
    return ingredient!;
  }
}
