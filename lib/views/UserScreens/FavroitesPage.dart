import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/FavroiteRecipeController.dart';
import 'package:provider/provider.dart';
import 'package:recipedia/Views/UserScreens/ViewRecipeFromDefualtList.dart';
import '../../Constants/Constants.dart';
import '../Widgets/LoadingScreen.dart';

class FavroitesPage extends StatefulWidget {
  const FavroitesPage({super.key});
  static const String id = "MyRecipesPage";

  @override
  State<FavroitesPage> createState() => _FavroitesPageState();
}

class _FavroitesPageState extends State<FavroitesPage> {
  @override
  void initState() {
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<FavortieRecipesController>(context, listen: false)
          .getRecipes(kUserId);
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      Provider.of<Loading>(context, listen: true).kIsLoading
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: kBackGroundColor,
              appBar: AppBar(
                title: Text("Favorites " , style: TextStyle(color: kTextColor),),
                centerTitle: true,
                leading: GestureDetector(),
                backgroundColor: kPrimaryColor,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount:
                              Provider.of<FavortieRecipesController>(context)
                                  .favRecipes
                                  .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ViewRecipePage(
                                                RecipeId: Provider.of<
                                                            FavortieRecipesController>(
                                                        context)
                                                    .favRecipes[index]
                                                    .ID,
                                              )));
                                },
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          Provider.of<FavortieRecipesController>(
                                                  context)
                                              .favRecipes[index]
                                              .Image,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(),
                                        Container(
                                          height: 65,
                                          color: Colors.black.withOpacity(0.5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            Provider.of<FavortieRecipesController>(
                                                    context)
                                                .favRecipes[index]
                                                .Name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
}
