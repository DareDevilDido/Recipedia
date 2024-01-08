import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserRecipesController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/UserIngredientsController.dart';
import '../Controllers/UserInstructionsController.dart';
import '../Controllers/UserRecipeIngredientController.dart';
import '../Models/PickImage.dart';
import '../Models/Recipe.dart';
import '../Repo/InstructionRepo.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';

class CreateRecipePage extends StatefulWidget {
  static const String id = "CreateRecipePage";

  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  String name = "";
  String Category = "";
  String Servings = "";
  String time = "";
  String nutrition = "";
  String description = "";
  String VideoLink = "";
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserIngredientController>(context, listen: false)
          .getIngredients(kUserId);
    });

    Provider.of<Recipe>(context, listen: false).insrtuctions = [];
    Provider.of<Recipe>(context, listen: false).ingredientID = [];
    Provider.of<Recipe>(context, listen: false).ingredients = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: kBackGroundColor,
            appBar: AppBar(
              title: Text(
                "Create Recipe",
                style: TextStyle(color: kTextColor),
              ),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView(
                children: <Widget>[
                  Column(children: <Widget>[
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                              ),
                              Positioned.fill(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(),
                                  Container(
                                    child: Container(
                                      height: 65,
                                      color: Colors.black.withOpacity(0.5),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Edit Photo",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
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
                                width: MediaQuery.of(context).size.width * 0.95,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned.fill(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(),
                                Container(
                                  child: Container(
                                    height: 65,
                                    color: Colors.black.withOpacity(0.5),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Add Photo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(),
                              ],
                            ))
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      style: TextStyle(color: kTextColor),
                      onChanged: (value) {
                        name = value;
                      },
                      decoration:
                          kinputDecoration.copyWith(hintText: "Recipe Name"),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                style: TextStyle(color: kTextColor),
                                onChanged: (value) {
                                  nutrition = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: "Calories"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                style: TextStyle(color: kTextColor),
                                onChanged: (value) {
                                  VideoLink = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: "Video Link"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                style: TextStyle(color: kTextColor),
                                onChanged: (value) {
                                  time = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: "Cook Time"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 20, right: 10),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                  color: Colors.white,
                                  child: DropdownButton<String>(
                                    items: <String>[
                                      'Dinner',
                                      'Lunch',
                                      'BreakFast',
                                      'Dessert'
                                    ]
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                    onChanged: (NewValue) {
                                      setState(() {
                                        Category = NewValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                style: TextStyle(color: kTextColor),
                                onChanged: (value) {
                                  Servings = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: "Servings"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const LineDivider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "ingredients",
                            style: TextStyle(color: kTextColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              color: Colors.white,
                              height: 30,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: DropdownButton<int>(
                                  items: Provider.of<UserIngredientController>(
                                          context)
                                      .ingredients
                                      .map((item) => DropdownMenuItem<int>(
                                            value: Provider.of<
                                                        UserIngredientController>(
                                                    context)
                                                .ingredients
                                                .indexOf(item),
                                            child: Text(item.Name),
                                          ))
                                      .toList(),
                                  onChanged: (Select) {
                                    setState(() {
                                      var index = Provider.of<
                                                  UserIngredientController>(
                                              context,
                                              listen: false)
                                          .ingredients
                                          .where((item) => item.Name == Select);
                                      Provider.of<Recipe>(context,
                                              listen: false)
                                          .addIngredientToList(
                                              Provider.of<UserIngredientController>(
                                                      context,
                                                      listen: false)
                                                  .ingredients[Select!],
                                              Provider.of<UserIngredientController>(
                                                      context,
                                                      listen: false)
                                                  .ingredientID[Select]);
                                    });
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    (Provider.of<Recipe>(context).ingredients.isNotEmpty)
                        ? SizedBox(
                            height: 130,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Provider.of<Recipe>(context)
                                    .ingredients
                                    .length,
                                itemBuilder: (context, index) {
                                  return Column(children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 10),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                            Provider.of<Recipe>(context)
                                                .ingredients[index]
                                                .image,
                                            height: 75,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 5),
                                      child: GestureDetector(
                                        child: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onTap: () {
                                          Provider.of<Recipe>(context,
                                                  listen: false)
                                              .removeIngrecientFromList(index);
                                          // Navigator.pushNamed(context, SearchPage.id);
                                        },
                                      ),
                                    )
                                  ]);
                                }),
                          )
                        : Container(),
                    const LineDivider(),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Instructions",
                            style: TextStyle(color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    (Provider.of<Recipe>(context).insrtuctions.isNotEmpty)
                        ? SizedBox(
                            height: 200,
                            child: ListView.builder(
                                itemCount: Provider.of<Recipe>(context)
                                    .insrtuctions
                                    .length,
                                itemBuilder: (context, index) {
                                  Provider.of<Recipe>(context)
                                      .insrtuctions[index]
                                      .Step = (index + 1).toString();
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              color: kContainerColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                    "Step ${Provider.of<Recipe>(context).insrtuctions[index].Step} :${Provider.of<Recipe>(context).insrtuctions[index].Description}"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: GestureDetector(
                                          child: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onTap: () {
                                            Provider.of<Recipe>(context,
                                                    listen: false)
                                                .removeInstructionsToList(
                                                    index);
                                            // Navigator.pushNamed(context, SearchPage.id);
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          )
                        : Container(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                      child: TextField(
                        style: TextStyle(color: kTextColor),
                        onChanged: (value) {
                          description = value;
                        },
                        minLines: 4,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: kinputDecoration.copyWith(
                            hintText: "Instruction Body"),
                      ),
                    ),
                    const LineDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: RoundedButton(
                                color: kPrimaryColor,
                                text: 'Save',
                                onPressed: () async {
                                  if (name != "" &&
                                      Category != "" &&
                                      nutrition != "" &&
                                      time != "" &&
                                      Servings != "" &&
                                      name != "" &&
                                      VideoLink != "" &&
                                      Provider.of<PickImage>(context,
                                                  listen: false)
                                              .image !=
                                          null &&
                                      Provider.of<Recipe>(context,
                                                  listen: false)
                                              .insrtuctions !=
                                          [] &&
                                      Provider.of<Recipe>(context,
                                                  listen: false)
                                              .ingredients !=
                                          [] &&
                                      Provider.of<Recipe>(context,
                                                  listen: false)
                                              .ingredientID !=
                                          []) {
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
                                    String Image = await Provider.of<PickImage>(
                                            context,
                                            listen: false)
                                        .uploadRecipeFile();
                                    String ID = await Provider.of<
                                                UserRecipesController>(context,
                                            listen: false)
                                        .AddRecipe(name, Category, nutrition,
                                            time, Servings, Image, VideoLink);

                                    Future.forEach(
                                        Provider.of<Recipe>(context,
                                                listen: false)
                                            .insrtuctions, (insrtuction) async {
                                      await Provider.of<
                                                  UserInsrtuctionCntroller>(
                                              context,
                                              listen: false)
                                          .AddInstruction(ID, insrtuction);
                                    });
                                    Future.forEach(
                                        Provider.of<Recipe>(context,
                                                listen: false)
                                            .ingredientID, (ingIDs) async {
                                      await Provider.of<
                                                  UserRecipeIngredientController>(
                                              context,
                                              listen: false)
                                          .AddIngredient(ID, ingIDs);
                                    });
                                    Provider.of<PickImage>(context,
                                            listen: false)
                                        .image = null;
                                    Provider.of<Recipe>(context, listen: false)
                                        .insrtuctions = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredientID = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredients = [];
                                    Navigator.pop(context, true);
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(MessagePrompt().snack(
                                          "Error",
                                          "Please fill all the requirments",
                                          ContentType.failure));
                                  }
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: RoundedButton(
                                color: kPrimaryColor,
                                text: 'Add Instruction',
                                onPressed: () {
                                  if (description != "") {
                                    var instruction = InstructionsRepo(
                                        ID: "",
                                        Description: description,
                                        Step: (Provider.of<Recipe>(context,
                                                        listen: false)
                                                    .insrtuctions
                                                    .length +
                                                1)
                                            .toString());
                                    Provider.of<Recipe>(context, listen: false)
                                        .addInstructionsToList(instruction);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(MessagePrompt().snack(
                                          "Error",
                                          "Instruction is empty",
                                          ContentType.failure));
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
          );
  }
}