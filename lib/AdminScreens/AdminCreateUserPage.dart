import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../Constants/Constants.dart';
import '../Repo/UserRepo.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminCreateUserPage extends StatefulWidget {
  @override
  static const String id = "AdminCreateUserPage";

  const AdminCreateUserPage({super.key});
  @override
  _AdminCreateUserPageState createState() => _AdminCreateUserPageState();
}

class _AdminCreateUserPageState extends State<AdminCreateUserPage> {
  final _auth = FirebaseAuth.instance;
  late String userEmail;
  late String userPassword;
  late String firstName;
  late String lastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                userEmail = value;
              },
              decoration:
                  kinputDecoration.copyWith(hintText: "Enter your Email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                userPassword = value;
              },
              decoration:
                  kinputDecoration.copyWith(hintText: "Enter your password"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration:
                        kinputDecoration.copyWith(hintText: "First Name"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration:
                        kinputDecoration.copyWith(hintText: "Last Name"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: kPrimaryColor,
                text: 'Register',
                onPressed: () async {
                  try {
                    if (userEmail != "" &&
                        lastName != "" &&
                        firstName != "" &&
                        userPassword != "") {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword);
                      UserRepo(
                              fName: firstName,
                              lName: lastName,
                              email: userEmail)
                          .addUserToFireStore(newUser.user?.uid ?? "no ID");
                      Navigator.pop(context, true);
                                        } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(MessagePrompt().snack(
                            "Error",
                            "Please fill in all the fields",
                            ContentType.failure));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(MessagePrompt()
                          .snack("Error", e.toString(), ContentType.failure));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
