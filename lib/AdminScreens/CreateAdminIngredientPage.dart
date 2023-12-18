import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/AdminIngredientController.dart';
import 'package:recipedia/Widgets/MessagePrompt.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/PickImage.dart';
import '../Widgets/roundedbutton.dart';

class CreateAdminIngredientPage extends StatelessWidget {
  const CreateAdminIngredientPage({super.key});
  static const String id = "CreateAdminIngredientPage";

  @override
  Widget build(BuildContext context) {
    String ingName = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Ingredient"),
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
                    ingName = value;
                  },
                  decoration:
                      kinputDecoration.copyWith(hintText: "Ingredient Name"),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    if (Provider.of<PickImage>(context).image != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.file(File(
                                Provider.of<PickImage>(context).image!.path!)),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: Image.asset(
                            "images/placeholder.jpg",
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          color: kButtonColor,
                          text: 'Pick Image',
                          onPressed: () {
                            Provider.of<PickImage>(context, listen: false)
                                .selectFile();
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedButton(
                    color: kPrimaryColor,
                    text: 'Save',
                    onPressed: () async {
                      if (Provider.of<PickImage>(context, listen: false)
                                  .image !=
                              null &&
                          ingName != "") {
                        String image =
                            await Provider.of<PickImage>(context, listen: false)
                                .uploadFile();
                        await Provider.of<AdminIngredientController>(context,
                                listen: false)
                            .AddIngredient2(kUserId, ingName, image);
                        Provider.of<PickImage>(context, listen: false).image =
                            null;
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
