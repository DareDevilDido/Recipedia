import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserIngredientsController.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import '../../Unique classes/PickImage.dart';
import '../../Models/Repo/DefaultIngredientsRepo.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/roundedbutton.dart';

class EditIngredientPage extends StatefulWidget {
  String RecipeId;
  EditIngredientPage({super.key, required this.RecipeId});
  static const String id = "EditIngredientPage";

  @override
  State<EditIngredientPage> createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  DefaultIngredientsRepo? ing;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      ing = await Provider.of<UserIngredientController>(context, listen: false)
          .getIngredientById(kUserId, widget.RecipeId);
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Provider.of<Loading>(context,
              listen: true)
          .kIsLoading
      ? const LoadingScreen()
      : Scaffold(
          backgroundColor: kBackGroundColor,
          appBar: AppBar(
            title: const Text("Edit ingredient"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                                            color: kButtonColor,
                                            text: "Change Image",
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
                                  child: Image.network(
                                    ing!.image,
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
                                          text: "Change Image",
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
                          height: 15.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            ing!.Name = value;
                          },
                          decoration:
                              kinputDecoration.copyWith(hintText: ing!.Name),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RoundedButton(
                                      color: Colors.red,
                                      text: 'Delete',
                                      onPressed: () async {
                                        await Provider.of<
                                                    UserIngredientController>(
                                                context,
                                                listen: false)
                                            .DeleteOriginalIngredient(
                                                widget.RecipeId);
                                        // Navigator.pushNamed(context, LoginScreen.id);
                                        Provider.of<PickImage>(context,
                                                listen: false)
                                            .image = null;
                                        await Provider.of<
                                                    UserIngredientController>(
                                                context,
                                                listen: false)
                                            .getIngredients(kUserId);
                                        Navigator.pop(context, true);
                                      }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RoundedButton(
                                      color: kPrimaryColor,
                                      text: 'Done',
                                      onPressed: () async {
                                        if (Provider.of<PickImage>(context,
                                                    listen: false)
                                                .image !=
                                            null) {
                                          String Image =
                                              await Provider.of<PickImage>(
                                                      context,
                                                      listen: false)
                                                  .uploadRecipeFile();
                                          ing!.image = Image;
                                        }
                                        Provider.of<Loading>(context,
                                                listen: false)
                                            .changeBool();
                                        await Provider.of<
                                                    UserIngredientController>(
                                                context,
                                                listen: false)
                                            .EditOriginalIngredient(
                                                ing!, widget.RecipeId);
                                        // Navigator.pushNamed(context, LoginScreen.id);
                                        Provider.of<PickImage>(context,
                                                listen: false)
                                            .image = null;
                                        await Provider.of<
                                                    UserIngredientController>(
                                                context,
                                                listen: false)
                                            .getIngredients(kUserId);
                                        Provider.of<Loading>(context,
                                                listen: false)
                                            .changeBool();
                                        Navigator.pop(context, true);
                                        // Navigator.pushNamed(context, LoginScreen.id);
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
}
