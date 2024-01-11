import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:recipedia/Views/UserScreens/SearchPage.dart';
import 'package:provider/provider.dart';
import 'package:recipedia/Views/UserScreens/ViewRecipeFromDefualtList.dart';
import 'package:recipedia/Views/Widgets/roundedbutton.dart';
import 'package:recipedia/Views/UserScreens/AiAddIngredient.dart';
import '../../Constants/Constants.dart';
import '../../Unique classes/RandomRecipeOfTheDay.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Recipename = "";
  Random random = Random();
  var randomNumber;
  @override
  void initState() {
    Provider.of<Loading>(context, listen: false).kCategory = "All";
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
    Future.delayed(const Duration(milliseconds: 300)).then((_) async {
      await Provider.of<RandomRecipeOfTheDay>(context, listen: false)
          .getRandomRecipe();
      await Provider.of<DefaultRecipeController>(context, listen: false)
          .FilterCategory(
              Provider.of<RandomRecipeOfTheDay>(context, listen: false)
                  .RecipeTime);
      Provider.of<DefaultRecipeController>(context, listen: false)
          .Recipes
          .removeWhere((Recipe) =>
              Recipe.ID ==
              Provider.of<RandomRecipeOfTheDay>(context, listen: false)
                  .ROTD!
                  .ID);
      //Provider.of<RandomRecipeOfTheDay>(context, listen: false).ROTD
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
      : DefaultTextStyle(
          style: TextStyle(color: kTextColor),
          child: Scaffold(
            backgroundColor: kBackGroundColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              leading: GestureDetector(),
              title: Text(
                "Home",
                style: TextStyle(color: kTextColor, fontSize: 26),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    child: const Icon(Icons.search, color: Colors.white),
                    onTap: () {
                      Navigator.pushNamed(context, SearchPage.id);
                    },
                  ),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text("Recipe of the day",
                      style: TextStyle(fontSize: 20, color: kTextColor)),
                  const LineDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewRecipePage(
                                    RecipeId: Provider.of<RandomRecipeOfTheDay>(
                                            context,
                                            listen: false)
                                        .ROTD!
                                        .ID,
                                  )));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          Provider.of<RandomRecipeOfTheDay>(context,
                                  listen: false)
                              .ROTD!
                              .Image,
                          height: 180,
                          width: 330,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      Provider.of<RandomRecipeOfTheDay>(context, listen: false)
                          .ROTD!
                          .Name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTextColor),
                    ),
                  ),
                  const LineDivider(),
                  RoundedButton(
                      color: const Color.fromARGB(255, 217, 126, 150),
                      text: "Ask AI",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const IngredientInputWidget()),
                        );
                      }),
                  const LineDivider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: Text(
                        "Other ${Provider.of<RandomRecipeOfTheDay>(context, listen: false).ROTD!.Category} Recipes",
                        style: TextStyle(fontSize: 20, color: kTextColor)),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  Provider.of<DefaultRecipeController>(context)
                                      .Recipes
                                      .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewRecipePage(
                                                      RecipeId: Provider.of<
                                                                  DefaultRecipeController>(
                                                              context)
                                                          .Recipes[index]
                                                          .ID,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                    Provider.of<DefaultRecipeController>(
                                                            context)
                                                        .Recipes[index]
                                                        .Image,
                                                    height: 240,
                                                    width: 200,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Text(
                                                    Provider.of<DefaultRecipeController>(
                                                            context)
                                                        .Recipes[index]
                                                        .Name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: kTextColor)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              }),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
