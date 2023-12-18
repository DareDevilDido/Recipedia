import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/Timer.dart';
import '../Widgets/LineDivider.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../Widgets/LoadingScreen.dart';

class PlayDefaultRecipePage extends StatefulWidget {
  static const String id = "PlayRecipePage";
  String RecipeId;
  PlayDefaultRecipePage({super.key, required this.RecipeId});

  @override
  State<PlayDefaultRecipePage> createState() => _PlayDefaultRecipePageState();
}

class _PlayDefaultRecipePageState extends State<PlayDefaultRecipePage> {
  FlutterTts fluttertts = FlutterTts();
  Future<void> speak(text) async {
    fluttertts.speak(text);
  }

  Future<void> stop() async {
    fluttertts.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<DefaultRecipesController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      Provider.of<DefaultRecipesController>(context, listen: false)
          .restartStep();
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> valueList = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
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
                          Provider.of<DefaultRecipesController>(context)
                              .Recipe!
                              .Image)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              Provider.of<DefaultRecipesController>(context)
                                  .Recipe!
                                  .Name,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const LineDivider(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: DropdownButton<int>(
                                value: Provider.of<CountDownTimer>(context)
                                    .currentValue,
                                items: valueList
                                    .map((item) => DropdownMenuItem<int>(
                                        value: item,
                                        child: Text(item.toString())))
                                    .toList(),
                                onChanged: (selected) => setState(() =>
                                    Provider.of<CountDownTimer>(context,
                                            listen: false)
                                        .currentValue = selected!.toInt()),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                  "${Provider.of<CountDownTimer>(context).minutes.toString()}:${Provider.of<CountDownTimer>(context).seconds.toString()}",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child:
                                    Icon(Icons.refresh, color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<CountDownTimer>(context,
                                          listen: false)
                                      .ResetTimer(Provider.of<CountDownTimer>(
                                              context,
                                              listen: false)
                                          .currentValue);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Icon(Icons.play_arrow,
                                    color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<CountDownTimer>(context,
                                          listen: false)
                                      .StartTimer(Provider.of<CountDownTimer>(
                                              context,
                                              listen: false)
                                          .currentValue);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Icon(Icons.pause, color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<CountDownTimer>(context,
                                          listen: false)
                                      .pauseTimer();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const LineDivider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Icon(Icons.arrow_back,
                                    color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<DefaultRecipesController>(context,
                                          listen: false)
                                      .backStep();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child:
                                    Icon(Icons.refresh, color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<DefaultRecipesController>(context,
                                          listen: false)
                                      .restartStep();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Icon(Icons.arrow_forward,
                                    color: kPrimaryColor),
                                onTap: () {
                                  Provider.of<DefaultRecipesController>(context,
                                          listen: false)
                                      .addStep();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const LineDivider(),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            Provider.of<DefaultRecipesController>(context)
                                .Recipe!
                                .ingredients
                                .length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                Provider.of<DefaultRecipesController>(context)
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child:
                                Icon(Icons.volume_down, color: kPrimaryColor),
                            onTap: () {
                              speak(Provider.of<DefaultRecipesController>(
                                      context,
                                      listen: false)
                                  .insrtuctions[
                                      Provider.of<DefaultRecipesController>(
                                              context,
                                              listen: false)
                                          .currentStep]
                                  .Description);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child:
                                Icon(Icons.volume_mute, color: kPrimaryColor),
                            onTap: () {
                              stop();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: Colors.orange.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              Provider.of<DefaultRecipesController>(context).insrtuctions[Provider.of<DefaultRecipesController>(context, listen: false).currentStep].Description),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          );
  }
}
