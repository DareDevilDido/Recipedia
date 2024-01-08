import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/DefaultIngredientController.dart';
import '../Widgets/LoadingScreen.dart';
import 'IngredientsPage.dart';
import 'ViewDefaultRecipeListPage.dart';

class DefaultRecipePage extends StatefulWidget {
  const DefaultRecipePage({super.key});
  static const String id = "DefaultRecipePage";

  @override
  State<DefaultRecipePage> createState() => _DefaultRecipePageState();
}

class _DefaultRecipePageState extends State<DefaultRecipePage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
      await Provider.of<DefaultIngredientCntroller>(context, listen: false)
          .getIngredients(kUserId);
    });
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      Provider.of<Loading>(context, listen: true).kIsLoading
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: kBackGroundColor,
              appBar: AppBar(
                title: const Text("Default Recipes"),
                centerTitle: true,
                leading: GestureDetector(
                  child: const Icon(Icons.receipt, color: Colors.white),
                  onTap: () {
                    Navigator.pushNamed(context, IngredientsPage.id);
                  },
                ),
                backgroundColor: kPrimaryColor,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListView(
                  children: [
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewDefaultRecipeListPage(
                                          Category: "BreakFast",
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/recipedia-401e0.appspot.com/o/DefaultImages%2FBreakfast.jpg?alt=media&token=ad76ff84-bde1-44d7-bf58-cfc195594d3b",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 400,
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(),
                                      Container(
                                        height: 65,
                                        color: Colors.black.withOpacity(0.5),
                                        alignment: Alignment.centerLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Breakfast",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewDefaultRecipeListPage(
                                          Category: "Lunch",
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/recipedia-401e0.appspot.com/o/DefaultImages%2FLunch.jpg?alt=media&token=53637bc0-ca01-4180-880a-15dc7633f275",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 400,
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(child: const Text("")),
                                      Container(child: const Text("")),
                                      Container(
                                        height: 65,
                                        color: Colors.black.withOpacity(0.5),
                                        alignment: Alignment.centerLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Lunch",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewDefaultRecipeListPage(
                                          Category: "Dinner",
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/recipedia-401e0.appspot.com/o/DefaultImages%2FDinner.jpg?alt=media&token=d2b0504a-2f8d-4879-af83-f4fab582e422",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 400,
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(),
                                      Container(
                                        height: 65,
                                        color: Colors.black.withOpacity(0.5),
                                        alignment: Alignment.centerLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Dinner",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ViewDefaultRecipeListPage(
                                          Category: "Dessert",
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/recipedia-401e0.appspot.com/o/DefaultImages%2FDessert.jpg?alt=media&token=f6cec9fd-eabb-4cb2-bb4f-f4173274c70f",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 400,
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(),
                                      Container(
                                        height: 65,
                                        color: Colors.black.withOpacity(0.5),
                                        alignment: Alignment.centerLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Dessert",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
}
