import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recipe_app/components/image_card.dart';

class AddRecipes extends StatefulWidget {
  const AddRecipes({super.key});

  @override
  State<AddRecipes> createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  File? selectedImage;
  //controllers for text fields.
  //the recipe name controller
  TextEditingController recipeNameController = TextEditingController();
  // the recipe details controller
  TextEditingController recipeDetailsController = TextEditingController();

  //  image picker to pick image from gallery.
  final ImagePicker _picker = ImagePicker();

  //image function to pick image from gallery.
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  //uploading image function
  uploadImage() async {
    if (selectedImage != null &&
        recipeNameController.text != "" &&
        recipeDetailsController.text != "") {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadurl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addrecipe = {
        "Recipe": recipeNameController.text,
        "Details": recipeDetailsController.text,
        "Image": downloadurl,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  // Heading on top of the page.
                  child: Text(
                    "Add Recipe",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),

                //sized box for spacing.
                const SizedBox(
                  height: 20.0,
                ),

                selectedImage != null
                    ? ImageCard(
                        onTap: getImage,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            )))
                    // image input
                    : ImageCard(
                        onTap: getImage,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 50,
                        )),

                //Text called recipe name.
                const SizedBox(
                  height: 10.0,
                ),

                //input header called recipe name.
                const Text(
                  "Recipe Name",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

                //sized box for spacing.
                const SizedBox(
                  height: 10.0,
                ),

                //recipe name input field.
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: recipeNameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter recipe name"),
                  ),
                ),

                //sized box for spacing.
                const SizedBox(
                  height: 20.0,
                ),

                //input header called recipe name.
                const Text(
                  "Recipe Details",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

                //sized box for spacing.
                const SizedBox(
                  height: 10.0,
                ),

                //recipe details input field.
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: recipeDetailsController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter recipe details here...."),
                  ),
                ),
                //sized box for spacing.
                const SizedBox(
                  height: 20.0,
                ),
                //save button
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "S A V E",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ))
              ],
            )),
      ),
    ));
  }
}
