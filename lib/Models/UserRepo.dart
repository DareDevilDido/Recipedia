import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserRepo {
  String? UID;
  String email;
  String Name;
  String? Role;

  UserRepo(
      {required this.Name,
      required this.email,
      this.Role,
      this.UID});

  final _db = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  Future<void> addUserToFireStore(String UserID) async {
    try {
      var kUserId = UserID;
      await _db.collection('UserInformation').doc(UserID).set({
        "name": Name,
        "email": email,
        "role": "User",
        "ROTD Link": "",
        "ROTD Type": ""
        
      });
    } catch (e) {}
  }

  static UserRepo fromJson(String notId, Map<String, dynamic> data) {
    return UserRepo(
        Name: data["name"].toString(),
        email: data["email"],
        Role: data["role"],
        UID: notId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = Name;
    data["email"] = email;
    
    return data;
  }
}
