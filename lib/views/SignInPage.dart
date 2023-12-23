import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_widget/views/NavigationsBar.dart';
import 'SignUpPage.dart';

class SignInPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInPage({super.key});

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Navigate to the home screen after successful sign-in
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavigationsBar()),
        );
      }
    } catch (e) {
      print('Failed to sign in: $e');
      // Handle sign-in failure here (show error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Hello, Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: emailController,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      'Enter password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Add functionality for forgot password action
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFFFF9C00),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty) {
                    signInWithEmailAndPassword(email, password, context);
                  } else {
                    // Handle empty email or password here
                    print('Email and password cannot be empty');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF496886),
                  minimumSize: const Size(500, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign In ->',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        onPressed: () {
                          // Add functionality for Google sign-in
                        },
                        icon: Image.asset('assets/google_icon.png'),
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        onPressed: () {
                          // Add functionality for Facebook sign-in
                        },
                        icon: Image.asset('assets/facebook_icon.png'),
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Color(0xFFFF9C00),
                  ),
                ),
              ),
              const SizedBox(height: 50), // Additional spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
