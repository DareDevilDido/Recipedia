import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:provider/provider.dart';
import '../../Controllers/DefaultIngredientController.dart';

class IngredientsPage extends StatefulWidget {
  static const String id = "IngredientsPage";

  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<DefaultIngredientCntroller>(context, listen: false)
          .getIngredients(kUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipedia's Ingredients", style: TextStyle(color: kTextColor),),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: Provider.of<DefaultIngredientCntroller>(context)
                      .ingredients
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: GestureDetector(
                        onTap: () async {},
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                  Provider.of<DefaultIngredientCntroller>(
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
                                    color: Colors.black.withOpacity(0.5),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 8),
                                      child: Text(
                                        Provider.of<DefaultIngredientCntroller>(
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
}
