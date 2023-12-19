import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:recipedia/Screens/DefaultRecipePage.dart';
import 'package:recipedia/Screens/MyRecipePage.dart';
import 'package:recipedia/Screens/ProfilePage.dart';
import '../Constants/Constants.dart';
import '../Screens/FavroitesPage.dart';
import '../Screens/HomePage.dart';

class NavigationsBar extends StatefulWidget {
  const NavigationsBar({super.key});

  @override
  State<NavigationsBar> createState() => _NavigationsBarState();
}

class _NavigationsBarState extends State<NavigationsBar> {
  final List<Widget> _pages = [
    const FavroitesPage(),
    const MyRecipesPage(),
    const HomePage(),
    const DefaultRecipePage(),
    ProfilePage()
  ];

  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: kBackGroundColor,
          buttonBackgroundColor: const Color(0xfff45d2c),
          animationDuration: const Duration(milliseconds: 350),
          color: kPrimaryColor,
          height: 55,
          onTap: (pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          index: index,
          items: const [
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(Icons.my_library_add, color: Colors.white),
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.receipt_long, color: Colors.white),
            Icon(Icons.person, color: Colors.white)
          ]),
    );
  }
}
