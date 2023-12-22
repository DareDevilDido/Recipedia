import 'package:flutter/material.dart';

class CompactRecipeCard extends StatelessWidget {
  final String image;
  final double rating;
  final String recipeName;
  final String timeNeeded;
  final Function onSave;

  const CompactRecipeCard({super.key, 
    required this.image,
    required this.rating,
    required this.recipeName,
    required this.timeNeeded,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // Adjust the width as per your preference
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100, // Adjust the image container height
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text('$rating'),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          onSave();
                        },
                        icon: const Icon(Icons.save),
                      ),
                    ],
                  ),
                  Text(
                    recipeName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    timeNeeded,
                    style: const TextStyle(color: Colors.grey),
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
