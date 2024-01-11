import 'dart:convert';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Views/UserScreens/askAIPage.dart';
import '../Widgets/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IngredientInputWidget extends StatefulWidget {
  const IngredientInputWidget({super.key});

  @override
  _IngredientInputWidgetState createState() => _IngredientInputWidgetState();
}

class _IngredientInputWidgetState extends State<IngredientInputWidget> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> inputTags = [];

  String Recipe = '';
  String GenerationState = 'Generate Recipe';

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIngredients = prefs.getStringList('ingredients') ?? [];
    final savedRecipe = prefs.getString('recipe') ?? '';

    setState(() {
      inputTags = savedIngredients;
      Recipe = savedRecipe;
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('ingredients', inputTags);
    await prefs.setString('recipe', Recipe);
  }

  void _updateRecipe(String newRecipe) {
    setState(() {
      Recipe = newRecipe;
    });
    _saveData();
  }

  void _resetData() {
    setState(() {
      inputTags.clear();
      Recipe = '';
    });
    _saveData();
  }

  void _addIngredient() {
    String ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        inputTags.add(ingredient);
        _ingredientController.clear();
      });
    }
    _saveData();
  }

  void _deleteTag(int index) {
    setState(() {
      inputTags.removeAt(index);
    });
    _saveData();
  }

  String getIngredientsAsString() {
    return inputTags.join('\n '); // Use a endline (\n) as a separator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Create Recipe Using AI',
          style: TextStyle(color: kTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
                child: const Icon(Icons.switch_access_shortcut),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              style: TextStyle(color: kTextColor),
              controller: _ingredientController,
              decoration: kinputDecoration.copyWith(
                  hintText: "Enter An Ingredient",
                  border: const OutlineInputBorder()),
              onSubmitted: (_) => _addIngredient(),
            ),
            const SizedBox(height: 16.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RoundedButton(
                onPressed: _addIngredient,
                color: kButtonColor,
                text: 'Add Ingredient',
              ),
              ElevatedButton(
                onPressed: _resetData,
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Circular shape
                    padding: const EdgeInsets.all(
                        16), // Padding to increase the size of the circle
                    backgroundColor: kPrimaryColor),
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
            ]),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: inputTags
                  .asMap()
                  .entries
                  .map(
                    (MapEntry<int, String> entry) => Chip(
                      labelStyle: TextStyle(color: kTextColor),
                      backgroundColor: kContainerColor,
                      label: Text(entry.value),
                      onDeleted: () => _deleteTag(entry.key),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                Recipe,
                style: TextStyle(color: kTextColor),
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: RoundedButton(
                    color: const Color.fromARGB(255, 55, 143, 23),
                    text: GenerationState,
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
      var jsonResponse = jsonDecode(response);
      var textContent = jsonResponse['choices'][0]['text'];

      _updateRecipe(textContent.toString());

      setState(() {
        Recipe = textContent.toString();
        GenerationState = 'Re-Generate Recipe';
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
      // Show Possible causes of the error in the place of the recipe
      setState(() {
        if (OPENAI_API_KEY == "INSERT_API_KEY") {
          Recipe = "API Key not determined in Constants/Constants.dart";
        } else {
          Recipe =
              "Failed to fetch recipe data from API.\n\nPossible causes:\n- Invalid or missing API Key/API Endpoint\n- Connection error\n- Other causes";
        }
      });
    });
  }
}
