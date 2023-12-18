import 'package:flutter/material.dart';
import 'package:recipedia/Screens/LoginPage.dart';
import 'package:recipedia/Screens/RegisterPage.dart';
import '../Constants/Constants.dart';
import '../Widgets/roundedbutton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  static const String id = "WelcomeScreen";

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: MetaData(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 260.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: TypewriterAnimatedTextKit(
                  speed: const Duration(milliseconds: 100),
                  text: const ["Recipedia"],
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                  color: kButtonColor,
                  text: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
              RoundedButton(
                  color: kButtonColor,
                  text: 'Register',
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
