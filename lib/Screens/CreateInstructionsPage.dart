import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Repo/InstructionRepo.dart';
import 'package:provider/provider.dart';
import '../Constants/Constants.dart';
import '../Models/Recipe.dart';
import '../Widgets/MessagePrompt.dart';
import '../Widgets/roundedbutton.dart';

class CreateInstructionPage extends StatelessWidget {
  const CreateInstructionPage({super.key});
  static const String id = "CreateInstructionPage";

  @override
  Widget build(BuildContext context) {
    String description = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Instrcution"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      description = value;
                    },
                    minLines: 15,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration:
                        kinputDecoration.copyWith(hintText: "Instruction Body"),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedButton(
                        color: kPrimaryColor,
                        text: 'Save',
                        onPressed: () {
                          if (description != "") {
                            var instruction = InstructionsRepo(
                                ID: "",
                                Description: description,
                                Step:
                                    (Provider.of<Recipe>(context, listen: false)
                                                .insrtuctions
                                                .length +
                                            1)
                                        .toString());
                            Provider.of<Recipe>(context, listen: false)
                                .addInstructionsToList(instruction);
                            Navigator.pop(context);
                          } 
                          else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(MessagePrompt().snack("Error",
                                  "Instruction is empty", ContentType.failure));
                          }
                        }),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}


// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:recipedia/Repo/InstructionRepo.dart';
// import 'package:provider/provider.dart';
// import '../Constants/Constants.dart';
// import '../Models/Recipe.dart';
// import '../Widgets/MessagePrompt.dart';
// import '../Widgets/roundedbutton.dart';

// class CreateInstructionPage extends StatefulWidget {
//   const CreateInstructionPage({required Key key}) : super(key: key);
//   static const String id = "CreateInstructionPage";

//   @override
//   _CreateInstructionPageState createState() => _CreateInstructionPageState();
// }

// class _CreateInstructionPageState extends State<CreateInstructionPage> {
//   String description = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Instruction"),
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: <Widget>[
//             ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               children: <Widget>[
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       description = value;
//                     });
//                   },
//                   minLines: 15,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: null,
//                   decoration: kinputDecoration.copyWith(hintText: "Instruction Body"),
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RoundedButton(
//                     color: kPrimaryColor,
//                     text: 'Save',
//                     onPressed: () {
//                       if (description.trim().isNotEmpty) {
//                         var instruction = InstructionsRepo(
//                           ID: "",
//                           Description: description,
//                           Step:
//                                     (Provider.of<Recipe>(context, listen: false)
//                                                 .insrtuctions
//                                                 .length +
//                                             1)
//                                         .toString());
//                         Provider.of<Recipe>(context, listen: false).addInstructionsToList(instruction);
//                         Navigator.pop(context);
//                       } else {
//                         ScaffoldMessenger.of(context)
//                           ..hideCurrentSnackBar()
//                           ..showSnackBar(MessagePrompt().snack("Error", "Instruction is empty", ContentType.failure));
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }