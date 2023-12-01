import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:recipe_widget/views/NavigationsBar.dart';
//import 'HOMEPAGE.dart';                                   //<- Home Page (ALSO LINE 78)
//import 'package:image_picker/image_picker.dart';          //<- Will use later to import the Recipes image

// ignore: must_be_immutable
class RecipeAdder extends StatelessWidget {
  RecipeAdder({super.key});
  List icon = ['dough-rolling', 'cheese', 'meat', 'sausage'];
  List value = ['250g', '120g', '100g', '50g'];
  List name = ['Dough', 'Cheese', 'Meat', 'Sausage'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              expandedHeight: 400,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/lunch1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: 80,
                        height: 4,
                        color: font,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(250, 250, 250, 0.6),
                    radius: 18,
                    child: Icon(
                      Icons.favorite_border,
                      size: 25,
                      color: font,
                    ),
                  ),
                ),
              ],
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(250, 250, 250, 0.6),
                  radius: 18,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return NavigationsBar();                  //<- Home Page when done (REPLACE "HOMEPAGE") 
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: font,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _getbody(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getbody() {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(height: 15),
                      Text(
                        '1hr', //fetch preparation duration from DB =====================
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: 'ro',
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.fastfood),
                      SizedBox(height: 15),
                      Text(
                        'Lunch', //fetch category from DB ==============================
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: 'ro',
                        ),
                      ),
                  ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.star),
                      SizedBox(height: 15),
                      Text(
                        '4.4', //fetch rating from DB ==================================
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: 'ro',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Padding( //Ingredient Section ====================================
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'ingredients', 
                      style: TextStyle(
                        fontSize: 20,
                        color: font,
                        fontFamily: 'ro',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              SingleChildScrollView( //Ingredients Scroll view
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            height: 80,
                            width: 360,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(230, 230, 230, 1),
                              borderRadius: BorderRadius.circular(12),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    height: 70,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius:BorderRadius.all(Radius.circular(10)),
                                      ),
                                    child: 
                                      Image.asset('assets/${icon[index]}.png'),
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      name[index],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: font,
                                        fontFamily: 'ro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      value[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: font,
                                        fontFamily: 'ro',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Padding( //Procedure Section ====================================
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'Procedure',
                      style: TextStyle(
                        fontSize: 20,
                        color: font,
                        fontFamily: 'ro',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              ...List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 360,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: Column(
                        children: [
                          Text(
                            'Step ${index+1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          Text(
                            'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum dolore eu fugiat nulla pariatur?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: font,
                              fontFamily: 'ro',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              
              const SizedBox(height: 20),
              Padding( //Nutrition Section ====================================
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'Nutrition',
                      style: TextStyle(
                        fontSize: 20,
                        color: font,
                        fontFamily: 'ro',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Calories: 1691 \nFat: 65 grams \nCarbs: 211 grams \nFiber: 12 grams \nSugars: 60 grams \nProtein: 65 grams",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: font,
                      fontFamily: 'ro',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}