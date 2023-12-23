import 'package:flutter/material.dart';
import '../RecipePage.dart'; // Import your recipe page file

class RecipeOfTheDay extends StatelessWidget {
  const RecipeOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    const String recipeOfTheDayImage = 'assets/meat.png'; // Replace with your image
    const double recipeOfTheDayRating = 4.8; // Replace with your rating
    const String recipeOfTheDayName = 'Recipe of the Day'; // Replace with the name
    const String recipeOfTheDayTime = '45 mins'; // Replace with the time needed

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecipePage()), // Navigate to RecipePage
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Recipe of the Day',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 200,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(recipeOfTheDayImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 4),
                              Text('$recipeOfTheDayRating'),
                            ],
                          ),
                          Text(
                            recipeOfTheDayName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(recipeOfTheDayTime),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
