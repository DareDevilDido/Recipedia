import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/AdminRecipecontroller.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import 'editDefaultRecipePage.dart';

class AdminViewRecipePage extends StatefulWidget {
  static const String id = "AdminViewRecipePage";
  String RecipeId;

  String? name;
  AdminViewRecipePage({super.key, required this.RecipeId});

  @override
  State<AdminViewRecipePage> createState() => _AdminViewRecipePageState();
}

class _AdminViewRecipePageState extends State<AdminViewRecipePage> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<DefaultRecipeController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      await Provider.of<AdminRecipesController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
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
            title: const Text("Recipe"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                        Provider.of<DefaultRecipeController>(context)
                            .Recipe!
                            .Image)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            Provider.of<DefaultRecipeController>(context)
                                .Recipe!
                                .Name,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              child: Icon(Icons.edit, color: kPrimaryColor),
                              onTap: () async {
                                bool refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => editDefaultRecipePage(
                                              RecipeId: Provider.of<
                                                          DefaultRecipeController>(
                                                      context)
                                                  .Recipe!
                                                  .ID,
                                            )));

                                if (refresh) {
                                  Future.delayed(Duration.zero).then((_) async {
                                    await Provider.of<AdminRecipesController>(
                                            context,
                                            listen: false)
                                        .getRecipes(kUserId);
                                    await Provider.of<DefaultRecipeController>(
                                            context,
                                            listen: false)
                                        .getSingleRecipe(
                                            kUserId, widget.RecipeId);
                                    await Provider.of<AdminRecipesController>(
                                            context,
                                            listen: false)
                                        .getSingleRecipe(
                                            kUserId, widget.RecipeId);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.red,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Calories \t\t\t\t\t\t\t  ${Provider.of<DefaultRecipeController>(context).Recipe!.nutrition}",
                            maxLines: 2,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: kPrimaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Category \t\t\t  ${Provider.of<DefaultRecipeController>(context).Recipe!.Category}",
                            maxLines: 2,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: kButtonColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Time \t\t\t\t\t\t\t   ${Provider.of<DefaultRecipeController>(context).Recipe!.time}",
                            maxLines: 2,
                            style: TextStyle(
                                color: kButtonColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.green,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Servings   \t  \t ${Provider.of<DefaultRecipeController>(context).Recipe!.Servings}",
                            maxLines: 2,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const LineDivider(),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Provider.of<DefaultRecipeController>(context)
                          .Recipe!
                          .ingredients
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              Provider.of<DefaultRecipeController>(context)
                                  .Recipe!
                                  .ingredients[index]
                                  .image,
                            ),
                            minRadius: 40,
                          ),
                        );
                      }),
                ),
                const LineDivider(),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: Provider.of<DefaultRecipeController>(context)
                          .insrtuctions
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: kContainerColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                    "Step ${Provider.of<DefaultRecipeController>(context).insrtuctions[index].Step} :${Provider.of<DefaultRecipeController>(context).insrtuctions[index].Description}"),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
}
