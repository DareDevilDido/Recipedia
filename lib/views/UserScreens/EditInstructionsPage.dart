import 'package:flutter/material.dart';
import '../../Constants/Constants.dart';
import '../Widgets/roundedbutton.dart';

class EditInstructionPage extends StatelessWidget {
  const EditInstructionPage({super.key});
  static const String id = "EditInstructionPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favroites"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {},
                    decoration:
                        kinputDecoration.copyWith(hintText: "Instruction Name"),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {},
                    decoration:
                        kinputDecoration.copyWith(hintText: "Instruction Body"),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                            color: Colors.red,
                            text: 'Delete',
                            onPressed: () {
                              // Navigator.pushNamed(context, LoginScreen.id);
                            }),
                        RoundedButton(
                            color: kPrimaryColor,
                            text: 'Save',
                            onPressed: () {
                              // Navigator.pushNamed(context, LoginScreen.id);
                            })
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
