import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryButton({super.key, 
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement category navigation
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            isSelected ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color.fromARGB(255, 113, 177, 161),
          ),
        ),
      ),
    );
  }
}
