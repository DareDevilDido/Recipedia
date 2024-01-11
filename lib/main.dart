import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipedia/Constants/Constants.dart';
import 'package:recipedia/Controllers/DafualtRecipesController.dart';
import 'package:recipedia/Controllers/DefaultIngredientController.dart';
import 'package:recipedia/Unique%20classes/PickImage.dart';
import 'package:recipedia/Views/UserScreens/HomePage.dart';
import 'package:recipedia/Views/UserScreens/LoginPage.dart';
import 'package:recipedia/Views/UserScreens/RegisterPage.dart';
import 'package:provider/provider.dart';
import 'Views/AdminScreens/AdminAddRecipe.dart';
import 'Views/AdminScreens/AdminCreateUserPage.dart';
import 'Views/AdminScreens/CreateAdminIngredientPage.dart';
import 'Controllers/AdminIngredientController.dart';
import 'Controllers/AdminInstructionController.dart';
import 'Controllers/AdminRecipecontroller.dart';
import 'Controllers/FavroiteRecipeController.dart';
import 'Controllers/UserController.dart';
import 'Controllers/UserIngredientsController.dart';
import 'Controllers/UserInstructionsController.dart';
import 'Controllers/UserRecipeIngredientController.dart';
import 'Controllers/UserRecipesController.dart';
import 'Unique classes/RandomRecipeOfTheDay.dart';
import 'Unique classes/Recipe.dart';
import 'Unique classes/Timer.dart';
import 'Views/UserScreens/DefaultRecipePage.dart';
import 'Views/UserScreens/MyIngredientPage.dart';
import 'Views/UserScreens/ProfilePage.dart';
import 'Views/UserScreens/MyRecipesPage.dart';
import 'Views/UserScreens/WelcomePage.dart';
import 'Views/UserScreens/SearchPage.dart';
import 'Views/UserScreens/IngredientsPage.dart';
import 'Views/UserScreens/EditInstructionsPage.dart';
import 'Views/AdminScreens/CreateIngredientPage.dart';
import 'Views/UserScreens/CreateInstructionsPage.dart';
import 'Views/UserScreens/CreateRecipePage.dart';
import 'Views/UserScreens/SelectIngredientsPage.dart';
import 'Views/UserScreens/RequestPassswordChange.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PickImage()),
      ChangeNotifierProvider(create: (_) => Loading()),
      ChangeNotifierProvider(create: (_) => Recipe()),
      ChangeNotifierProvider(create: (_) => DefaultRecipeController()),
      ChangeNotifierProvider(create: (_) => DefaultIngredientCntroller()),
      ChangeNotifierProvider(create: (_) => FavortieRecipesController()),
      ChangeNotifierProvider(create: (_) => UserRecipesController()),
      ChangeNotifierProvider(create: (_) => UserRecipesController()),
      ChangeNotifierProvider(create: (_) => UserIngredientController()),
      ChangeNotifierProvider(create: (_) => UserInsrtuctionCntroller()),
      ChangeNotifierProvider(create: (_) => UserRecipeIngredientController()),
      ChangeNotifierProvider(create: (_) => AdminRecipesController()),
      ChangeNotifierProvider(create: (_) => AdminIngredientController()),
      ChangeNotifierProvider(create: (_) => AdminInsrtuctionCntroller()),
      ChangeNotifierProvider(create: (_) => UserController()),
      ChangeNotifierProvider(create: (_) => RandomRecipeOfTheDay()),
      ChangeNotifierProvider(create: (_) => CountDownTimer()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static ThemeData theme = ThemeData.light();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        theme: ThemeData(fontFamily: GoogleFonts.ptSans().fontFamily),
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
          HomePage.id: (context) => const HomePage(),
          ProfilePage.id: (context) => ProfilePage(),
          MyRecipesPage.id: (context) => const MyRecipesPage(),
          DefaultRecipePage.id: (context) => const DefaultRecipePage(),
          SearchPage.id: (context) => const SearchPage(),
          IngredientsPage.id: (context) => const IngredientsPage(),
          MyIngredientPage.id: (context) => const MyIngredientPage(),
          CreateIngredientPage.id: (context) => const CreateIngredientPage(),
          CreateRecipePage.id: (context) => const CreateRecipePage(),
          CreateInstructionPage.id: (context) => const CreateInstructionPage(),
          EditInstructionPage.id: (context) => const EditInstructionPage(),
          SelectIngredientsPage.id: (context) => const SelectIngredientsPage(),
          RequestPasswordChange.id: (context) => const RequestPasswordChange(),
          SelectIngredientsPage.id: (context) => const SelectIngredientsPage(),
          SelectIngredientsPage.id: (context) => const AdminCreateRecipePage(),
          SelectIngredientsPage.id: (context) => const AdminCreateUserPage(),
          CreateAdminIngredientPage.id: (context) =>
              const CreateAdminIngredientPage(),
        },
        home: const WelcomeScreen(),
      );
}
