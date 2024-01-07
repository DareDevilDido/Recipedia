import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserController.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import '../UserScreens/WelcomePage.dart';
import '../Widgets/roundedbutton.dart';

// StatefulWidget for editing user information by an admin
class AdminEditUserPage extends StatefulWidget {
  final String UserId;

  // Constructor to receive the user ID to edit
  const AdminEditUserPage({super.key, required this.UserId});

  // Static constant for the route identifier
  static const String id = "AdminEditUserPage";

  @override
  State<AdminEditUserPage> createState() => _AdminEditUserPageState();
}

// State class for AdminEditUserPage
class _AdminEditUserPageState extends State<AdminEditUserPage> {
  @override
  void initState() {
    // Load user information when the widget is initialized
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserController>(context, listen: false)
          .getUserInfo(widget.UserId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve user information from the UserController
    String fName =
        Provider.of<UserController>(context, listen: false).userInfo!.fName;
    String lName =
        Provider.of<UserController>(context, listen: false).userInfo!.lName;
String email=Provider.of<UserController>(context, listen: false).userInfo!.email;
String dateJoined=Provider.of<UserController>(context, listen: false).userInfo!.dateJoined!.toString();
String Role=Provider.of<UserController>(context, listen: false).userInfo!.Role!.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            // ListView for displaying user information
            ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const SizedBox(
                    height: 8.0,
                  ),
                  // Text field for editing first name
                  TextField(
                    enabled: false,
                    onChanged: (value) {
                      fName = value;
                    },
                    decoration: kinputDecoration.copyWith(
                        hintText:
                            Provider.of<UserController>(context, listen: false)
                                .userInfo!
                                .fName),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  // Text field for editing last name
                  TextField(
                    enabled: false,
                    onChanged: (value) {
                      lName = value;
                    },
                    decoration: kinputDecoration.copyWith(
                        hintText:
                            Provider.of<UserController>(context, listen: false)
                                .userInfo!
                                .lName),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  // Text field for editing first name
                  TextField(
                    enabled: false,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kinputDecoration.copyWith(
                        hintText:
                            Provider.of<UserController>(context, listen: false)
                                .userInfo!
                                .email),
                  ),
                   const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  // Text field for editing first name
                  TextField(
                    enabled: false,
                    onChanged: (value) {
                      dateJoined = value;
                    },
                    decoration: kinputDecoration.copyWith(
                        hintText:
                            Provider.of<UserController>(context, listen: false)
                                .userInfo!
                                .dateJoined),
                  ),
                    const SizedBox(
                    height: 8.0,
                  ),
                  // Text field for editing first name
                  TextField(
                    enabled: false,
                    onChanged: (value) {
                      Role = value;
                    },
                    decoration: kinputDecoration.copyWith(
                        hintText:
                            Provider.of<UserController>(context, listen: false)
                                .userInfo!
                                .Role),
                  ),
                  // Button for updating user information
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                            color: kPrimaryColor,
                            text: 'Delete User',
                            onPressed: () async {
                              if(email==kUserEmail)
                              {Provider.of<UserController>(context,
                                      listen: false)
                                  .deleteUserInfo(widget.UserId);
                              // Navigate back to the previous screen
                              Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const WelcomeScreen()));

                              }
                              else{
                              // Call the UserController to update user info
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .deleteUserInfo(widget.UserId);
                              // Navigate back to the previous screen
                              Navigator.pop(context, true);
                              }
                            })
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
