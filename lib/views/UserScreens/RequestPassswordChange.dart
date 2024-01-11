import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../../Constants/Constants.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestPasswordChange extends StatefulWidget {
  static const String id = "RequestPasswordChange";
  @override
  _RequestPasswordChange createState() => _RequestPasswordChange();
  const RequestPasswordChange({super.key});
}

class _RequestPasswordChange extends State<RequestPasswordChange> {
  final _auth = FirebaseAuth.instance;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Email"),
            ),
            const SizedBox(
              height: 1.0,
            ),
            Column(
              children: [
                Container(),
                RoundedButton(
                    color: kButtonColor,
                    text: 'Send Mail',
                    onPressed: () async {
                      try {
                        _auth.sendPasswordResetEmail(email: email);
                        Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(MessagePrompt().snack("Error",
                              "Please enter an email", ContentType.failure));
                      }
                    }),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
