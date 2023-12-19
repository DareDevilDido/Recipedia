import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Models/Recipe.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/UserIngredientsController.dart';
import '../Controllers/UserInstructionsController.dart';
import '../Controllers/UserRecipeIngredientController.dart';
import '../Controllers/UserRecipesController.dart';
import '../Models/PickImage.dart';
import '../Repo/InstructionRepo.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';

class EditRecipePage extends StatefulWidget {
  static const String id = "EditRecipePage";
  String RecipeId;
  EditRecipePage({super.key, required this.RecipeId});
  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  @override
  void initState() {
    Provider.of<Recipe>(context, listen: false).insrtuctions = [];
    Provider.of<Recipe>(context, listen: false).ingredientID = [];
    Provider.of<Recipe>(context, listen: false).ingredients = [];
    Provider.of<PickImage>(context, listen: false).image = null;
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Provider.of<UserRecipesController>(context, listen: false)
        .ingredients
        .forEach((Ingredient) {
      Provider.of<Recipe>(context, listen: false)
          .ingredientID
          .add(Ingredient.ID!);
    });
    Provider.of<Recipe>(context, listen: false).ingredients =
        Provider.of<UserRecipesController>(context, listen: false).ingredients;
    Provider.of<Recipe>(context, listen: false).insrtuctions =
        Provider.of<UserRecipesController>(context, listen: false).insrtuctions;

    Future.delayed(const Duration(milliseconds: 100)).then((_) async {
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Recip = Provider.of<UserRecipesController>(context).Recipe!;
    String name = Recip.Name;
    String Category = Recip.Category;
    String Servings = Recip.Servings;
    String time = Recip.time;
    String nutrition = Recip.nutrition;
    String description = "";
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Edit Recipe"),
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
                                  Provider.of<Loading>(context, listen: false)
                                      .changeBool();
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
                                    Image = Provider.of<UserRecipesController>(
                                            context,
                                            listen: false)
                                        .Recipe!
                                        .Image;
                                  }
                                  if (name != "" &&
                                      Category != "" &&
                                      nutrition != "" &&
                                      time != "" &&
                                      Servings != "" &&
                                      name != "" &&
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
                                    await Provider.of<UserRecipesController>(
                                            context,
                                            listen: false)
                                        .EditRecipe(name, Category, nutrition,
                                            time, Servings, Image);
                                    Provider.of<UserRecipeIngredientController>(
                                            context,
                                            listen: false)
                                        .AddAllIngredient(
                                            Provider.of<UserRecipesController>(
                                                    context,
                                                    listen: false)
                                                .Recipe!
                                                .ID,
                                            Provider.of<Recipe>(context,
                                                    listen: false)
                                                .ingredientID);

                                    Provider.of<UserInsrtuctionCntroller>(
                                            context,
                                            listen: false)
                                        .AddAllInstructions(
                                            Provider.of<UserRecipesController>(
                                                    context,
                                                    listen: false)
                                                .Recipe!
                                                .ID,
                                            Provider.of<Recipe>(context,
                                                    listen: false)
                                                .insrtuctions);
                                    Provider.of<PickImage>(context,
                                            listen: false)
                                        .image = null;
                                    Provider.of<Recipe>(context, listen: false)
                                        .insrtuctions = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredientID = [];
                                    Provider.of<Recipe>(context, listen: false)
                                        .ingredients = [];
                                    await Provider.of<UserRecipesController>(
                                            context,
                                            listen: false)
                                        .getSingleRecipe(
                                            kUserId, widget.RecipeId);
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
                                    Navigator.pop(context, true);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(MessagePrompt().snack(
                                          "Error",
                                          "Instruction is empty",
                                          ContentType.failure));
                                    Provider.of<Loading>(context, listen: false)
                                        .changeBool();
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
            )

            // Padding(
            //   padding: EdgeInsets.only(top: 10, bottom: 10),
            //   child: ListView(
            //     children: <Widget>[
            //       Column(children: <Widget>[
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         TextField(
            //           controller: TextEditingController(text: Recip.Name),
            //           onChanged: (value) {
            //             name = value;
            //           },
            //           decoration:
            //               kinputDecoration.copyWith(hintText: "Recipe Name"),
            //         ),
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         TextField(
            //           controller: TextEditingController(text: Recip.nutrition),
            //           onChanged: (value) {
            //             nutrition = value;
            //           },
            //           decoration:
            //               kinputDecoration.copyWith(hintText: "nutrition"),
            //         ),
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         TextField(
            //           controller: TextEditingController(text: Recip.time),
            //           onChanged: (value) {
            //             time = value;
            //           },
            //           decoration:
            //               kinputDecoration.copyWith(hintText: "Time to cook "),
            //         ),
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         TextField(
            //           controller: TextEditingController(text: Recip.Category),
            //           onChanged: (value) {
            //             Category = value;
            //           },
            //           decoration:
            //               kinputDecoration.copyWith(hintText: "Category "),
            //         ),
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         TextField(
            //           controller: TextEditingController(text: Recip.Servings),
            //           onChanged: (value) {
            //             Servings = value;
            //           },
            //           decoration:
            //               kinputDecoration.copyWith(hintText: "Servings"),
            //         ),
            //         const SizedBox(
            //           height: 8.0,
            //         ),
            //         LineDivider(),
            //         Row(
            //           children: <Widget>[
            //             if (Provider.of<PickImage>(context).image != null)
            //               Expanded(
            //                   child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Container(
            //                   height: 80,
            //                   width: 80,
            //                   child: Image.file(File(
            //                       Provider.of<PickImage>(context)
            //                           .image!
            //                           .path!)),
            //                 ),
            //               ))
            //             else
            //               Expanded(
            //                   child: ClipRRect(
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(6)),
            //                       child: Image.network(Recip.Image))),
            //             Expanded(
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: RoundedButton(
            //                     color: kButtonColor,
            //                     text: 'Pick Image',
            //                     onPressed: () {
            //                       Provider.of<PickImage>(context, listen: false)
            //                           .selectFile();
            //                     }),
            //               ),
            //             )
            //           ],
            //         ),
            //         LineDivider(),
            //         Container(
            //           height: 130,
            //           child: ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount:
            //                   Provider.of<Recipe>(context).ingredients.length,
            //               itemBuilder: (context, index) {
            //                 return Column(children: [
            //                   Padding(
            //                     padding: const EdgeInsets.all(3.0),
            //                     child: CircleAvatar(
            //                       backgroundImage: NetworkImage(
            //                         Provider.of<Recipe>(context, listen: false)
            //                             .ingredients[index]
            //                             .image,
            //                       ) as ImageProvider,
            //                       minRadius: 40,
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: GestureDetector(
            //                       child: Icon(Icons.delete,
            //                           color: kPrimaryColor),
            //                       onTap: () {
            //                         Provider.of<Recipe>(context, listen: false)
            //                             .removeIngrecientFromList(index);
            //                         // Navigator.pushNamed(context, SearchPage.id);
            //                       },
            //                     ),
            //                   )
            //                 ]);
            //               }),
            //         ),
            //         LineDivider(),
            //         Container(
            //           height: 200,
            //           child: ListView.builder(
            //               itemCount:
            //                   Provider.of<Recipe>(context).insrtuctions.length,
            //               itemBuilder: (context, index) {
            //                 Provider.of<Recipe>(context)
            //                     .insrtuctions[index]
            //                     .Step = (index + 1).toString();
            //                 return Row(
            //                   children: [
            //                     Expanded(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(10.0),
            //                           child: Container(
            //                             color: Colors.orange.shade50,
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(15.0),
            //                               child: Text(
            //                                   "Step ${Provider.of<Recipe>(context, listen: false).insrtuctions[index].Step} :${Provider.of<Recipe>(context, listen: false).insrtuctions[index].Description}"),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(right: 15.0),
            //                       child: GestureDetector(
            //                         child: Icon(Icons.delete,
            //                             color: kPrimaryColor),
            //                         onTap: () {
            //                           Provider.of<Recipe>(context,
            //                                   listen: false)
            //                               .removeInstructionsToList(index);
            //                           // Navigator.pushNamed(context, SearchPage.id);
            //                         },
            //                       ),
            //                     )
            //                   ],
            //                 );
            //               }),
            //         ),
            //         LineDivider(),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               RoundedButton(
            //                   color: Colors.red,
            //                   text: 'Add ingredient',
            //                   onPressed: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (_) =>
            //                                 SelectIngredientsPage()));
            //                     // Navigator.pushNamed(context, LoginScreen.id);
            //                   }),
            //               RoundedButton(
            //                   color: kPrimaryColor,
            //                   text: 'Add instruction',
            //                   onPressed: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (_) =>
            //                                 CreateInstructionPage()));
            //                     // Navigator.pushNamed(context, LoginScreen.id);
            //                   })
            //             ],
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: RoundedButton(
            //                   color: kPrimaryColor,
            //                   text: 'Save',
            //                   onPressed: () async {
            //                     Provider.of<Loading>(context, listen: false)
            //                         .changeBool();
            //                     String Image = "";
            //                     if (Provider.of<PickImage>(context,
            //                                 listen: false)
            //                             .image !=
            //                         null) {
            //                       Image = await Provider.of<PickImage>(context,
            //                               listen: false)
            //                           .uploadRecipeFile();
            //                     } else {
            //                       Image = Provider.of<UserRecipesController>(
            //                               context,
            //                               listen: false)
            //                           .Recipe!
            //                           .Image;
            //                     }
            //                     if (name != "" &&
            //                         Category != "" &&
            //                         nutrition != "" &&
            //                         time != "" &&
            //                         Servings != "" &&
            //                         name != "" &&
            //                         Provider.of<Recipe>(context, listen: false)
            //                                 .insrtuctions !=
            //                             [] &&
            //                         Provider.of<Recipe>(context, listen: false)
            //                                 .ingredients !=
            //                             [] &&
            //                         Provider.of<Recipe>(context, listen: false)
            //                                 .ingredientID !=
            //                             []) {
            //                       await Provider.of<UserRecipesController>(
            //                               context,
            //                               listen: false)
            //                           .EditRecipe(name, Category, nutrition,
            //                               time, Servings, Image);
            //                       Provider.of<UserRecipeIngredientController>(
            //                               context,
            //                               listen: false)
            //                           .AddAllIngredient(
            //                               Provider.of<UserRecipesController>(
            //                                       context,
            //                                       listen: false)
            //                                   .Recipe!
            //                                   .ID,
            //                               Provider.of<Recipe>(context,
            //                                       listen: false)
            //                                   .ingredientID);
            //
            //                       Provider.of<UserInsrtuctionCntroller>(context,
            //                               listen: false)
            //                           .AddAllInstructions(
            //                               Provider.of<UserRecipesController>(
            //                                       context,
            //                                       listen: false)
            //                                   .Recipe!
            //                                   .ID,
            //                               Provider.of<Recipe>(context,
            //                                       listen: false)
            //                                   .insrtuctions);
            //                       Provider.of<PickImage>(context, listen: false)
            //                           .image = null;
            //                       Provider.of<Recipe>(context, listen: false)
            //                           .insrtuctions = [];
            //                       Provider.of<Recipe>(context, listen: false)
            //                           .ingredientID = [];
            //                       Provider.of<Recipe>(context, listen: false)
            //                           .ingredients = [];
            //                       await Provider.of<UserRecipesController>(
            //                               context,
            //                               listen: false)
            //                           .getSingleRecipe(
            //                               kUserId, widget.RecipeId);
            //                       Provider.of<Loading>(context, listen: false)
            //                           .changeBool();
            //                       Navigator.pop(context, true);
            //                     } else {
            //                       ScaffoldMessenger.of(context)
            //                         ..hideCurrentSnackBar()
            //                         ..showSnackBar(MessagePrompt().snack(
            //                             "Error",
            //                             "Instruction is empty",
            //                             ContentType.failure));
            //                       Provider.of<Loading>(context, listen: false)
            //                           .changeBool();
            //                     }
            //                   }),
            //             ),
            //             RoundedButton(
            //               color: Colors.red,
            //               text: 'Delete',
            //               onPressed: () async {
            //                 Provider.of<Loading>(context, listen: false)
            //                     .changeBool();
            //                 await Provider.of<UserRecipesController>(context,
            //                         listen: false)
            //                     .DeleteRecipe(Recip.ID);
            //                 Provider.of<PickImage>(context, listen: false)
            //                     .image = null;
            //                 Provider.of<Recipe>(context, listen: false)
            //                     .insrtuctions = [];
            //                 Provider.of<Recipe>(context, listen: false)
            //                     .ingredientID = [];
            //                 Provider.of<Recipe>(context, listen: false)
            //                     .ingredients = [];
            //                 Provider.of<Loading>(context, listen: false)
            //                     .changeBool();
            //                 Navigator.pushReplacement(
            //                     context,
            //                     new MaterialPageRoute(
            //                         builder: (_) => MyRecipesPage()));
            //               },
            //             )
            //           ],
            //         ),
            //       ]),
            //     ],
            //   ),
            // ),
            );
  }
}
