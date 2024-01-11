import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;

  const RecipeDetailsPage({super.key, 
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Cook Time: $cookTime'),
            const SizedBox(height: 10),
            Text('Rating: $rating'),
            const SizedBox(height: 10),
            Image.network(thumbnailUrl),
          ],
        ),
      ),
    );
  }
}