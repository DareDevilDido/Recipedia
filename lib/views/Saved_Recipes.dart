import 'package:flutter/material.dart';
import 'package:recipe_widget/views/widgets/recipe_card.dart';


class Saved_Recipes extends StatefulWidget {
  @override
  _Saved_RecipesState createState() => _Saved_RecipesState();
}

class _Saved_RecipesState extends State<Saved_Recipes> {
   Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu,color: Colors.black,),
              SizedBox(width: 10),
              Text('Saved Recipes', style: TextStyle(
              color: Colors.black)
              ),
              

            ],
          ),
        ),
        body:SingleChildScrollView(
          child:Column(
        children:[ RecipeCard(
          title: 'Burger',
          rating: '4.9',
          cookTime: '45 min',
          thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
          chefName: 'mohamed',
        ),RecipeCard(
          title: 'Ramen',
          rating: '4.0',
          cookTime: '60 min',
          thumbnailUrl: 'https://thecozycook.com/wp-content/uploads/2023/02/Homemade-Ramen-1-.jpg',
          chefName: 'Abdelrahman',
        ),RecipeCard(
          title: 'Burger',
          rating: '4.9',
          cookTime: '45 min',
          thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
         chefName: 'Abdelrahman'
        ),RecipeCard(
          title: 'Burger',
          rating: '4.9',
          cookTime: '45 min',
          thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
           chefName: 'Abdelrahman'
        )
        ]
        ),
        ),
    );
  }
}