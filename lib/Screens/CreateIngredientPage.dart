import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserIngredientsController.dart';
import 'package:recipedia/Widgets/MessagePrompt.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/PickImage.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/roundedbutton.dart';

class CreateIngredientPage extends StatefulWidget {
  const CreateIngredientPage({super.key});
  static const String id = "CreateIngredientPage";

  @override
  State<CreateIngredientPage> createState() => _CreateIngredientPageState();
}

class _CreateIngredientPageState extends State<CreateIngredientPage> {
  @override
  Widget build(BuildContext context) {
    String ingName = "";
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Add Ingredient"),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        if (Provider.of<PickImage>(context).image != null)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<PickImage>(context, listen: false)
                                    .selectFile();
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                    child: Image.file(
                                      File(Provider.of<PickImage>(context)
                                          .image!
                                          .path!),
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(),
                                      Container(
                                        child: RoundedButton(
                                            color: Colors.grey,
                                            text: "Change",
                                            onPressed: () {
                                              Provider.of<PickImage>(context,
                                                      listen: false)
                                                  .selectFile();
                                            }),
                                      ),
                                      Container(),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              Provider.of<PickImage>(context, listen: false)
                                  .selectFile();
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/placeholder.jpg",
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Positioned.fill(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(),
                                    Container(
                                      child: RoundedButton(
                                          color: kButtonColor,
                                          text: "Choose Image",
                                          onPressed: () {
                                            Provider.of<PickImage>(context,
                                                    listen: false)
                                                .selectFile();
                                          }),
                                    ),
                                    Container(),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: TextField(
                            onChanged: (value) {
                              ingName = value;
                            },
                            decoration: kinputDecoration.copyWith(
                                hintText: "Ingredient Name"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RoundedButton(
                                color: kPrimaryColor,
                                text: 'Add',
                                onPressed: () async {
                                  if (Provider.of<PickImage>(context,
                                                  listen: false)
                                              .image !=
                                          null &&
                                      ingName != "") {
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
                                    String image = await Provider.of<PickImage>(
                                            context,
                                            listen: false)
                                        .uploadFile();
                                    await Provider.of<UserIngredientController>(
                                            context,
                                            listen: false)
                                        .AddOriginalIngredient2(ingName, image);
                                    Provider.of<PickImage>(context,
                                            listen: false)
                                        .image = null;
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
                                    Navigator.pop(context, true);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(MessagePrompt().snack(
                                          "Error",
                                          "please add all the required infromation",
                                          ContentType.failure));
                                  }
                                },
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
