import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Widgets/LoadingScreen.dart';
import 'AdminCreateUserPage.dart';
import 'AdminEditUserPage.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({super.key});
  static const String id = "MyRecipesPage";

  @override
  State<AdminUser> createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  @override
  void initState() {
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
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
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: const Icon(Icons.add, color: Colors.white),
                  onTap: () async {
                    bool refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AdminCreateUserPage()));
                    if (refresh) {
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
                          child: Image.asset("images/profile.png",
                              height: 200, width: 200, fit: BoxFit.cover),
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
                                  "${Provider.of<UserController>(context).userList[index].fName} ${Provider.of<UserController>(context).userList[index].lName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                Center(
                                  child: Text(
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
          )
//Padding(
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   child: Column(
          //     children: <Widget>[
          //       Expanded(
          //         child: ListView.builder(
          //             itemCount:
          //                 Provider.of<UserController>(context).userList.length,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(bottom: 8.0),
          //                 child: GestureDetector(
          //                   onTap: () async {
          //                     await Provider.of<UserController>(context,
          //                             listen: false)
          //                         .getUserInfo(Provider.of<UserController>(
          //                                 context,
          //                                 listen: false)
          //                             .userList[index]
          //                             .UID!);
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (_) => AdminEditUserPage(
          //                                   UserId: Provider.of<UserController>(
          //                                           context)
          //                                       .userList[index]
          //                                       .UID!,
          //                                 )));
          //                   },
          //                   child: ListTile(
          //                     leading: Text(Provider.of<UserController>(context)
          //                         .userList[index]
          //                         .email),
          //                   ),
          //                 ),
          //               );
          //             }),
          //       ),
          //     ],
          //   ),
          // ),
          );
}
