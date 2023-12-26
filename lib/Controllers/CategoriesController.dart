import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_widget/Models/categoriesRepo.dart';
import 'package:recipe_widget/Models/recipesRepo.dart';
import 'package:recipe_widget/Models/DefaultIngredientsRepo.dart';
import 'package:recipe_widget/Models/instructionsRepo.dart';

class CategoriesController {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addCategory(Categories category) async {
    await categoriesCollection.add(category.toJson());
  }

  Future<List<Categories>> getCategories() async {
    final QuerySnapshot snapshot = await categoriesCollection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final categoryId = doc.id;
      final category = Categories.fromJson(categoryId, data, []);
      return category;
    }).toList();
  }

  Future<void> updateCategory(Categories category) async {
    final categoryDoc = categoriesCollection.doc(category.ID);
    await categoryDoc.update(category.toJson());
  }

  Future<void> deleteCategory(String categoryId) async {
    final categoryDoc = categoriesCollection.doc(categoryId);
    await categoryDoc.delete();
  }

  CollectionReference getRecipeCollection(String categoryId) {
    return categoriesCollection.doc(categoryId).collection('recipe_list');
  }

  Future<void> addRecipeToCategory(String categoryId, recipesRepo recipe) async {
    final recipeCollection = getRecipeCollection(categoryId);
    await recipeCollection.add(recipe.toJson());
  }

  Future<List<recipesRepo>> getRecipesFromCategory(String categoryId,String recipeID) async {
    final recipeCollection = getRecipeCollection(categoryId);
    final QuerySnapshot snapshot = await recipeCollection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;;
      final recipeId = doc.id;
      final recipe = recipesRepo.fromJson(recipeId, data,
          [], []); // Replace the empty lists with the actual ingredients and instructions lists
      return recipe;
    }).toList();
  }
  

  Future<void> updateRecipeInCategory(
      String categoryId, recipesRepo recipe) async {
    final recipeCollection = getRecipeCollection(categoryId);
    final recipeDoc = recipeCollection.doc(recipe.ID);
    await recipeDoc.update(recipe.toJson());
  }

  Future<void> deleteRecipeFromCategory(
      String categoryId, String recipeId) async {
    final recipeCollection = getRecipeCollection(categoryId);
    final recipeDoc = recipeCollection.doc(recipeId);
    await recipeDoc.delete();
  }
  
}