
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:recipe_widget/views/ProfilePage.dart';
import 'package:recipe_widget/views/Saved_Recipes.dart';
import 'package:recipe_widget/views/search_for_recipe.dart';



class NavigationsBar extends StatefulWidget {
  @override
  State<NavigationsBar> createState() => _NavigationsBarState();
}

class _NavigationsBarState extends State<NavigationsBar> {
  final List<Widget> _pages = [
    Saved_Recipes(),search_for_recipe(),ProfilePage()

  ];
  //the page it gonna show first
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 350),
          color: Colors.deepOrange,
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