// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../mongoDatabase/apihelper.dart';

class UploadHelathArticles extends StatefulWidget {
  const UploadHelathArticles({super.key});

  @override
  State<UploadHelathArticles> createState() => _UploadHelathArticlesState();
}

class _UploadHelathArticlesState extends State<UploadHelathArticles> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

//---------------------Backend Part Continue-----------------//

//  Funtion for pick image from gallery
  XFile? _image;

  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = image;

    // Save the picked image to a temporary location
    if (_image != null) {}

    setState(() {});
  }

  // Future<void> saveImageToAssets(XFile imageFile) async {
  //   final appDir = await getExternalStorageDirectory();
  //   final String localPath =
  //       '${appDir!.path}/images'; // Change "assets" to "images"

  //   // Create the local folder if it doesn't exist
  //   await Directory(localPath).create(recursive: true);

  //   // Copy the image file to the local folder
  //   final String newFilePath =
  //       '$localPath/${DateTime.now().millisecondsSinceEpoch}.png';
  //   await File(imageFile.path).copy(newFilePath);
  // }

  Future<void> saveArticle(String title, String description) async {
    try {
      AppUtils.displayprogress(context);
      String imageUrl = await uploadImageToFirebaseStorage();
      bool c = await ApiHelper.registerhealthArticles(prefs.getString("id")!,
          nameController.text, desController.text, imageUrl);
      if (c) {
        nameController.clear();
        desController.clear();
        _image = null;

        AppUtils.hideprogress(context);
        AppUtils.snackBar('Health Articles', 'Data Saved Successfully',
            const Duration(seconds: 2));
        Navigator.pop(context);
        print("Article saved successfully.");
      } else {
        AppUtils.hideprogress(context);
        AppUtils.snackBar(
            'Health Articles', 'Try again later', const Duration(seconds: 2));
      }
    } catch (e) {
      AppUtils.hideprogress(context);
      print("Error saving article to MongoDB: $e");
    }
  }

  Future<String> uploadImageToFirebaseStorage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageReference = storage.ref().child(
          'health_articles/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(File(_image!.path));

      return await storageReference.getDownloadURL();
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var path = imageFile?.path;

    return Scaffold(
        key: _globalKey,
        // drawer: const DrawerWidget(),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Health Articles',
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          width: width,
          height: height,
          // constraints: BoxConstraints(maxHeight: double.infinity),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                            onTap: _pickImage,
                            child: _image != null
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: height * 0.2,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(
                                              _image!.path,
                                            ))),
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color(0xff0E6D53))),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: height * 0.2,
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColors.blaclColor)),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Add Image',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                        CustomTextFieldWidget(
                            controller: nameController, hintText: 'Title'),
                        SizedBox(height: 10.h),
                        CustomTextFieldWidget(
                            controller: desController,
                            hintText: 'Description',
                            maxLines: 5),
                        SizedBox(height: 30.h),
                        RoundButton(
                            buttonColor: AppColors.greenColor,
                            width: 120.w,
                            title: 'Upload',
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  desController.text.isEmpty) {
                                AppUtils.snackBar("Error", "Fill all Fields",
                                    const Duration(seconds: 5));
                              } else if (_image == null) {
                                AppUtils.snackBar("Error", "Add Image",
                                    const Duration(seconds: 5));
                              } else {
                                saveArticle(
                                    nameController.text, desController.text);
                              }
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
