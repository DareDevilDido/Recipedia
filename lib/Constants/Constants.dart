import 'package:flutter/material.dart';

String kUserId = "VM6eQaWrkaMfOJ4vPIWQWIu2PvP2";
String kUserEmail = "azoz5falak@hotmail.com";
String kDatejoined = "02-December-2022";
String kLastName = "Falak";
String kFirstName = "Abdulaziz";
String kCategory = "All";
Color kPrimaryColor = const Color(0xfffdb51b);
Color kBackGroundColor = const Color(0xfffcf4dc);
Color kButtonColor = Colors.orange;
Color kContainerColor = Colors.orange.shade100;

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
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kinputDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
