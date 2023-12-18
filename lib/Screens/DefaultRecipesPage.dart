import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/DefaultIngredientController.dart';
import '../Widgets/LoadingScreen.dart';
import 'IngredientsPage.dart';
import 'ViewDefaultRecipeListPage.dart';

class DefaultRecipesPage extends StatefulWidget {
  const DefaultRecipesPage({super.key});
  static const String id = "DefaultRecipesPage";

  @override
  State<DefaultRecipesPage> createState() => _DefaultRecipesPageState();
}

class _DefaultRecipesPageState extends State<DefaultRecipesPage> {
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
                                  "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FBreakfast.jpg?alt=media&token=f2f335d7-c426-4993-905d-e3ee09b0c047",
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
                                          padding:
                                              EdgeInsets.only(left: 15.0),
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
                                  "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FLunch.jpg?alt=media&token=b3d36eae-2325-409a-a3ed-86eefc99992d",
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
                                          padding:
                                              EdgeInsets.only(left: 15.0),
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
                                  "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FDinner.jpg?alt=media&token=5c257337-ac9d-4114-984b-392ae64911e7",
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
                                          padding:
                                              EdgeInsets.only(left: 15.0),
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
                                          Category: "Sweet",
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FDessert.jpg?alt=media&token=374ea6d6-a1ed-428f-b907-0839c13d7924",
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
                                          padding:
                                              EdgeInsets.only(left: 15.0),
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
