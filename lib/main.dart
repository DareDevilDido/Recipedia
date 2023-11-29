import 'package:flutter/material.dart';
import 'package:recipe_widget/views/Saved_Recipes.dart';
import 'package:recipe_widget/views/search_for_recipe.dart';
import 'package:recipe_widget/views/search_for_recipe_Recent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Recipe',
      theme: ThemeData(
        primarySwatch:Colors.blue,
        primaryColor:Colors.white,
        textTheme:TextTheme(bodyText2: TextStyle(color:Colors.white),
         
        ),
      
      ),
      home:Saved_Recipes(),
    );
         }
}



