import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import '../../Controllers/DafualtRecipesController.dart';
import '../Widgets/LoadingScreen.dart';
import 'ViewRecipeFromDefualtList.dart';
//categories of Default Recipes
class ViewDefaultRecipeListPage extends StatefulWidget {
  String Category;
  ViewDefaultRecipeListPage({super.key, required this.Category});
  static const String id = "ViewDefaultRecipeListPage";

  @override
  State<ViewDefaultRecipeListPage> createState() =>
      _ViewDefaultRecipeListPageState();
}

class _ViewDefaultRecipeListPageState extends State<ViewDefaultRecipeListPage> {
  @override
  void initState() {
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<DefaultRecipeController>(context, listen: false)
          .FilterCategory(widget.Category);
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
              appBar: AppBar(
                title: Text(widget.Category, style: TextStyle(color: kTextColor),),
                centerTitle: true,
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
                              Provider.of<DefaultRecipeController>(context)
                                  .Recipes
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
                                                            DefaultRecipeController>(
                                                        context)
                                                    .Recipes[index]
                                                    .ID,
                                              )));
                                },
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          Provider.of<DefaultRecipeController>(
                                                  context)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(),
                                        Container(
                                          height: 65,
                                          color: Colors.black.withOpacity(0.5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            Provider.of<DefaultRecipeController>(
                                                    context)
                                                .Recipes[index]
                                                .Name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: kTextColor),
                                          ),
                                        ),
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
