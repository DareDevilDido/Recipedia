import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:recipedia/AdminScreens/adminRecipe.dart';
import 'package:recipedia/AdminScreens/adminUser.dart';
import 'package:recipedia/AdminScreens/AdminProfilePage.dart';
import 'package:recipedia/AdminScreens/top10recipes.dart';

import '../Constants/Constants.dart';

class adminNavigationsBar extends StatefulWidget {
  const adminNavigationsBar({super.key});

  @override
  State<adminNavigationsBar> createState() => _adminNavigationsBarState();
}

class _adminNavigationsBarState extends State<adminNavigationsBar> {
  final List<Widget> _pages = [
    const AdminRecipe(),
    const AdminUser(),
    const top10RecipesPage(),
     AdminProfilePage()
     
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.deepOrange,
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
            Icon(Icons.receipt_long, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
            Icon(Icons.receipt, color: Colors.white),
            Icon(Icons.admin_panel_settings, color: Colors.white)
            
          ]),
    );
  }
}
