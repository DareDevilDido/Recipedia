import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:provider/provider.dart';
import '../Widgets/LoadingScreen.dart';

class top10RecipesPage extends StatefulWidget {
  static const String id = "IngredientsPage";

  const top10RecipesPage({super.key});

  @override
  State<top10RecipesPage> createState() => _top10RecipesPageState();
}

class _top10RecipesPageState extends State<top10RecipesPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
      await Provider.of<DefaultRecipesController>(context, listen: false)
          .getTop10Recipes(kUserId);
    });
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
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
            title: const Text("Top 10 Favroited Page"),
            centerTitle: true,
            leading: GestureDetector(),
            backgroundColor: kPrimaryColor,
          ),
          body: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount:
                  Provider.of<DefaultRecipesController>(context).Recipes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(children: [
                      Image.network(
                          Provider.of<DefaultRecipesController>(context)
                              .Recipes[index]
                              .Image,
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
                                        Provider.of<DefaultRecipesController>(
                                                context)
                                            .Recipes[index]
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
                                            "${Provider.of<DefaultRecipesController>(context).Recipes[index].TimesFavorited} ",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.favorite,
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

          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text("Recipe"),
          //           Text("Name"),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text(" "),
          //           Text("Times Favroited"),
          //         ],
          //       ),
          //       Expanded(
          //         child: ListView.builder(
          //             itemCount: Provider.of<DefaultRecipesController>(context)
          //                 .Recipes
          //                 .length,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(bottom: 8.0),
          //                 child: ListTile(
          //                     leading: Image.network(
          //                         Provider.of<DefaultRecipesController>(context)
          //                             .Recipes[index]
          //                             .Image,
          //                         height: 50,
          //                         width: 50),
          //                     title: Text(
          //                         Provider.of<DefaultRecipesController>(context)
          //                             .Recipes[index]
          //                             .Name),
          //                     trailing: Text(
          //                         Provider.of<DefaultRecipesController>(context)
          //                             .Recipes[index]
          //                             .TimesFavorited)),
          //               );
          //             }),
          //       ),
          //     ],
          //   ),
          // ),
          );
}
