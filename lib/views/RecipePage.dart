import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                // Recipe Image
                Image.network(
                  'https://www.shutterstock.com/image-vector/tomato-icon-260nw-231136111.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Timer and Bookmark Icon (positioned at bottom right)
                const Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(width: 5),
                      Icon(Icons.bookmark_border),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recipe Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://www.shutterstock.com/image-vector/tomato-icon-260nw-231136111.jpg'),
                      ),
                      SizedBox(width: 10),
                      Text('Submitted by User'),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Handle like button press
                    },
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Steps'),
                      Tab(text: 'Ingredients'),
                    ],
                  ),
                  SizedBox(
                    height: 300, // Height for TabBarView
                    child: TabBarView(
                      children: [
                        // Steps Tab
                        ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text('Step ${index + 1}'),
                                subtitle: const Text('Step description...'),
                              ),
                            );
                          },
                        ),
                        // Ingredients Tab
                        ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://www.shutterstock.com/image-vector/tomato-icon-260nw-231136111.jpg'),
                                ),
                                title: Text('Ingredient ${index + 1}'),
                                subtitle: const Text('Ingredient weight...'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
