
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserController.dart';
import 'package:recipedia/Repo/UserRepo.dart';
import 'package:recipedia/Screens/RequestPassswordChange.dart';
import 'package:recipedia/Widgets/MessagePrompt.dart';
import 'package:recipedia/Widgets/adminNavigationBar.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/RandomRecipeOfTheDay.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text("Recipedia",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                )),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Email"),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                pass = value;
              },
              decoration: kinputDecoration.copyWith(hintText: "Password"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            RoundedButton(
                color: kButtonColor,
                text: 'Login',
                onPressed: () async {
                  try {
                    if (email != "" && pass != "") {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: pass);
                      kUserEmail = email;
                      kUserId = user.user!.uid;
                      UserRepo UserInfo =
                          await UserController().getUserInfo(kUserId);
                      kFirstName = UserInfo.fName;
                      kLastName = UserInfo.lName;
                      kDatejoined = UserInfo.dateJoined!;
                      if (UserInfo.Role == "User") {
                        await Provider.of<RandomRecipeOfTheDay>(context,
                                listen: false)
                            .getRandomRecipe();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationsBar()));
                        print("object");
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const adminNavigationsBar()));
                      }
                                        } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(MessagePrompt().snack(
                            "Error",
                            "Please enter your email and password",
                            ContentType.failure));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(MessagePrompt()
                          .snack("Error", e.toString(), ContentType.failure));
                  }
                }),
            Center(
                child: GestureDetector(
              child: const Text(
                "Forget Password?",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              onTap: () {
                Navigator.pushNamed(context, RequestPasswordChange.id);
              },
            ))
          ],
        ),
      ),
    );
  }
}
