import 'package:flutter/material.dart';

String kUserId = "sixA0xwbmVW2TF8K7pw04Xg3hzp1";
String kUserEmail = "abdelrahman0213@gmail.com";
String kDatejoined = "19-December-2023";
String kLastName = "Mo";
String kFirstName = "Abdelrahman";
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
