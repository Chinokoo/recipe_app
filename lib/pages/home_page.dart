import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/category_section.dart';
import 'package:recipe_app/models/recipe_category.dart';
import 'package:recipe_app/pages/add_recipe.dart';
import 'package:recipe_app/pages/recipe.dart';
import 'package:recipe_app/services/data.dart';
import 'package:recipe_app/services/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? recipeStream;

  //getting all the recipes
  getOnTheLoad() async {
    recipeStream = await FirebaseDatabase().getAllRecipes();
    setState(() {});
  }

  //load the data once the app opens
  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  // list of trending categories
  List<RecipeCategory> trending_categories = getTrendingCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),

                  // The top header.
                  child: Row(
                    children: [
                      const Text("Home of Great\nrecipes.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            getOnTheLoad();
                          },
                          child: const Icon(Icons.refresh,
                              color: Colors.black, size: 30.0)),
                    ],
                  ),
                ),

                // size box for spacing
                const SizedBox(
                  height: 20.0,
                ),

                // the search bar
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  padding: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 226, 226, 236),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search_outlined),
                        hintText: "Search for recipes . . ."),
                  ),
                ),

                // size box for spacing
                const SizedBox(
                  height: 20,
                ),

                const CategorySection(),

                //size box for spacing
                const SizedBox(
                  height: 20,
                ),

                //trending categories header
                const Text(
                  "Trending recipes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                //trending categories list
                SizedBox(
                  height: 350,
                  child: _buildCategorySection(),
                )
              ],
            ),
          ),
        ),
      ),

      // the floating icon button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddRecipes()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return StreamBuilder(
        stream: recipeStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong, try again later.");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot recipe = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recipe(
                                    imagesrc: recipe["Image"],
                                    recipeName: recipe["Recipe"],
                                    recipeCategory: recipe["Category"],
                                    recipeDescription: recipe["Details"])));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe["Image"],
                                height: 300,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(recipe["Recipe"],
                                style: const TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Column(children: [
                  Text("No Recipes found or low connection!"),
                ]));
        });
  }
}
