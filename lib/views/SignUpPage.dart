import 'package:flutter/material.dart';

import 'SignInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                ),
              ),
              const Text(
                'Let’s help you set up your account, it won’t take long.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 14), // Smaller text size
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:0),
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
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 14), // Smaller text size
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: Text(
                      'password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 14), // Smaller text size
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:0),
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 14), // Smaller text size
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Retype your password',
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
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
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                },
                child: const Text(
                  "Already a member? Sign in",
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
