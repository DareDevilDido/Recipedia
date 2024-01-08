import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../../Constants/Constants.dart';
import '../../Models/Repo/UserRepo.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

// StatefulWidget for creating a new user by an admin
class AdminCreateUserPage extends StatefulWidget {
  @override
  static const String id = "AdminCreateUserPage";

  const AdminCreateUserPage({super.key});

  @override
  _AdminCreateUserPageState createState() => _AdminCreateUserPageState();
}

// State class for AdminCreateUserPage
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
            // Input field for user email
            TextField(
              onChanged: (value) {
                // Store user input in userEmail variable
                userEmail = value;
              },
              decoration:
                  kinputDecoration.copyWith(hintText: "Enter your Email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Input field for user password
            TextField(
              obscureText: true,
              onChanged: (value) {
                // Store user input in userPassword variable
                userPassword = value;
              },
              decoration:
                  kinputDecoration.copyWith(hintText: "Enter your password"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Input fields for first and last name
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      // Store user input in firstName variable
                      firstName = value;
                    },
                    decoration:
                        kinputDecoration.copyWith(hintText: "First Name"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      // Store user input in lastName variable
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
            // Button for user registration
            RoundedButton(
                color: kPrimaryColor,
                text: 'Register',
                onPressed: () async {
                  try {
                    // Check if all fields are filled
                    if (userEmail != "" &&
                        lastName != "" &&
                        firstName != "" &&
                        userPassword != "") {
                      // Create a new user using Firebase authentication
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword);
                      // Add user information to Firestore
                      UserRepo(
                              fName: firstName,
                              lName: lastName,
                              email: userEmail)
                          .addUserToFireStore(newUser.user?.uid ?? "no ID");
                      // Navigate back to the previous screen
                      Navigator.pop(context, true);
                    } else {
                      // Display an error message if any field is empty
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(MessagePrompt().snack(
                            "Error",
                            "Please fill in all the fields",
                            ContentType.failure));
                    }
                  } catch (e) {
                    // Display an error message if an exception occurs
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
