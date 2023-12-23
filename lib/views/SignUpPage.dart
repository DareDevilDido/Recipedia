import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignInPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      
      String userId = userCredential.user!.uid;
      print('User ID: $userId');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SignInPage()),
      );
    } catch (e) {
      print('Failed to create user: $e');
      // You can show an error message here using a snackbar or dialog
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
                'Create an account!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Let’s help you set up your account, it won’t take long.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Changed text color to black
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
                        hintText: 'Enter your Email',
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
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Changed text color to black
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  
                  if (email.isNotEmpty && password.isNotEmpty) {
                    signUpWithEmailAndPassword(email, password, context);
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
                  'Sign Up ->',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              // ... rest of your UI code
            ],
          ),
        ),
      ),
    );
  }
}
