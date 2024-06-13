// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:bson/bson.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrProfileController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
  final Rx<TextEditingController> experienceController =
      TextEditingController().obs;
  final Rx<TextEditingController> specController = TextEditingController().obs;
  final Rx<TextEditingController> locationController =
      TextEditingController().obs;
  final RxString _uploadedImageURL = ''.obs;
  final RxMap _doctorInfo = {}.obs;
  final MongoDataBase _mongoDataBase = MongoDataBase();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get uploadedImageURL => _uploadedImageURL.value;
  RxMap get patientInfo => _doctorInfo;

  @override
  void onInit() {
    super.onInit();
    fetchDoctorData();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    experienceController.value.dispose();
    specController.value.dispose();
    locationController.value.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      await uploadImageToFirebaseStorage(image);
    }
  }

  Future<void> uploadImageToFirebaseStorage(XFile image) async {
    try {
      File file = File(image.path);
      Reference storageReference = _storage.ref().child(
          'drProfile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() async {
        _uploadedImageURL.value = await storageReference.getDownloadURL();
        print('Uploaded Image URL: $_uploadedImageURL');
      });
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  Future<void> updateDoctorProfile() async {
    try {
      if (_uploadedImageURL.isEmpty &&
          nameController.value.text.isEmpty &&
          phoneController.value.text.isEmpty &&
          locationController.value.text.isEmpty) {
        // Check if image or any of the required fields are empty
        AppUtils.errorSnackBar(
          'Profile',
          'All fields must be filled',
          const Duration(seconds: 2),
        );
        return; // Stop the update process if any required field is empty
      }

      if (_doctorInfo.isNotEmpty) {
        await _mongoDataBase
            .updateDoctorProfile(
                _doctorInfo['_id'],
                _uploadedImageURL.value,
                nameController.value.text,
                phoneController.value.text,
                locationController.value.text,
                experienceController.value.text,
                specController.value.text)
            .then((value) async {
          // Fetch the updated patient data after the update
          await fetchDoctorData();

          // Set the updated values in the controllers
          nameController.value.text = _doctorInfo['name'] ?? 'N/A';
          phoneController.value.text = _doctorInfo['phone'] ?? 'N/A';
          specController.value.text = _doctorInfo['specialization'] ?? 'N/A';
          experienceController.value.text = _doctorInfo['experience'] ?? 'N/A';
          locationController.value.text =
              _doctorInfo['location'] ?? 'N/A'; // Set the updated location

          AppUtils.snackBar(
            'Profile',
            'Profile Update Successfully',
            const Duration(seconds: 2),
          );
        });
      } else {
        print('Doctor information is null.');
        // Handle the case when patientInfo is null
      }
    } catch (e) {
      print('Error updating patient profile: $e');
    }
  }

  Future<void> fetchDoctorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedUserId = prefs.getString('id')!;
    try {
      Map fetchedDoctorInfo = await ApiHelper.getoneuser(storedUserId);
      print("sadfdsaf fsadf fdsf dsafdsa fdsfffffffffffffffffffffffffffffffffffffffffffffff");
      print('Fetched Doctor Info: $fetchedDoctorInfo');

      if (fetchedDoctorInfo != null) {
        print('Fetched Doctor Info: $fetchedDoctorInfo');
        _doctorInfo.assignAll(fetchedDoctorInfo);
        // Set initial values in the controllers
        _uploadedImageURL.value = _doctorInfo['img'] ?? 'N/A';
        nameController.value.text = _doctorInfo['name'] ?? 'N/A';
        emailController.value.text = _doctorInfo['email'] ?? 'N/A';
        phoneController.value.text = _doctorInfo['phone'] ?? 'N/A';
        specController.value.text = _doctorInfo['specialization'] ?? 'N/A';
        experienceController.value.text = _doctorInfo['experience'] ?? 'N/A';
        locationController.value.text = _doctorInfo['location'] ?? 'NA';
      } else {
        print('No doctor information found.');
      }
    } catch (e) {
      print('Error fetching doctor data: $e');
    }
  }
}
