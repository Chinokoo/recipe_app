import 'package:recipe_app/models/recipe_category.dart';

// recipe categories data
List<RecipeCategory> getCategories() {
  List<RecipeCategory> home_recipe_categories = [
    RecipeCategory(
        category: "Refreshing", imageUrl: "images/Agua-De-Fresa-5.jpg"),
    RecipeCategory(category: "Main Course", imageUrl: "images/spagetti.webp"),
    RecipeCategory(category: "Simple", imageUrl: "images/health.jpg"),
    RecipeCategory(
        category: "Dessert",
        imageUrl: "images/gluten-free-pumpkin-bread-15.jpg")
  ];

  return home_recipe_categories;
}

List<RecipeCategory> getTrendingCategories() {
  List<RecipeCategory> trending_recipe_categories = [
    RecipeCategory(category: "Burger", imageUrl: "images/burger.webp"),
    RecipeCategory(category: "Pasta", imageUrl: "images/pasta.webp"),
  ];

  return trending_recipe_categories;
}
