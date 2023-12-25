import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserRepo.dart';
import '../constantVariables/Constant.dart';

class UserController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<UserRepo> userList = [];
  UserRepo? userInfo;

  Future<UserRepo> getUserInfo(String? userID) async {
    if (userID != null) {
      final responce =
          await _firestore.collection("users").doc(userID).get();
      userInfo = UserRepo.fromJson(responce.id, responce.data()!);
      notifyListeners();
    }
    notifyListeners();
    return userInfo!;
  }

  Future<void> getAllUserInfo() async {
    userList = [];
    final responce = await _firestore.collection("users").get();
    Future.forEach(responce.docs, (User) async {
      userList.add(UserRepo.fromJson(User.id, User.data()));
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> updateUserInfo(
      String? userID, String Name) async {
    if (userID != null) {
      final responce =
          _firestore.collection("users").doc(userID);

      responce.update({"name":Name});
      //userInfo = UserRepo.fromJson(responce.id, responce.data()!);
      if (userID == kUserId) {
        name = Name;
        
      }
      notifyListeners();
    }
    notifyListeners();
  }
}
