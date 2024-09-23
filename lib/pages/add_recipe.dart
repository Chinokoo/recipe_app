import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recipe_app/components/image_card.dart';
import 'package:recipe_app/services/firebase_database.dart';

class AddRecipes extends StatefulWidget {
  const AddRecipes({super.key});

  @override
  State<AddRecipes> createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  //file for selected image.
  File? selectedImage;
  //for loading state.
  bool isLoading = false;
  //recipe categories
  final List<String> recipeCategories = [
    "Main Course",
    "Simple",
    "Refreshing",
    "Dessert"
  ];

  //string for categories
  String? value;

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
  uploadRecipe() async {
    setState(() {
      isLoading = true;
    });
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
        "Category": value
      };
      FirebaseDatabase().Addrecipe(addrecipe).then((value) => {
            setState(() {
              isLoading = false;
            }),
            recipeNameController.clear(),
            recipeDetailsController.clear(),
            selectedImage = null,
            value = null,
          });
      Fluttertoast.showToast(
          msg: "The Recipe has been added Successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
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

                //sized box for spacing.
                const SizedBox(
                  height: 10.0,
                ),

                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: recipeCategories
                          .map((recipeCategory) => DropdownMenuItem(
                                value: recipeCategory,
                                child: Text(
                                  recipeCategory,
                                  style: const TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: ((value) => setState(() {
                            this.value = value;
                          })),
                      hint: const Text("Select Recipe Category"),
                      iconSize: 36,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: value,
                    ),
                  ),
                ),

                //sized box for spacing.
                const SizedBox(
                  height: 10.0,
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
                    maxLines: 20,
                    minLines: 5,
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
                GestureDetector(
                  onTap: uploadRecipe,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "S A V E",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      )),
                )
              ],
            )),
      ),
    ));
  }
}
