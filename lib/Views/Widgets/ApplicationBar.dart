import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget {
  String Title;
  Color bkColor;
  Widget? leadingWidget;
  List<Widget>? Widgets;

  ApplicationBar(
      {super.key, required this.Title,
      required this.bkColor,
      this.leadingWidget,
      this.Widgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(Title),
      backgroundColor: bkColor,
      centerTitle: true,
      leading: leadingWidget,
      actions: Widgets,
    );
  }
}
