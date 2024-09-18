import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/models/recipe_category.dart';
import 'package:recipe_app/services/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // getting the list of categories
  List<RecipeCategory> categories = getCategories();
  // list of trending categories
  List<RecipeCategory> trending_categories = getTrendingCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/blank-profile-picture.webp",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
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

                // the categories
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  categories[index].imageUrl,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                categories[index].category,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }),
                ),

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
                  child: ListView.builder(
                      itemCount: trending_categories.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.asset(
                                    trending_categories[index].imageUrl,
                                    width: 300,
                                    height: 300,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 10.0),
                                  child: Text(
                                    trending_categories[index].category,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
