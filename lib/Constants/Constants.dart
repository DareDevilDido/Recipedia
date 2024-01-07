import 'package:flutter/material.dart';

String kUserId = "";
String kUserEmail = "";
String kDatejoined = "";
String kLastName = "";
String kFirstName = "";
String kCategory = "";
Color kPrimaryColor = Color.fromARGB(255, 217, 126, 150);
Color kBackGroundColor = Color.fromARGB(255, 255, 255, 255);
Color kButtonColor = const Color.fromARGB(255, 217, 126, 150);
Color kContainerColor = const Color.fromARGB(255, 217, 217, 217);


class Loading extends ChangeNotifier {
  bool kIsLoading = false;
  String kCategory = "All";
  void changeBool() {
    kIsLoading = !kIsLoading;
    notifyListeners();
  }
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color.fromARGB(255, 255, 220, 64), width: 2.0),
  ),
);

const kinputDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 163, 101, 132), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 163, 101, 132), width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
