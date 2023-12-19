import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:recipedia/Controllers/UserRecipesController.dart';
import 'package:recipedia/Screens/EditRecipePage.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/Timer.dart';
import '../Widgets/LineDivider.dart';
import '../Widgets/LoadingScreen.dart';

class UserViewRecipePage extends StatefulWidget {
  static const String id = "UserViewRecipePage";
  String RecipeId;
  bool islistening = true;
  bool timerWorking = true;
  UserViewRecipePage({super.key, required this.RecipeId});

  @override
  State<UserViewRecipePage> createState() => _USerViewRecipePageState();
}

class _USerViewRecipePageState extends State<UserViewRecipePage> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Provider.of<Loading>(context, listen: false).changeBool();
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<UserRecipesController>(context, listen: false)
          .getSingleRecipe(kUserId, widget.RecipeId);
      Future.delayed(const Duration(milliseconds: 1)).then((_) async {
        setState(() {
          Provider.of<Loading>(context, listen: false).changeBool();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterTts fluttertts = FlutterTts();

    Future<void> speak(text) async {
      fluttertts.speak(text);
    }

    Future<void> stop() async {
      fluttertts.stop();
    }

    List<int> valueList = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
    return Provider.of<Loading>(context, listen: true).kIsLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: kBackGroundColor,
            appBar: AppBar(
              title: const Text("Recipe"),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: const Icon(Icons.edit),
                    onTap: () async {
                      bool refresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  EditRecipePage(RecipeId: widget.RecipeId)));
                      if (refresh) {
                        await Provider.of<UserRecipesController>(context,
                                listen: false)
                            .getSingleRecipe(kUserId, widget.RecipeId);
                      }
                    },
                  ),
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
              color: kBackGroundColor,
              child: ListView(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        Image.network(
                          Provider.of<UserRecipesController>(context)
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
                                          "Time: ${Provider.of<UserRecipesController>(context).Recipe!.time}",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 8),
                                        child: Text(
                                          "${Provider.of<UserRecipesController>(context).Recipe!.Servings} Servings",
                                          style: TextStyle(
                                              color: kPrimaryColor,
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
                                              Provider.of<UserRecipesController>(context).Recipe!.Name,
                                              style: TextStyle(
                                                  color: kButtonColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              Provider.of<UserRecipesController>(context).Recipe!.Category,
                                              style: TextStyle(
                                                  color: kButtonColor,
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
                                          "${Provider.of<UserRecipesController>(context).Recipe!.nutrition} Kcal",
                                          style: TextStyle(
                                              color: kPrimaryColor,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                    child: Text("Ingredients",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<UserRecipesController>(context)
                            .Recipe!
                            .ingredients
                            .length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  Provider.of<UserRecipesController>(context)
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                        child: Text("Timer",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: kPrimaryColor,
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
                        child: Icon(Icons.refresh, color: kPrimaryColor),
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
                              color: kPrimaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      widget.timerWorking
                          ? GestureDetector(
                              child: Icon(Icons.timer, color: kPrimaryColor),
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
                                  Icon(Icons.stop_circle, color: kPrimaryColor),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                    child: Text("Instructions",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                        itemCount: Provider.of<UserRecipesController>(context)
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
                                                "${Provider.of<UserRecipesController>(context).insrtuctions[index].Step}. "),
                                          ),
                                          Container(
                                            child: const Text(""),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.61,
                                        child: Text(
                                          Provider.of<UserRecipesController>(context).insrtuctions[index].Description,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: widget.islistening
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.only(right: 10),
                                                child: GestureDetector(
                                                  child: const Icon(Icons.volume_down,
                                                      color: Colors.white),
                                                  onTap: () {
                                                    speak(Provider.of<
                                                                UserRecipesController>(
                                                            context,
                                                            listen: false)
                                                        .insrtuctions[Provider.of<
                                                                    UserRecipesController>(
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
                                                padding:
                                                    const EdgeInsets.only(right: 10),
                                                child: GestureDetector(
                                                  child: const Icon(Icons.volume_mute,
                                                      color: Colors.white),
                                                  onTap: () {
                                                    stop();
                                                    setState(() {
                                                      print("object");
                                                      widget.islistening =
                                                          true;
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
            ));
  }
}
