// import 'package:flutter/material.dart';
// import 'package:recipedia/Constants/Constants.dart';
// import 'package:recipedia/Controllers/UserIngredientsController.dart';
// import 'package:provider/provider.dart';
// import '../Widgets/LoadingScreen.dart';

// class AdminProfilePagePage extends StatefulWidget {
//   static const String id = "IngredientsPage";

//   const AdminProfilePagePage({super.key});

//   @override
//   State<AdminProfilePagePage> createState() => _AdminProfilePagePageState();
// }

// class _AdminProfilePagePageState extends State<AdminProfilePagePage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero).then((_) async {
//       setState(() {
//         Provider.of<Loading>(context, listen: false).changeBool();
//       });
//       await Provider.of<UserIngredientController>(context, listen: false)
//           .getAdminProfilePage(kUserId);
//       setState(() {
//         Provider.of<Loading>(context, listen: false).changeBool();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Provider.of<Loading>(context,
//               listen: true)
//           .kIsLoading
//       ? const LoadingScreen()
//       : Scaffold(
//           backgroundColor: kBackGroundColor,
//           appBar: AppBar(
//             leading: GestureDetector(),
//             title: const Text("Top 10 Ingredients Page"),
//             centerTitle: true,
//             backgroundColor: kPrimaryColor,
//           ),
//           body: GridView.builder(
//               gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//               itemCount: (Provider.of<UserIngredientController>(context)
//                           .ingredients
//                           .length <
//                       10)
//                   ? Provider.of<UserIngredientController>(context)
//                       .ingredients
//                       .length
//                   : 10,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: Stack(children: [
//                       Image.network(
//                           Provider.of<UserIngredientController>(context)
//                               .ingredients[index]
//                               .image,
//                           height: 200,
//                           width: 200,
//                           fit: BoxFit.cover),
//                       Positioned.fill(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                       bottomRight: Radius.circular(10.0)),
//                                   child: Container(
//                                     color: kButtonColor,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: Text(
//                                         "No.${index + 1}",
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 20),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container()
//                               ],
//                             ),
//                             Container(),
//                             Container(
//                               height: 45,
//                               color: Colors.black.withOpacity(0.5),
//                               alignment: Alignment.center,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         Provider.of<UserIngredientController>(
//                                                 context)
//                                             .ingredients[index]
//                                             .Name,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "${Provider.of<UserIngredientController>(context).ingredients[index].timesused} ",
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18,
//                                                 color: Colors.white),
//                                           ),
//                                           Icon(
//                                             Icons.rice_bowl_sharp,
//                                             color: kButtonColor,
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]),
//                   ),
//                 );
//               })
//           //
//           // Padding(
//           //   padding: const EdgeInsets.all(20.0),
//           //   child: Column(
//           //     children: <Widget>[
//           //       Row(
//           //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //         children: [
//           //           Text("Image"),
//           //           Text("Name"),
//           //           Text(" "),
//           //           Text(" "),
//           //           Text(" "),
//           //           Text(" "),
//           //           Text(" "),
//           //           Text("Times Used"),
//           //         ],
//           //       ),
//           //       Expanded(
//           //         child: ListView.builder(
//           //             itemCount: (Provider.of<UserIngredientController>(context)
//           //                         .ingredients
//           //                         .length <
//           //                     10)
//           //                 ? Provider.of<UserIngredientController>(context)
//           //                     .ingredients
//           //                     .length
//           //                 : 10,
//           //             itemBuilder: (context, index) {
//           //               return Padding(
//           //                 padding: const EdgeInsets.only(bottom: 8.0),
//           //                 child: ListTile(
//           //                   trailing: Text(
//           //                       Provider.of<UserIngredientController>(context)
//           //                           .ingredients[index]
//           //                           .timesused),
//           //                   leading: Image.network(
//           //                     Provider.of<UserIngredientController>(context)
//           //                         .ingredients[index]
//           //                         .image,
//           //                     height: 50,
//           //                     width: 50,
//           //                   ),
//           //                   title: Text(
//           //                       Provider.of<UserIngredientController>(context)
//           //                           .ingredients[index]
//           //                           .Name),
//           //                 ),
//           //               );
//           //             }),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           );
// }

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

class AdminProfilePage extends StatefulWidget {
  AdminProfilePage({super.key});
  static const String id = "AdminProfilePage";

  bool isEditing = true;
  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
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
                        
                      ))
                ],
              ),
            ),
          );
  }
}
