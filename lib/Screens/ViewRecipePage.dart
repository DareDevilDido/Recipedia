import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:recipedia/Controllers/FavroiteRecipeController.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Controllers/UserIngredientsController.dart';
import '../Models/Timer.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Widgets/video.dart';

class ViewRecipePage extends StatefulWidget {
  static const String id = "ViewRecipePage";
  String RecipeId;
  ViewRecipePage({super.key, required this.RecipeId});

  // String videoPlayer=" ";
  bool islistening = true;
  bool timerWorking = true;

  @override
  State<ViewRecipePage> createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {
  var videoID;

  @override
  void initState() {
    setState(() {
      setState(() {
        Provider.of<Loading>(context, listen: false).changeBool();
      });
    });

    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserIngredientController>(context, listen: false)
          .getIngredients(kUserId);
      await Provider.of<FavortieRecipesController>(context, listen: false)
          .CheckIfFavorited(widget.RecipeId);
      await Provider.of<DefaultRecipeController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      Future.delayed(const Duration(milliseconds: 100)).then((_) async {
        setState(() {
          Provider.of<Loading>(context, listen: false).changeBool();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> valueList = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
    bool checking = Provider.of<FavortieRecipesController>(context).isFavorited;

    YoutubePlayerController controller;
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Recipe",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: Icon(
                        Provider.of<FavortieRecipesController>(context)
                                .isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.black),
                    onTap: () {
                      !checking
                          ? Provider.of<FavortieRecipesController>(context,
                                  listen: false)
                              .AddRecipe(widget.RecipeId)
                          : Provider.of<FavortieRecipesController>(context,
                                  listen: false)
                              .DeleteRecipe(widget.RecipeId);
                      Provider.of<FavortieRecipesController>(context,
                              listen: false)
                          .CheckIfFavorited(widget.RecipeId);
                      // Navigator.pushNamed(context, SearchPage.id);
                    },
                  ),
                )
              ],
              backgroundColor: kPrimaryColor,
            ),
            body: Container(
              padding: const EdgeInsets.only(
                  bottom: 20, right: 10, left: 10, top: 10),
              color: kBackGroundColor,
              child: ListView(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        Image.network(
                          Provider.of<DefaultRecipeController>(context)
                              .Recipe!
                              .Image,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Text(
                                          "Time: ${Provider.of<DefaultRecipeController>(context).Recipe!.time}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 8),
                                        child: Text(
                                          "${Provider.of<DefaultRecipeController>(context).Recipe!.Servings} Servings",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(),
                              Container(),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Provider.of<DefaultRecipeController>(
                                                      context)
                                                  .Recipe!
                                                  .Name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              Provider.of<DefaultRecipeController>(
                                                      context)
                                                  .Recipe!
                                                  .Category,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          "${Provider.of<DefaultRecipeController>(context).Recipe!.nutrition} Kcal",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const LineDivider(),
                  Center(
                    child: Container(
                        width: 300,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: VideoPage(Videotool(
                            Provider.of<DefaultRecipeController>(context)
                                .Recipe!
                                .VideoLink))),
                  ),
                  const LineDivider(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0, left: 8),
                    child: Text("Ingredients",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<DefaultRecipeController>(context)
                            .Recipe!
                            .ingredients
                            .length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  Provider.of<DefaultRecipeController>(context)
                                      .Recipe!
                                      .ingredients[index]
                                      .image,
                                  width: 75,
                                  fit: BoxFit.cover,
                                  height: 75,
                                ),
                              ));
                        }),
                  ),
                  const LineDivider(),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0, left: 8),
                        child: Text("Timer",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: DropdownButton<int>(
                          value:
                              Provider.of<CountDownTimer>(context).currentValue,
                          items: valueList
                              .map((item) => DropdownMenuItem<int>(
                                  value: item, child: Text(item.toString())))
                              .toList(),
                          onChanged: (selected) => setState(() =>
                              Provider.of<CountDownTimer>(context,
                                      listen: false)
                                  .currentValue = selected!.toInt()),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.refresh, color: Colors.black),
                        onTap: () {
                          Provider.of<CountDownTimer>(context, listen: false)
                              .ResetTimer(Provider.of<CountDownTimer>(context,
                                      listen: false)
                                  .currentValue);
                        },
                      ),
                      Text(
                          "${Provider.of<CountDownTimer>(context).minutes.toString()}:${Provider.of<CountDownTimer>(context).seconds.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      widget.timerWorking
                          ? GestureDetector(
                              child: Icon(Icons.timer, color: Colors.black),
                              onTap: () {
                                Provider.of<CountDownTimer>(context,
                                        listen: false)
                                    .StartTimer(Provider.of<CountDownTimer>(
                                            context,
                                            listen: false)
                                        .currentValue);
                                setState(() {
                                  widget.timerWorking = false;
                                });
                              },
                            )
                          : GestureDetector(
                              child:
                                  Icon(Icons.stop_circle, color: Colors.black),
                              onTap: () {
                                Provider.of<CountDownTimer>(context,
                                        listen: false)
                                    .pauseTimer();
                                setState(() {
                                  widget.timerWorking = true;
                                });
                              },
                            ),
                    ],
                  ),
                  const LineDivider(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0, left: 8),
                    child: Text("Instructions",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                                "${Provider.of<DefaultRecipeController>(context).insrtuctions[index].Step}. ",
                                                style: TextStyle(
                                                    color: kTextColor)),
                                          ),
                                          Container(
                                            child: Text("",
                                                style: TextStyle(
                                                    color: kTextColor)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.61,
                                        child: Text(
                                          Provider.of<DefaultRecipeController>(
                                                  context)
                                              .insrtuctions[index]
                                              .Description,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: widget.islistening
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: GestureDetector(
                                                  child: const Icon(
                                                      Icons.volume_down,
                                                      color: Colors.black),
                                                  onTap: () {
                                                    speak(Provider.of<
                                                                DefaultRecipeController>(
                                                            context,
                                                            listen: false)
                                                        .insrtuctions[Provider.of<
                                                                    DefaultRecipeController>(
                                                                context,
                                                                listen: false)
                                                            .currentStep]
                                                        .Description);
                                                    setState(() {
                                                      print("object");
                                                      widget.islistening =
                                                          false;
                                                    });
                                                  },
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: GestureDetector(
                                                  child: const Icon(
                                                      Icons.volume_mute,
                                                      color: Colors.black),
                                                  onTap: () {
                                                    stop();
                                                    setState(() {
                                                      print("object");
                                                      widget.islistening = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
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
}

String? Videotool(String videoUrl) {
  final videoID = YoutubePlayer.convertUrlToId(videoUrl);

  return videoID;
}

FlutterTts fluttertts = FlutterTts();

Future<void> speak(text) async {
  fluttertts.speak(text);
}

Future<void> stop() async {
  fluttertts.stop();
}