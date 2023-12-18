import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/AdminIngredientController.dart';
import 'package:recipedia/Models/Recipe.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import 'CreateAdminIngredientPage.dart';

class AdminSelectIngredientsPage extends StatefulWidget {
  const AdminSelectIngredientsPage({super.key});
  static const String id = "SelectIngredientsPage";

  @override
  State<AdminSelectIngredientsPage> createState() =>
      _SelectIngredientsPageState();
}

class _SelectIngredientsPageState extends State<AdminSelectIngredientsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<AdminIngredientController>(context, listen: false)
          .getRecipeIngredients();
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Ingredients"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: const Icon(Icons.add, color: Colors.white),
                onTap: () async {
                  bool refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CreateAdminIngredientPage()));
                  if (refresh) {
                    await Provider.of<AdminIngredientController>(context,
                            listen: false)
                        .getRecipeIngredients();
                  }
                },
              ),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: Provider.of<AdminIngredientController>(context)
                      .ingredients
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        onTap: () {
                          Provider.of<Recipe>(context, listen: false)
                              .addIngredientToList(
                                  Provider.of<AdminIngredientController>(
                                          context,
                                          listen: false)
                                      .ingredients[index],
                                  Provider.of<AdminIngredientController>(
                                          context,
                                          listen: false)
                                      .ingredientID[index]);
                          Navigator.pop(context);
                        },
                        leading: Image.network(
                            Provider.of<AdminIngredientController>(context)
                                .ingredients[index]
                                .image),
                        trailing: Text(
                            Provider.of<AdminIngredientController>(context)
                                .ingredients[index]
                                .Name),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
