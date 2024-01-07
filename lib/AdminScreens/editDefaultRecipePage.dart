import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/AdminIngredientController.dart';
import 'package:recipedia/Controllers/AdminInstructionController.dart';
import 'package:recipedia/Models/Recipe.dart';
import 'package:recipedia/Widgets/MessagePrompt.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/AdminRecipecontroller.dart';
import '../Models/PickImage.dart';
import '../Repo/InstructionRepo.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/adminNavigationBar.dart';
import '../Widgets/roundedbutton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class editDefaultRecipePage extends StatefulWidget {
  static const String id = "editDefaultRecipePage";
  String RecipeId;
  editDefaultRecipePage({super.key, required this.RecipeId});
  @override
  State<editDefaultRecipePage> createState() => _editDefaultRecipePageState();
}

class _editDefaultRecipePageState extends State<editDefaultRecipePage> {
 String description = "";
  @override
  void initState() {
    Provider.of<Loading>(context, listen: false).changeBool();
    Future.delayed(Duration.zero).then((_) async {
      Provider.of<Recipe>(context, listen: false).insrtuctions = [];
      Provider.of<Recipe>(context, listen: false).ingredientID = [];
      Provider.of<Recipe>(context, listen: false).ingredients = [];
      Provider.of<PickImage>(context, listen: false).image = null;
      await Provider.of<AdminRecipesController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      await Provider.of<AdminIngredientController>(context, listen: false)
          .getRecipeIngredients();
      Provider.of<Recipe>(context, listen: false).ingredients =
          Provider.of<AdminRecipesController>(context, listen: false)
              .ingredients;
      Provider.of<AdminRecipesController>(context, listen: false)
          .ingredients
          .forEach((Ingredient) {
        Provider.of<Recipe>(context, listen: false)
            .ingredientID
            .add(Ingredient.ID!);
      });
      Provider.of<Recipe>(context, listen: false).insrtuctions =
          Provider.of<AdminRecipesController>(context, listen: false)
              .insrtuctions;
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    var Recip = Provider.of<AdminRecipesController>(context).Recipe!;
    String name = Recip.Name;
    String Category = Recip.Category;
    String Servings = Recip.Servings;
    String time = Recip.time;
    String nutrition = Recip.nutrition;
    String VideoLink=Recip.VideoLink;
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Edit Recipe"),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      await Provider.of<AdminRecipesController>(context,
                              listen: false)
                          .DeleteRecipe(Recip.ID);
                      Provider.of<Recipe>(context, listen: false).insrtuctions =
                          [];
                      Provider.of<Recipe>(context, listen: false).ingredientID =
                          [];
                      Provider.of<Recipe>(context, listen: false).ingredients =
                          [];
                      Provider.of<PickImage>(context, listen: false).image =
                          null;
                      setState(() {});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const adminNavigationsBar()));
                    },
                  ),
                )
              ],
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
                              child: Image.network(
                                Recip.Image,
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
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kinputDecoration.copyWith(hintText: name),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                onChanged: (value) {
                                  nutrition = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: nutrition),
                              ),
                            ),
                          ),
                             Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                onChanged: (value) {
                                  VideoLink = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: VideoLink),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                onChanged: (value) {
                                  time = value;
                                },
                                decoration:
                                    kinputDecoration.copyWith(hintText: time),
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
                                      'Sweet'
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
                                    value: Recip.Category,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                onChanged: (value) {
                                  Servings = value;
                                },
                                decoration: kinputDecoration.copyWith(
                                    hintText: Servings),
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
                          const Text("ingredients"),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              color: Colors.white,
                              height: 30,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: DropdownButton<int>(
                                  items: Provider.of<AdminIngredientController>(
                                          context)
                                      .ingredients
                                      .map((item) => DropdownMenuItem<int>(
                                            value: Provider.of<
                                                        AdminIngredientController>(
                                                    context)
                                                .ingredients
                                                .indexOf(item),
                                            child: Text(item.Name),
                                          ))
                                      .toList(),
                                  onChanged: (Select) {
                                    setState(() {
                                      var index = Provider.of<
                                                  AdminIngredientController>(
                                              context,
                                              listen: false)
                                          .ingredients
                                          .where((item) => item.Name == Select);
                                      Provider.of<Recipe>(context,
                                              listen: false)
                                          .addIngredientToList(
                                              Provider.of<AdminIngredientController>(
                                                      context,
                                                      listen: false)
                                                  .ingredients[Select!],
                                              Provider.of<AdminIngredientController>(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Instructions"),
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
                                    String Image = "";
                                    if (Provider.of<PickImage>(context,
                                                listen: false)
                                            .image !=
                                        null) {
                                      Image = await Provider.of<PickImage>(
                                              context,
                                              listen: false)
                                          .uploadRecipeFile();
                                    } else {
                                      Image =
                                          Provider.of<AdminRecipesController>(
                                                  context,
                                                  listen: false)
                                              .Recipe!
                                              .Image;
                                    }

                                    await Provider.of<AdminRecipesController>(
                                            context,
                                            listen: false)
                                        .EditRecipe(name, Category, nutrition,
                                            time, Servings, Image,VideoLink);
                                    await Provider.of<
                                                AdminIngredientController>(
                                            context,
                                            listen: false)
                                        .AddAllIngredient(
                                            Provider.of<AdminRecipesController>(
                                                    context,
                                                    listen: false)
                                                .Recipe!
                                                .ID,
                                            Provider.of<Recipe>(context,
                                                    listen: false)
                                                .ingredientID);

                                    await Provider.of<
                                                AdminInsrtuctionCntroller>(
                                            context,
                                            listen: false)
                                        .AddAllInstructions(
                                            Provider.of<AdminRecipesController>(
                                                    context,
                                                    listen: false)
                                                .Recipe!
                                                .ID,
                                            Provider.of<Recipe>(context,
                                                    listen: false)
                                                .insrtuctions);
                                    Provider.of<Recipe>(context, listen: false)
                                        .insrtuctions = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredientID = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredients = [];
                                    Provider.of<PickImage>(context,
                                            listen: false)
                                        .image = null;
                                    Navigator.pop(context, true);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(MessagePrompt().snack(
                                          "Error",
                                          "Please fill in the ingredients",
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
            ));
  }
  
}
