import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Widgets/roundedbutton.dart';

class AdminEditUserPage extends StatefulWidget {
  String UserId;
  AdminEditUserPage({super.key, required this.UserId});
  static const String id = "AdminEditUserPage";

  @override
  State<AdminEditUserPage> createState() => _AdminEditUserPageState();
}

class _AdminEditUserPageState extends State<AdminEditUserPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserController>(context, listen: false)
          .getUserInfo(widget.UserId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fName =
        Provider.of<UserController>(context, listen: false).userInfo!.fName;
    String lName =
        Provider.of<UserController>(context, listen: false).userInfo!.lName;
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
            ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
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
                  TextField(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                            color: kPrimaryColor,
                            text: 'Edit',
                            onPressed: () async {
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .updateUserInfo(widget.UserId, fName, lName);
                              Navigator.pop(context, true);
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
