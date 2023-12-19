
import 'package:flutter/material.dart';
import '../Constants/Constants.dart';
import '../Widgets/LineDivider.dart';

class CookRecipePage extends StatelessWidget {
  const CookRecipePage({super.key});
  static const String id = "CookRecipePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'images/Bahrain-Machboos.jpg',
                  width: double.infinity,
                  fit: BoxFit.fill,
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Spicy GlutenFree Chicken",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Icon(Icons.favorite, color: kPrimaryColor),
                            onTap: () {
                              // Navigator.pushNamed(context, SearchPage.id);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Icon(Icons.play_arrow, color: kPrimaryColor),
                            onTap: () {
                              // Navigator.pushNamed(context, SearchPage.id);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.red,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "nutrition   3000",
                        maxLines: 2,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: kPrimaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "Category \t\t\t  Deserts",
                        maxLines: 2,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: kButtonColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "Time \t\t\t\t  4h30m",
                        maxLines: 2,
                        style: TextStyle(
                            color: kButtonColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.green,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "Servings   \t  \t 10",
                        maxLines: 2,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const LineDivider(),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("images/carrots.png"),
                    minRadius: 40,
                  ),
                ],
              ),
            ),
            const LineDivider(),
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.orange.shade50,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                                "Step 1: Muddle 4 blackberries in the bottom of a microwave-safe glass serving jar. Add chile powder and red pepper flakes, then maple syrup; stir syrup briskly until well combined."),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.orange.shade50,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                                "Step 2: Place chicken in a large, shallow baking dish. Drizzle with orange juice and season liberally with salt and pepper. Refrigerate until needed. Whisk orange zest with coconut flour, almond flour, garlic, and paprika. Set dredging mixture aside."),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.orange.shade50,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                                "Step 3: Mix gluten-free flour, baking powder, rosemary, thyme, and sea salt together in another bowl to start the waffle batter."),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
