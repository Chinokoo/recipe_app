import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_category.dart';
import 'package:recipe_app/services/data.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // getting the list of categories
    List<RecipeCategory> categories = getCategories();
    // the categories
    return SizedBox(
      height: 200,
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      categories[index].imageUrl,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(categories[index].category,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }),
    );
  }
}
