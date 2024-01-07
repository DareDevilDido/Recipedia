import 'package:flutter/material.dart';
import 'package:recipedia/Controllers/UserRecipesController.dart';
import 'package:provider/provider.dart';
import '../../Constants/Constants.dart';
import 'LineDivider.dart';

class SortCategory extends StatefulWidget {
  const SortCategory({
    super.key,
  });

  @override
  State<SortCategory> createState() => _SortCategoryState();
}

class _SortCategoryState extends State<SortCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  if (Provider.of<Loading>(context, listen: false).kCategory ==
                      "Dinner") {
                    await Provider.of<UserRecipesController>(context,
                            listen: false)
                        .getRecipes(kUserId);
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "All";
                    });
                  } else {
                    Provider.of<UserRecipesController>(context, listen: false)
                        .FilterCategory("Dinner");
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "Dinner";
                    });
                  }
                },
                child: Column(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FDinner.jpg?alt=media&token=5c257337-ac9d-4114-984b-392ae64911e7",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Dinner",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (Provider.of<Loading>(context, listen: false).kCategory ==
                      "Breakfast") {
                    await Provider.of<UserRecipesController>(context,
                            listen: false)
                        .getRecipes(kUserId);
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "All";
                    });
                  } else {
                    Provider.of<UserRecipesController>(context, listen: false)
                        .FilterCategory("Breakfast");
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "Breakfast";
                    });
                  }
                },
                child: Column(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FBreakfast.jpg?alt=media&token=f2f335d7-c426-4993-905d-e3ee09b0c047",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "BreakFast",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (Provider.of<Loading>(context, listen: false).kCategory ==
                      "Lunch") {
                    await Provider.of<UserRecipesController>(context,
                            listen: false)
                        .getRecipes(kUserId);
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "All";
                    });
                  } else {
                    Provider.of<UserRecipesController>(context, listen: false)
                        .FilterCategory("Lunch");
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "Lunch";
                    });
                  }
                },
                child: Column(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FLunch.jpg?alt=media&token=b3d36eae-2325-409a-a3ed-86eefc99992d",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Lunch",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (Provider.of<Loading>(context, listen: false).kCategory ==
                      "Sweets") {
                    await Provider.of<UserRecipesController>(context,
                            listen: false)
                        .getRecipes(kUserId);
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "All";
                    });
                  } else {
                    Provider.of<UserRecipesController>(context, listen: false)
                        .FilterCategory("Sweets");
                    setState(() {
                      Provider.of<Loading>(context, listen: false).kCategory =
                          "Sweets";
                    });
                  }
                },
                child: Column(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/finalproject-7fadb.appspot.com/o/DefaultImages%2FDessert.jpg?alt=media&token=374ea6d6-a1ed-428f-b907-0839c13d7924",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Sweets",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            ]),
        const LineDivider(),
        Center(
            child: Text(
          Provider.of<Loading>(context).kCategory,
          style: TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),
        ))
      ],
    );
  }
}
