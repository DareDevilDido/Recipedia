import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Screens/LoginPage.dart';
import '../Constants/Constants.dart';
import '../Repo/UserRepo.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  static const String id = "RegisterationScreen";

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String userEmail;
  late String userPassword;
  late String firstName;
  late String lastName;
  late String confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 250.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            Text("Register",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 39.0,
                  fontWeight: FontWeight.w900,
                )),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              onChanged: (value) {
                firstName = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "First Name"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                lastName = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Last Name"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                userEmail = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Email"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                userPassword = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Password"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                confirmPassword = value;
              },
              decoration:
                  kinputDecoration.copyWith(hintText: "Confirm password"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              color: kPrimaryColor,
              text: 'Register',
              onPressed: () async {
                if (userEmail != "" &&
                    lastName != "" &&
                    firstName != "" &&
                    userPassword != "" &&
                    confirmPassword != "") {
                  if (userPassword == confirmPassword) {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword);
                      UserRepo(
                        fName: firstName,
                        lName: lastName,
                        email: userEmail,
                      ).addUserToFireStore(newUser.user?.uid ?? "no ID");
                      kUserEmail = userEmail;
                      kUserId = newUser.user!.uid;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          MessagePrompt().snack(
                            "Error",
                            e.toString(),
                            ContentType.failure,
                          ),
                        );
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        MessagePrompt().snack(
                          "Error",
                          "Passwords do not match",
                          ContentType.failure,
                        ),
                      );
                  }
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      MessagePrompt().snack(
                        "Error",
                        "Please fill in all the fields",
                        ContentType.failure,
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
