// Import statements for necessary packages and project files
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserController.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import '../Widgets/LoadingScreen.dart';
import 'AdminCreateUserPage.dart';
import 'AdminEditUserPage.dart';

// StatefulWidget for managing users in the admin view
class AdminUser extends StatefulWidget {
  const AdminUser({super.key});

  // Static constant for the route identifier
  static const String id = "MyRecipesPage";

  @override
  State<AdminUser> createState() => _AdminUserState();
}

// State class for AdminUser
class _AdminUserState extends State<AdminUser> {
  @override
  void initState() {
    // Initialize the state and load user information when the widget is initialized
    super.initState();
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });

    // Delayed execution to ensure the UI is built before loading user information
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserController>(context, listen: false)
          .getAllUserInfo();
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
  }

  @override
  Widget build(BuildContext context) => Provider.of<Loading>(context,
              listen: true)
          .kIsLoading
      ? const LoadingScreen()
      : Scaffold(
          backgroundColor: kBackGroundColor,
          appBar: AppBar(
            title: const Text("Users"),
            leading: GestureDetector(),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            actions: [
              // Add button to navigate to the page for creating a new user
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: const Icon(Icons.add, color: Colors.white),
                  onTap: () async {
                    // Navigate to the page for creating a new user
                    bool refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AdminCreateUserPage()));
                    if (refresh) {
                      // Refresh the list of users after creating a new user
                      await Provider.of<UserController>(context, listen: false)
                          .getAllUserInfo();
                    }
                  },
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Provider.of<UserController>(context).userList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // Get detailed information of the selected user and navigate to edit page
                      await Provider.of<UserController>(context, listen: false)
                          .getUserInfo(Provider.of<UserController>(context,
                                  listen: false)
                              .userList[index]
                              .UID!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AdminEditUserPage(
                                    UserId: Provider.of<UserController>(context)
                                        .userList[index]
                                        .UID!,
                                  )));
                    },
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                              "images/profile.png", // Placeholder image
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 65,
                            color: Colors.black.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // Display user's full name
                                  "${Provider.of<UserController>(context).userList[index].fName} ${Provider.of<UserController>(context).userList[index].lName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                Center(
                                  child: Text(
                                    // Display user's email
                                    Provider.of<UserController>(context)
                                        .userList[index]
                                        .email,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                }),
          ));
}
