import 'package:flutter/material.dart';
import 'package:recipedia/Screens/ViewMyRecipesPage.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/UserRecipesController.dart';
import '../Widgets/LoadingScreen.dart';
import 'CreateRecipePage.dart';
import 'MyIngredientPage.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key});
  static const String id = "MyRecipesPage";

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  @override
  void initState() {
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserRecipesController>(context, listen: false)
          .getRecipes(kUserId);
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
      : Scaffold(
          backgroundColor: kBackGroundColor,
          appBar: AppBar(
            title: const Text("My Recipes"),
            leading: GestureDetector(
              child: const Icon(Icons.receipt, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, MyIngredientPage.id);
              },
            ),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: const Icon(Icons.add, color: Colors.white),
                  onTap: () async {
                    bool refresh = await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CreateRecipePage()));
                    if (refresh) {
                      Provider.of<UserRecipesController>(context, listen: false)
                          .getRecipes(kUserId);
                    }
                  },
                ),
              )
            ],
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
                                builder: (_) => ViewMyRecipePage(
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
                                builder: (_) => ViewMyRecipePage(
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
                                builder: (_) => ViewMyRecipePage(
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
                                builder: (_) => ViewMyRecipePage(
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
