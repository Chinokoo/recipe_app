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
}
