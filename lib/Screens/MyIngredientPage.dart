import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:provider/provider.dart';
import '../Controllers/UserIngredientsController.dart';
import '../Widgets/LoadingScreen.dart';
import 'CreateIngredientPage.dart';
import 'EditIngredientPage.dart';

class MyIngredientPage extends StatefulWidget {
  static const String id = "MyIngredientPage";

  const MyIngredientPage({super.key});

  @override
  State<MyIngredientPage> createState() => _MyIngredientPageState();
}

class _MyIngredientPageState extends State<MyIngredientPage> {
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
  Widget build(BuildContext context) =>
      Provider.of<Loading>(context, listen: true).kIsLoading
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: kBackGroundColor,
              appBar: AppBar(
                  title: const Text("My Ingredients"),
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
                                builder: (_) => const CreateIngredientPage(),
                              ));
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
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount:
                              Provider.of<UserIngredientController>(context)
                                  .ingredients
                                  .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await Provider.of<UserIngredientController>(
                                          context,
                                          listen: false)
                                      .getIngredientById(
                                          kUserId,
                                          Provider.of<UserIngredientController>(
                                                  context,
                                                  listen: false)
                                              .ingredients[index]
                                              .ID!);
                                  bool refresh = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditIngredientPage(
                                            RecipeId: Provider.of<
                                                        UserIngredientController>(
                                                    context)
                                                .ingredients[index]
                                                .ID!),
                                      ));
                                  if (refresh) {
                                    await Provider.of<UserIngredientController>(
                                            context,
                                            listen: false)
                                        .getIngredients(kUserId);
                                  }
                                },
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          Provider.of<UserIngredientController>(
                                                  context)
                                              .ingredients[index]
                                              .image,
                                          height: 110,
                                          width: 110,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Container(),
                                          Container(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0, top: 8),
                                              child: Text(
                                                Provider.of<UserIngredientController>(
                                                        context)
                                                    .ingredients[index]
                                                    .Name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
