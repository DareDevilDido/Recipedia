import 'package:flutter/material.dart';
import 'package:recipedia/Models/Recipe.dart';
import 'package:recipedia/Screens/CreateIngredientPage.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/UserIngredientsController.dart';

class SelectIngredientsPage extends StatefulWidget {
  const SelectIngredientsPage({super.key});
  static const String id = "SelectIngredientsPage";

  @override
  State<SelectIngredientsPage> createState() => _SelectIngredientsPageState();
}

class _SelectIngredientsPageState extends State<SelectIngredientsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserIngredientController>(context, listen: false)
          .getIngredients(kUserId);
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
                          builder: (_) => const CreateIngredientPage()));
                  if (refresh) {
                    await Provider.of<UserIngredientController>(context,
                            listen: false)
                        .getIngredients(kUserId);
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
                  itemCount: Provider.of<UserIngredientController>(context)
                      .ingredients
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        onTap: () {
                          Provider.of<Recipe>(context, listen: false)
                              .addIngredientToList(
                                  Provider.of<UserIngredientController>(context,
                                          listen: false)
                                      .ingredients[index],
                                  Provider.of<UserIngredientController>(context,
                                          listen: false)
                                      .ingredientID[index]);
                          Navigator.pop(context);
                        },
                        leading: Image.network(
                            Provider.of<UserIngredientController>(context)
                                .ingredients[index]
                                .image),
                        trailing: Text(
                            Provider.of<UserIngredientController>(context)
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
