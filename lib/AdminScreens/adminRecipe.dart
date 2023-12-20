import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/AdminIngredientController.dart';
import '../Controllers/AdminRecipecontroller.dart';
import '../Controllers/DafualtRecipesController.dart';
import '../Widgets/LoadingScreen.dart';
import 'AdminAddRecipe.dart';
import 'editDefaultRecipePage.dart';

// StatefulWidget for managing and displaying default recipes in admin view
class AdminRecipe extends StatefulWidget {
  const AdminRecipe({super.key});

  // Static constant for the route identifier
  static const String id = "MyRecipesPage";

  @override
  State<AdminRecipe> createState() => _AdminRecipeState();
}

// State class for AdminRecipe
class _AdminRecipeState extends State<AdminRecipe> {
  @override
  void initState() {
    // Initialize the state and load recipes when the widget is initialized
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<AdminRecipesController>(context, listen: false)
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
          appBar: AppBar(
            title: const Text("Default Recipes"),
            leading: null,
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            actions: [
              // Add button to navigate to the page for creating a new recipe
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: const Icon(Icons.add, color: Colors.white),
                  onTap: () async {
                    // Load recipe ingredients before navigating to create recipe page
                    await Provider.of<AdminIngredientController>(context,
                            listen: false)
                        .getRecipeIngredients();

                    bool refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AdminCreateRecipePage()));
                    if (refresh) {
                      // Refresh the recipe list after creating a new recipe
                      await Provider.of<AdminRecipesController>(context,
                              listen: false)
                          .getRecipes(kUserId);
                    }
                  },
                ),
              )
            ],
          ),
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount:
                  Provider.of<AdminRecipesController>(context).Recipes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      // Load a single recipe before navigating to edit recipe page
                      await Provider.of<DefaultRecipeController>(context,
                              listen: false)
                          .getSingleRecipe(
                              kUserId,
                              Provider.of<AdminRecipesController>(context,
                                      listen: false)
                                  .Recipes[index]
                                  .ID);
                      bool refresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => editDefaultRecipePage(
                                    RecipeId:
                                        Provider.of<DefaultRecipeController>(
                                                context)
                                            .Recipe!
                                            .ID,
                                  )));
                      if (refresh) {
                        // Refresh the recipe list after editing a recipe
                        await Provider.of<AdminRecipesController>(context,
                                listen: false)
                            .getRecipes(kUserId);
                      }
                    },
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              Provider.of<AdminRecipesController>(context)
                                  .Recipes[index]
                                  .Image,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            Container(
                              height: 65,
                              color: Colors.black.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: Text(
                                Provider.of<AdminRecipesController>(context)
                                    .Recipes[index]
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
              }));
}
