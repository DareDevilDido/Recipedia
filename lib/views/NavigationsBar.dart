
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:recipe_widget/views/HomePage.dart';
import 'package:recipe_widget/views/ProfilePage.dart';
import 'package:recipe_widget/views/Saved_Recipes.dart';
import 'package:recipe_widget/views/search_for_recipe.dart';



class NavigationsBar extends StatefulWidget {
  const NavigationsBar({super.key});

  @override
  State<NavigationsBar> createState() => _NavigationsBarState();
}

class _NavigationsBarState extends State<NavigationsBar> {
  final List<Widget> _pages = [
    const HomePage(),const Saved_Recipes(),const search_for_recipe(),const ProfilePage()

  ];
  //the page that's gonna show first
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 350),
          color: Colors.blue,
          height: 55,
          onTap: (pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          index: index,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.bookmark_outline_outlined),
              label: 'Saved Recipes',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.add_outlined),
              label: 'Search',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity),
              label: 'Personal',
            ),
          ]
      ),
    );
  }
}