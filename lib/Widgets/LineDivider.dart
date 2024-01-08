import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 3, // thickness of the line
      indent: 20, // empty space to the leading edge of divider.
      endIndent: 20, // empty space to the trailing edge of the divider.
      color: Color.fromARGB(
          255, 163, 101, 132), // The color to use when painting the line.
      height: 25, // The divider's height extent.
    );
  }
}
