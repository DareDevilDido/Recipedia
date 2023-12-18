import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Controllers/DafualtRecipesController.dart';
import '../Widgets/LoadingScreen.dart';
import 'ViewRecipePage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String id = "SearchPage";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String input = "";
  @override
  Widget build(BuildContext context) =>
      Provider.of<Loading>(context, listen: true).kIsLoading
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: kBackGroundColor,
              appBar: AppBar(
                title: const Text("Search"),
                centerTitle: true,
                backgroundColor: kPrimaryColor,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextField(
                            onChanged: (value) async {
                              input = value;
                            },
                            decoration: kinputDecoration.copyWith(
                                hintText: "Search for recipes"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: const Icon(Icons.search),
                            onTap: () async {
                              if (input != "" || input != null) {
                                await Provider.of<DefaultRecipesController>(
                                        context,
                                        listen: false)
                                    .ProcessSearch(input);
                              } else {
                                await Provider.of<DefaultRecipesController>(
                                        context,
                                        listen: false)
                                    .getRecipes(kUserId);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          child: ListView.builder(
                              itemCount:
                                  Provider.of<DefaultRecipesController>(context)
                                      .NewRecipes
                                      .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.orange.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewRecipePage(
                                                      RecipeId: Provider.of<
                                                                  DefaultRecipesController>(
                                                              context)
                                                          .NewRecipes[index]
                                                          .ID,
                                                    )));
                                      },
                                      child: Column(
                                        children: [
                                          ListTile(
                                            trailing: Image.network(
                                                Provider.of<DefaultRecipesController>(
                                                        context)
                                                    .NewRecipes[index]
                                                    .Image,
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover),
                                            leading: Text(
                                              Provider.of<DefaultRecipesController>(
                                                      context)
                                                  .NewRecipes[index]
                                                  .Name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.deepOrange,
                                            thickness: 1.5,
                                            indent: 15,
                                            endIndent: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
}
