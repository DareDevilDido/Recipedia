import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Screens/WelcomePage.dart';
import 'package:provider/provider.dart';
import '../Controllers/UserController.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});
  static const String id = "ProfilePage";

  bool isEditing = true;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserController>(context, listen: false)
          .getUserInfo(kUserId);
    });
    super.initState();
  }

  @override
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String fName = kFirstName;
    String lName = kLastName;
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: kBackGroundColor,
            appBar: AppBar(
              leading: GestureDetector(),
              title: const Text("My Profile"),
              centerTitle: true,
              actions: const [],
              backgroundColor: kPrimaryColor,
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.0),
                          child: Container(
                            color: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0, bottom: 22, left: 18, right: 18),
                              child: Image.asset('images/Person.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Joined on $kDatejoined",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: kContainerColor,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: widget.isEditing
                                        ? ListTile(
                                            title: Text("$fName $lName"),
                                            leading: const Icon(
                                              Icons.person,
                                              size: 40,
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  widget.isEditing = false;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 25,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 260,
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          fName = value;
                                                        },
                                                        decoration: kinputDecoration
                                                            .copyWith(
                                                                hintText:
                                                                    kFirstName),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      width: 260,
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          lName = value;
                                                        },
                                                        decoration:
                                                            kinputDecoration
                                                                .copyWith(
                                                                    hintText:
                                                                        kLastName),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                        child: RoundedButton(
                                                            color: Colors
                                                                .deepOrange,
                                                            text: 'Save',
                                                            onPressed:
                                                                () async {
                                                              await Provider.of<
                                                                          UserController>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .updateUserInfo(
                                                                      kUserId,
                                                                      fName,
                                                                      lName);
                                                              setState(() {
                                                                kFirstName =
                                                                    fName;
                                                                kLastName =
                                                                    lName;

                                                                widget.isEditing =
                                                                    true;
                                                                ScaffoldMessenger
                                                                    .of(context)
                                                                  ..hideCurrentSnackBar()
                                                                  ..showSnackBar(MessagePrompt().snack(
                                                                      "Success",
                                                                      "Username changed",
                                                                      ContentType
                                                                          .success));
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                              ),
                              const Divider(
                                color: Colors.deepOrange,
                                thickness: 1.5,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  child: ListTile(
                                      title: Text(kUserEmail),
                                      leading: const Icon(
                                        Icons.mail,
                                        size: 40,
                                      )),
                                ),
                              ),
                              const Divider(
                                color: Colors.deepOrange,
                                thickness: 1.5,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: RoundedButton(
                                        color: kPrimaryColor,
                                        text: "Change Password",
                                        onPressed: () {
                                          _auth.sendPasswordResetEmail(
                                              email: kUserEmail);
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(MessagePrompt()
                                                .snack(
                                                    "Success",
                                                    "An Email has been sent",
                                                    ContentType.warning));
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: RoundedButton(
                                        color: kPrimaryColor,
                                        text: "Logout",
                                        onPressed: () {
                                          kUserEmail = "";
                                          kDatejoined = "";
                                          kLastName = "";
                                          kFirstName = "";
                                          kUserId = "";
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const WelcomeScreen()));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "© All rights reserved by \n AbdelRahman Mohamed, Amr ElDeeb, AbdelRahman AbdelMageed, Mohamed Ehab 2023",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ))
                ],
              ),
            ),
          );
  }
}
