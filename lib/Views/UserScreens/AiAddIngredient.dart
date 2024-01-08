import 'dart:convert';
import '../Widgets/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Screens/askAIPage.dart';
import 'package:http/http.dart' as http;

class IngredientInputWidget extends StatefulWidget {
  @override
  _IngredientInputWidgetState createState() => _IngredientInputWidgetState();
}

class _IngredientInputWidgetState extends State<IngredientInputWidget> {
  TextEditingController _ingredientController = TextEditingController();
  List<String> inputTags = [];
  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    String ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        inputTags.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _deleteTag(int index) {
    setState(() {
      inputTags.removeAt(index);
    });
  }

  String getIngredientsAsString() {
    return inputTags.join('\n '); // Use a endline (\n) as a separator
  }

  String Recipe = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Create Recipe Using AI',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: GestureDetector(
        //       child:
        //           const Icon(Icons.switch_access_shortcut, color: Colors.white),
        //       onTap: () {
        //         setState(() {
        //           const ChatPage();
        //         });
        //       },
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: _ingredientController,
              decoration: const InputDecoration(
                labelText: 'Enter Ingredient',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addIngredient(),
            ),
            const SizedBox(height: 16.0),
            RoundedButton(
              onPressed: _addIngredient,
              color: Color.fromARGB(255, 193, 103, 148),
              text: 'Add Ingredient',
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: inputTags
                  .asMap()
                  .entries
                  .map(
                    (MapEntry<int, String> entry) => Chip(
                      label: Text(entry.value),
                      onDeleted: () => _deleteTag(entry.key),
                    ),
                  )
                  .toList(),
            ),
            Text(Recipe),
            Container(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                    color: const Color.fromARGB(255, 55, 143, 23),
                    text: 'Create Recipe',
                    onPressed: () => _sendIngredientsToAPI())),
          ],
        ),
      ),
    );
  }

  Future<String> fetchResponseFromAPI(List<String> ingredients) async {
    String fullPrompt =
        "Using some or all of the given ingredients, create me a recipe and give me the following information:\nRecipe Name\nPreparation Time (minutes in multiples of 5)\nIngredients\nStep-by-step Instructions\nThe ingredients are:${getIngredientsAsString()}";

    final response = await http.post(
      Uri.parse(OPENAI_API_ENDPOINT),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $OPENAI_API_KEY',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo-instruct",
        "prompt": fullPrompt,
        "max_tokens": 250,
        "temperature": 0,
        "top_p": 1,
      }),
    );
    setState(() {
      Recipe = response.body;
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  void _sendIngredientsToAPI() {
    final ingredients =
        inputTags; // Get the list of ingredients from your state

    // Show a loading indicator while waiting for the API response
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Creating recipe..."),
          ],
        ),
      ),
    );
    fetchResponseFromAPI(ingredients).then((response) {
      // Parse and process the response as needed
      print('API Response: $response');
      // Update your UI with the response data (e.g., set the Recipe state)
      setState(() {
        Recipe = response.toString();
      });
      // Hide the loading indicator
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }).catchError((error) {
      // Handle network issues or API errors
      print('Error: $error');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create a recipe. Please try again later.'),
        ),
      );
    });
  }
}
