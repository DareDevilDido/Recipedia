import 'package:flutter/material.dart';
import 'package:recipe_widget/views/widgets/compact_recipe_card.dart';
import 'package:recipe_widget/views/widgets/category_button.dart';
import 'package:recipe_widget/views/widgets/recipe_of_the_day.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false, // Add this line
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, User!',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'What are you cooking today?',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              // Replace with user's profile pic
              backgroundImage: AssetImage('assets/profile_pic.png'),
              radius: 20,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryButton(title: 'Cat1', isSelected: true),
                  CategoryButton(title: 'Cat2'),
                  CategoryButton(title: 'Cat3'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CompactRecipeCard(
                      image: 'assets/lunch1.jpg',
                      rating: 4.5,
                      recipeName: 'Recipe $index',
                      timeNeeded: '30 mins',
                      onSave: () {
                        // Implement save functionality
                      },
                    ),
                  );
                },
              ),
            ),
            const RecipeOfTheDay(),
          ],
        ),
      ),
    );

  }
}
