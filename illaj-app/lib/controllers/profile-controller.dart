// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:bson/bson.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
  final Rx<TextEditingController> locationController =
      TextEditingController().obs;
  final RxString _uploadedImageURL = ''.obs;
  final RxMap _patientInfo = {}.obs;
  final MongoDataBase _mongoDataBase = MongoDataBase();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get uploadedImageURL => _uploadedImageURL.value;
  RxMap get patientInfo => _patientInfo;

  @override
  void onInit() {
    super.onInit();
    fetchPatientData();
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
      Reference storageReference = _storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() async {
        _uploadedImageURL.value = await storageReference.getDownloadURL();
        print('Uploaded Image URL: $_uploadedImageURL');
      });
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  Future<void> updateProfile() async {
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

      if (_patientInfo.isNotEmpty) {
        print(_patientInfo['_id']);
        await _mongoDataBase
            .updatePatientProfile(
          _patientInfo['_id'],
          _uploadedImageURL.value,
          nameController.value.text,
          phoneController.value.text,
          locationController.value.text,
        )
            .then((value) async {
          // Fetch the updated patient data after the update
          await fetchPatientData();

          // Set the updated values in the controllers
          nameController.value.text = _patientInfo['name'] ?? 'N/A';
          phoneController.value.text = _patientInfo['phone'] ?? 'N/A';
          locationController.value.text =
              'Updated Location'; // Set the updated location

          AppUtils.snackBar(
            'Profile',
            'Profile Update Successfully',
            const Duration(seconds: 2),
          );
        });
      } else {
        print('Patient information is null.');
        // Handle the case when patientInfo is null
      }
    } catch (e) {
      print('Error updating patient profile  ----  : $e');
    }
  }

  Future<void> fetchPatientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedUserId = prefs.getString('id') ?? '';

    try {
      Map fetchedPatientInfo =
          await _mongoDataBase.fetchPatientInfo(storedUserId);
      print('Fetched Patient Info: $fetchedPatientInfo');

      if (fetchedPatientInfo != null) {
        print('Fetched Patient Info: $fetchedPatientInfo');
        _patientInfo.assignAll(fetchedPatientInfo);
        // Set initial values in the controllers
        _uploadedImageURL.value = _patientInfo['img'] ?? 'N/A';
        nameController.value.text = _patientInfo['name'] ?? 'N/A';
        emailController.value.text = _patientInfo['email'] ?? 'N/A';
        phoneController.value.text = _patientInfo['phone'] ?? 'N/A';
        locationController.value.text = _patientInfo['location'] ?? 'N/A';
      } else {
        print('No patient information found.');
      }
    } catch (e) {
      print('Error fetching patient data: $e');
    }
  }
}
