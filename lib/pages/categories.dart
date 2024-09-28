import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/recipe.dart';
import 'package:recipe_app/services/firebase_database.dart';

class CategoriesPage extends StatefulWidget {
  final String categoryName;
  const CategoriesPage({super.key, required this.categoryName});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  //create a stream to retrieve data from firebase
  Stream? categoriesStream;

  getOnTheLoad() async {
    categoriesStream =
        await FirebaseDatabase().getCategoryRecipes(widget.categoryName);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget getAllCategoryRecipes() {
    return StreamBuilder(
      stream: categoriesStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot categoryRecipes = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Recipe(
                                  imagesrc: categoryRecipes["Image"],
                                  recipeName: categoryRecipes["Recipe"],
                                  recipeCategory: categoryRecipes["Category"],
                                  recipeDescription:
                                      categoryRecipes["Details"])));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              categoryRecipes["Image"],
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(categoryRecipes["Recipe"],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  );
                })
            : Container(
                child: const Center(
                    child:
                        Text("Poor network connection or no data available!")));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.categoryName,
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: getAllCategoryRecipes()),
          ],
        ),
      ),
    );
  }
}
