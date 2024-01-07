import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipedia/Unique%20classes/Recipe.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import '../../Controllers/UserInstructionsController.dart';
import '../../Controllers/UserRecipeIngredientController.dart';
import '../../Controllers/UserRecipesController.dart';
import '../../Unique classes/PickImage.dart';
import '../UserScreens/CreateInstructionsPage.dart';
import '../UserScreens/SelectIngredientsPage.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/roundedbutton.dart';

class ManageRecipePage extends StatefulWidget {
  static const String id = "EditRecipePage";
  String RecipeId;
  ManageRecipePage({super.key, required this.RecipeId});
  @override
  State<ManageRecipePage> createState() => _ManageRecipePageState();
}

class _ManageRecipePageState extends State<ManageRecipePage> {
  @override
  void initState() {
    Provider.of<Recipe>(context, listen: false).ingredients =
        Provider.of<UserRecipesController>(context, listen: false).ingredients;
    Provider.of<Recipe>(context, listen: false).insrtuctions =
        Provider.of<UserRecipesController>(context, listen: false).insrtuctions;

    Provider.of<UserRecipesController>(context, listen: false)
        .ingredients
        .forEach((ingredient) {
      Provider.of<Recipe>(context, listen: false)
          .ingredientID
          .add(ingredient.ID!);
    });
    
    Provider.of<Recipe>(context, listen: false).ingredientID =
        Provider.of<UserRecipesController>(context, listen: false)
            .ingredientsID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Recip = Provider.of<UserRecipesController>(context).Recipe!;
    String name = Recip.Name;
    String Category = Recip.Category;
    String Servings = Recip.Servings;
    String time = Recip.time;
    String Calories = Recip.nutrition;
    String VideoLink=Recip.VideoLink;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favroites"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: Recip.Name),
                onChanged: (value) {
                  name = value;
                },
                decoration: kinputDecoration.copyWith(hintText: "Recipe Name"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: Recip.nutrition),
                onChanged: (value) {
                  Calories = value;
                },
                decoration: kinputDecoration.copyWith(hintText: "Calories"),
              ),
              const SizedBox(
                height: 8.0,
              ),
               TextField(
                controller: TextEditingController(text: Recip.VideoLink),
                onChanged: (value) {
                  VideoLink = value;
                },
                decoration: kinputDecoration.copyWith(hintText: "VideoLink"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: Recip.time),
                onChanged: (value) {
                  time = value;
                },
                decoration:
                    kinputDecoration.copyWith(hintText: "Time to cook "),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: Recip.Category),
                onChanged: (value) {
                  Category = value;
                },
                decoration: kinputDecoration.copyWith(hintText: "Category "),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: Recip.Servings),
                onChanged: (value) {
                  Servings = value;
                },
                decoration: kinputDecoration.copyWith(hintText: "Servings"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const LineDivider(),
              Row(
                children: <Widget>[
                  if (Provider.of<PickImage>(context).image != null)
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.file(
                            File(Provider.of<PickImage>(context).image!.path!)),
                      ),
                    ))
                  else
                    Expanded(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                            child: Image.network(Recip.Image))),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedButton(
                          color: kButtonColor,
                          text: 'Pick Image',
                          onPressed: () {
                            Provider.of<PickImage>(context, listen: false)
                                .selectFile();
                          }),
                    ),
                  )
                ],
              ),
              const LineDivider(),
              SizedBox(
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<Recipe>(context).ingredients.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              Provider.of<Recipe>(context, listen: false)
                                  .ingredients[index]
                                  .image,
                            ),
                            minRadius: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: const Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              Provider.of<Recipe>(context, listen: false)
                                  .removeIngrecientFromList(index);
                              // Navigator.pushNamed(context, SearchPage.id);
                            },
                          ),
                        )
                      ]);
                    }),
              ),
              const LineDivider(),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: Provider.of<Recipe>(context).insrtuctions.length,
                    itemBuilder: (context, index) {
                      Provider.of<Recipe>(context).insrtuctions[index].Step =
                          (index + 1).toString();
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: kContainerColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                        "Step ${Provider.of<Recipe>(context, listen: false).insrtuctions[index].Step} :${Provider.of<Recipe>(context, listen: false).insrtuctions[index].Description}"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: GestureDetector(
                              child: const Icon(Icons.delete, color: Colors.red),
                              onTap: () {
                                Provider.of<Recipe>(context, listen: false)
                                    .removeInstructionsToList(index);
                                // Navigator.pushNamed(context, SearchPage.id);
                              },
                            ),
                          )
                        ],
                      );
                    }),
              ),
              const LineDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                        color: Colors.red,
                        text: 'Add ingredient',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SelectIngredientsPage()));
                          // Navigator.pushNamed(context, LoginScreen.id);
                        }),
                    RoundedButton(
                        color: kPrimaryColor,
                        text: 'Add instruction',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CreateInstructionPage()));
                          // Navigator.pushNamed(context, LoginScreen.id);
                        })
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedButton(
                        color: kPrimaryColor,
                        text: 'Save',
                        onPressed: () async {
                          String Image = await Provider.of<PickImage>(context,
                                  listen: false)
                              .uploadRecipeFile();
                          await Provider.of<UserRecipesController>(context,
                                  listen: false)
                              .EditRecipe(name, Category, Calories, time,
                                  Servings, Image,VideoLink);
                          Provider.of<UserRecipeIngredientController>(context,
                                  listen: false)
                              .AddAllIngredient(
                                  Provider.of<UserRecipesController>(context,
                                          listen: false)
                                      .Recipe!
                                      .ID,
                                  Provider.of<Recipe>(context, listen: false)
                                      .ingredientID);

                          Provider.of<UserInsrtuctionCntroller>(context,
                                  listen: false)
                              .AddAllInstructions(
                                  Provider.of<UserRecipesController>(context,
                                          listen: false)
                                      .Recipe!
                                      .ID,
                                  Provider.of<Recipe>(context, listen: false)
                                      .insrtuctions);
                          Navigator.pop(context);
                        }),
                  ),
                  RoundedButton(
                      color: Colors.red,
                      text: 'Delete',
                      onPressed: () async {
                        await Provider.of<UserRecipesController>(context,
                                listen: false)
                            .DeleteRecipe(Recip.ID);
                        Navigator.pop(context);
                      })
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
