import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:intl/intl.dart';

class UserRepo {
  String? UID;
  String email;
  String fName;
  String lName;
  String? dateJoined;
  String? Role;

  UserRepo(
      {required this.fName,
      required this.lName,
      required this.email,
      this.dateJoined,
      this.Role,
      this.UID});

  final _db = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  Future<void> addUserToFireStore(String UserID) async {
    try {
      kUserId = UserID;
      await _db.collection('UserInformation').doc(UserID).set({
        "First Name": fName,
        "Last Name": lName,
        "Joined on": DateFormat("dd-MMMM-yyyy").format(DateTime.now()),
        "Email": email,
        "Role": "User",
        "ROTD Link": "",
        "ROTD Type": ""
      });
    } catch (e) {}
  }

  static UserRepo fromJson(String notId, Map<String, dynamic> data) {
    return UserRepo(
        fName: data["First Name"].toString(),
        lName: data["Last Name"].toString(),
        dateJoined: data["Joined on"].toString(),
        email: data["Email"],
        Role: data["Role"],
        UID: notId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["First Name"] = fName;
    data["Last Name"] = lName;
    data["Joined on"] = dateJoined;
    data["Email"] = email;
    return data;
  }
}
