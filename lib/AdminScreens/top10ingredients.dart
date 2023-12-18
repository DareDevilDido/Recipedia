import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/UserIngredientsController.dart';
import 'package:provider/provider.dart';
import '../Widgets/LoadingScreen.dart';

class top10IngredientsPage extends StatefulWidget {
  static const String id = "IngredientsPage";

  const top10IngredientsPage({super.key});

  @override
  State<top10IngredientsPage> createState() => _top10IngredientsPageState();
}

class _top10IngredientsPageState extends State<top10IngredientsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
      await Provider.of<UserIngredientController>(context, listen: false)
          .getTop10Ingredients(kUserId);
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
            leading: GestureDetector(),
            title: const Text("Top 10 Ingredients Page"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: (Provider.of<UserIngredientController>(context)
                          .ingredients
                          .length <
                      10)
                  ? Provider.of<UserIngredientController>(context)
                      .ingredients
                      .length
                  : 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(children: [
                      Image.network(
                          Provider.of<UserIngredientController>(context)
                              .ingredients[index]
                              .image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10.0)),
                                  child: Container(
                                    color: kButtonColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "No.${index + 1}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                Container()
                              ],
                            ),
                            Container(),
                            Container(
                              height: 45,
                              color: Colors.black.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        Provider.of<UserIngredientController>(
                                                context)
                                            .ingredients[index]
                                            .Name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "${Provider.of<UserIngredientController>(context).ingredients[index].timesused} ",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.rice_bowl_sharp,
                                            color: kButtonColor,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              })
          //
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text("Image"),
          //           Text("Name"),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text("Times Used"),
          //         ],
          //       ),
          //       Expanded(
          //         child: ListView.builder(
          //             itemCount: (Provider.of<UserIngredientController>(context)
          //                         .ingredients
          //                         .length <
          //                     10)
          //                 ? Provider.of<UserIngredientController>(context)
          //                     .ingredients
          //                     .length
          //                 : 10,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(bottom: 8.0),
          //                 child: ListTile(
          //                   trailing: Text(
          //                       Provider.of<UserIngredientController>(context)
          //                           .ingredients[index]
          //                           .timesused),
          //                   leading: Image.network(
          //                     Provider.of<UserIngredientController>(context)
          //                         .ingredients[index]
          //                         .image,
          //                     height: 50,
          //                     width: 50,
          //                   ),
          //                   title: Text(
          //                       Provider.of<UserIngredientController>(context)
          //                           .ingredients[index]
          //                           .Name),
          //                 ),
          //               );
          //             }),
          //       ),
          //     ],
          //   ),
          // ),
          );
}
