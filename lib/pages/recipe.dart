import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            //the background image.
            Image.asset(
              "images/pasta.webp",
              width: MediaQuery.of(context).size.width,
              height: 400,
              fit: BoxFit.cover,
            ),

            //the white container
            Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 1.1),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // the heading
                  Text(
                    "White Sauce Pasta",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  //divider line below the heading
                  Divider(),
                  //sized box for spacing.
                  SizedBox(
                    height: 10.0,
                  ),
                  //the recipe
                  Text(
                    "About Recipe",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Melt the Butter. Keeping your pan on low heat, \n add your butter and warm until it is melted to a liquid consistency, \nStir in the Flour. Add your flour, salt, and pepper\n Add the Milk. While your pan is off the heat, gradually add your milk while still stirring constantly.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
