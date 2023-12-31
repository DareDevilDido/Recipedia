import 'package:flutter/cupertino.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipedia/Repo/UserRepo.dart';

class UserController extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<UserRepo> userList = [];
  UserRepo? userInfo;

  Future<UserRepo> getUserInfo(String? userID) async {
    if (userID != null) {
      final responce =
          await _firestore.collection("UserInformation").doc(userID).get();
      userInfo = UserRepo.fromJson(responce.id, responce.data()!);
      notifyListeners();
    }
    notifyListeners();
    return userInfo!;
  }

  Future<void> getAllUserInfo() async {
    userList = [];
    final responce = await _firestore.collection("UserInformation").get();
    Future.forEach(responce.docs, (User) async {
      userList.add(UserRepo.fromJson(User.id, User.data()));
      notifyListeners();
    });
    notifyListeners();
  }
  
//if (UserInfo.Role == "User")
  Future<void> updateUserInfo(
      String? userID, String firstName, String lastName) async {
    if (userID != null) {
      final responce =
          _firestore.collection("UserInformation").doc(userID);

      responce.update({"First Name": firstName, "Last Name": lastName});
      //userInfo = UserRepo.fromJson(responce.id, responce.data()!);
      if (userID == kUserId) {
        kFirstName = firstName;
        kLastName = lastName;
      }
      notifyListeners();
    }
    notifyListeners();
  }
  Future<void> deleteUserInfo(String? userID) async {
  if (userID != null) {
    final responce = _firestore.collection("UserInformation").doc(userID);
    await responce.delete();
    
    notifyListeners();
  }
  notifyListeners();
}

}
