import 'package:flutter/material.dart';
import 'ImageStyling.dart';

class RecipeListTile extends StatelessWidget {
  String imageName;
  String trialing;
  String title;
  String subtitle;

  RecipeListTile(
      {super.key, required this.imageName,
      required this.title,
      required this.subtitle,
      required this.trialing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: ImageStyling(
          ImageURL: imageName,
          height: 100,
          width: 100,
        ),
        trailing: Text(trialing),
      ),
    );
  }
}
