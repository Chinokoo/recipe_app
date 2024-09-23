import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  final String? imagesrc, recipeName, recipeDescription, recipeCategory;
  const Recipe(
      {super.key,
      required this.imagesrc,
      required this.recipeName,
      required this.recipeCategory,
      required this.recipeDescription});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              //the background image.
              Image.network(
                widget.imagesrc!,
                width: MediaQuery.of(context).size.width,
                height: 400,
                fit: BoxFit.cover,
              ),

              //the white container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 1.1),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // the heading
                      Text(
                        widget.recipeName!,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      //divider line below the heading
                      const Divider(),
                      //sized box for spacing.
                      const SizedBox(
                        height: 10.0,
                      ),
                      //the recipe
                      Text(
                        widget.recipeCategory!,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.recipeDescription!,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
