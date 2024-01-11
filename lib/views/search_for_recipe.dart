

//      import 'package:flutter/material.dart';
//  import 'package:recipe_widget/views/widgets/recipe_card_for_agrid.dart';

// class RecipePage extends StatefulWidget {
//   @override
//   _RecipePageState createState() => _RecipePageState();
// }

// class _RecipePageState extends State<RecipePage> {
//   bool filterApplied = false;
//   int selectedRating = 0;
//   List<String> selectedCategories = [];

//   void showFilterDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Filter'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Rating'),
//               SizedBox(height: 8.0),
//               Wrap(
//                 spacing: 8.0,
//                 children: List.generate(
//                   5,
//                   (index) => ChoiceChip(
//                     label: Text((index + 1).toString(),),
//                     selected: selectedRating == index + 1,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         selectedRating = selected ? index + 1 : 0;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text('Categories'),
//               SizedBox(height: 8.0),
//               Wrap(
//                 spacing: 8.0,
//                 children: [
//                   FilterChip(
//                     label: Text('All'),
//                     selected: selectedCategories.contains('All'),
//                     onSelected: (bool selected) {
//                       setState(() {
//                         if (selected) {
//                           selectedCategories.add('All');
//                         } else {
//                           selectedCategories.remove('All');
//                         }
//                       });
//                     },
//                   ),
//                   FilterChip(
//                     label: Text('Cereal'),
//                     selected: selectedCategories.contains('Cereal'),
//                     onSelected: (bool selected) {
//                       setState(() {
//                         if (selected) {
//                           selectedCategories.add('Cereal');
//                         } else {
//                           selectedCategories.remove('Cereal');
//                         }
//                       });
//                     },
//                   ),
//                   // Add more category filter chips here
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text('Apply'),
//               onPressed: () {
//                 setState(() {
//                   filterApplied = true; // Apply the filter
//                 });
//                 Navigator.pop(context); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back,color: Colors.black,),
              
//               onPressed: () {
//                 Navigator.pop(context); // Handle back arrow press
//               },
//             ),
//            Icon(Icons.restaurant_menu,color: Colors.black,),
//               SizedBox(width: 10),
//               Text('Food Recipes', style: TextStyle(
//               color: Colors.black),)
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list,color: Colors.black,),
//             onPressed: () {
//               showFilterDialog(context); // Open the filter dialog
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'Search',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text("Recent Search",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 5))
                           
//             ,SizedBox(height: 16.0),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                children:[ RecipeCard(
//           title: 'Burger',
//           rating: '4.9',
//           cookTime: '45 min',
//           thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
//         ),RecipeCard(
//           title: 'Ramen',
//           rating: '4.0',
//           cookTime: '60 min',
//           thumbnailUrl: 'https://thecozycook.com/wp-content/uploads/2023/02/Homemade-Ramen-1-.jpg',
//         ),RecipeCard(
//           title: 'Burger',
//           rating: '4.9',
//           cookTime: '45 min',
//           thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
//         ),RecipeCard(
//           title: 'Ramen',
//           rating: '4.0',
//           cookTime: '60 min',
//           thumbnailUrl: 'https://thecozycook.com/wp-content/uploads/2023/02/Homemade-Ramen-1-.jpg',
//         )
//         ]
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
 
import 'package:recipe_widget/views/widgets/recipe_card_for_agrid.dart';

class search_for_recipe extends StatefulWidget {
  const search_for_recipe({super.key});

  @override
  _search_for_recipeState createState() => _search_for_recipeState();
}

class _search_for_recipeState extends State<search_for_recipe> {
  bool filterApplied = false;
  int selectedRating = 0;
  List<String> selectedCategories = [];
void showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Filter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Rating'),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = selectedRating == index + 1 ? 0 : index + 1;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: (selectedRating >= index + 1) ? Colors.yellow : Colors.grey,
                      ),
                      Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontWeight: (selectedRating >= index + 1) ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Categories'),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: selectedCategories.contains('All'),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedCategories.add('All');
                      } else {
                        selectedCategories.remove('All');
                      }
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Cereal'),
                  selected: selectedCategories.contains('Cereal'),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedCategories.add('Cereal');
                      } else {
                        selectedCategories.remove('Cereal');
                      }
                    });
                  },
                ),
                // Add more category filter chips here
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Apply'),
            onPressed: () {
              setState(() {
                filterApplied = true; // Apply the filter
              });
              Navigator.pop(context); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              
              onPressed: () {
                Navigator.pop(context); // Handle back arrow press
              },
            ),
           const Icon(Icons.restaurant_menu,color: Colors.black,),
              const SizedBox(width: 10),
              const Text('Food Recipes', style: TextStyle(
              color: Colors.black),)
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list,color: Colors.black,),
            onPressed: () {
              showFilterDialog(context); // Open the filter dialog
            },
          ),
        ],
      ),
      body:Scrollbar( child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [Expanded(child:Container(decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.circular(50),
              boxShadow: [BoxShadow(color:Colors.grey.shade400,
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(5, 5))
              ] ),
              child: TextFormField(
                
                decoration: const InputDecoration(border:InputBorder.none,hintText: "Search",
              prefixIcon: Icon(Icons.search))
              ),
              ),
              ),const SizedBox(
                width: 10,
              ),
              Container(decoration:BoxDecoration(color:Colors.white,
              shape:BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius:10,
                  spreadRadius: 3,
                  offset: const Offset(5, 5))
            ]),
             child:const Padding(padding: EdgeInsets.all(12.0),
             child: Icon(Icons.sort,
             size:26,
             ),
             )
             )
              ],
              ),
              
            // TextField(
            //   decoration: InputDecoration(
            //     prefixIcon: Icon(Icons.search),
            //     hintText: 'Search',
            //   ),
            // ),
            const SizedBox(height: 16.0),
            const Text("Search Result",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ,color:Colors.black ))
                           
            ,const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
               children:[ RecipeCard(
          title: 'Burger',
          rating: '4.9',
          cookTime: '45 min',
          thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
        ),RecipeCard(
          title: 'Ramen',
          rating: '4.0',
          cookTime: '60 min',
          thumbnailUrl: 'https://thecozycook.com/wp-content/uploads/2023/02/Homemade-Ramen-1-.jpg',
        ),RecipeCard(
          title: 'Burger',
          rating: '4.9',
          cookTime: '45 min',
          thumbnailUrl: 'https://media.istockphoto.com/id/1215353181/photo/burger-with-cheese-bacon-salad-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=PR1lOFAMoLSzNBv50-BoIL92mb6uIXg1aWuhwNIIjr8=',
        ),RecipeCard(
          title: 'Ramen',
          rating: '4.0',
          cookTime: '60 min',
          thumbnailUrl: 'https://thecozycook.com/wp-content/uploads/2023/02/Homemade-Ramen-1-.jpg',
        )
        ]
              ),
            ),
          ],
        ),
      ),
    ),
    
    
    );
  }
}