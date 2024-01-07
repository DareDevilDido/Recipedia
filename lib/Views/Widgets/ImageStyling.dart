import 'package:flutter/material.dart';

class ImageStyling extends StatelessWidget {
  final String ImageURL;
  double height;
  double width;
  ImageStyling(
      {super.key, required this.ImageURL, required this.height, required this.width});
//hugjhgghjgfhgdfgkjhgkjh
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Image.asset(
        ImageURL,
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
