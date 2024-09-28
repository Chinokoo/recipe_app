import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  // adding recipe to the database
  Future Addrecipe(Map<String, dynamic> addrecipe) async {
    return await FirebaseFirestore.instance.collection("Recipe").add(addrecipe);
  }

  //getting all the recipes from the database
  Future<Stream<QuerySnapshot>> getAllRecipes() async {
    return await FirebaseFirestore.instance.collection("Recipe").snapshots();
  }

  //getting all the recipes of the particular category from the database
  Future<Stream<QuerySnapshot>> getCategoryRecipes(String category) async {
    return await FirebaseFirestore.instance
        .collection("Recipe")
        .where("Category", isEqualTo: category)
        .snapshots();
  }

  //the search function for the recipes in firebase database
  Future<QuerySnapshot> searchRecipes(String recipeName) async {
    return await FirebaseFirestore.instance
        .collection("Recipe")
        .where("Key", isEqualTo: recipeName.substring(0, 1).toUpperCase())
        .get();
  }
}
