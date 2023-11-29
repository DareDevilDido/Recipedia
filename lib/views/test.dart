import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;

  RecipeDetailsPage({
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Cook Time: $cookTime'),
            SizedBox(height: 10),
            Text('Rating: $rating'),
            SizedBox(height: 10),
            Image.network(thumbnailUrl),
          ],
        ),
      ),
    );
  }
}