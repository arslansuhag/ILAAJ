import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apihelper.dart';

class MongoDataBase {

  //**Logout Function**//
  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove('loggedIn');
      await prefs.remove('id');
      await prefs.remove('type');

      print("MongoDB connection closed successfully.");

      Get.off(() => const LoginScreen());
    } catch (e) {
      print("Error during logout: $e");
      // Handle error (show error message or perform other actions)
    }
  }


  //** Update Health Article Function**//
  Future<void> updateArticle(String articleId, String newTitle,
      String newDescription, String newImageUrl) async {
    try {
      bool b = await ApiHelper.updatehealthArticles(newTitle, newDescription, newImageUrl, articleId);
      if (b){
        AppUtils.snackBar('Health Article,',
            'Health article updated successfully.', const Duration(seconds: 2));
        print(" Health article updated successfully.");
      } else {
        AppUtils.snackBar('Health Article,',
            'Health article not updated successfully.', const Duration(seconds: 2));
        print(" Health article not updated successfully.");
      }
    } catch (e) {
      print("Error updating article: $e");
    }
  }

  //** Fetch Doctors Function**//
  // Future<List<Map<String, dynamic>>> fetchDoctors() async {
  //   try {
  //     await connect();
  //     var collection = db.collection(USER_COLLECTION);
  //     var doctorsCursor =
  //         await collection.find(where.eq('type', 'doctor')).toList();
  //     var doctors = doctorsCursor.map((doctor) => doctor).toList();
  //     if (kDebugMode) {
  //       print("Doctors: $doctors");
  //     }
  //     return doctors; // Return the fetched doctors data
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return []; // Return an empty list in case of an error
  // }
  Future<List> fetchDoctors({String? query}) async {
    try {
      var doctorsCursor = await ApiHelper.getdoctor();
      return doctorsCursor;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  //**Fetch Patient Info Function**//
  Future<Map> fetchPatientInfo(String userId) async {
    try {
      var patientInfo = await ApiHelper.getoneuser(userId);
      print(patientInfo);
      print("-----------------------------------------------------------------------------");
      if (patientInfo['type'] == 'patient') {
        return patientInfo;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching patient info: $e');
      return {};
    }
  }

  //**Fetch Doctor Info Function**//
  Future<Map> fetchDoctorInfo(String doctorId) async {
    try {
      var doctorInfo = await ApiHelper.getoneuser(doctorId);
      print(doctorInfo);

      if (doctorInfo['type'] == 'doctor') {
        return doctorInfo;
      } else {
        print('Doctor not found or type is not "doctor".');
        return {};
      }
    } catch (e) {
      print('Error fetching doctor info: $e');
      return {};
    }
  }

  Future<void> updatePatientProfile(
    String userId,
    String updatedImageUrl,
    String updatedName,
    String updatedPhone,
    String updatedLocation,
  ) async {
    try {
      await ApiHelper.updateuser(userId,
          updatedImageUrl, updatedName, updatedPhone, updatedLocation);
      print('Patient profile updated successfully.');
    } catch (e) {
      print('Error updating patient profile @@@@ : $e');
    }
  }

  Future<void> updateDoctorProfile(
    String doctorId,
    String updatedImageUrl,
    String updatedName,
    String updatedPhone,
    String updatedLocation,
    String updatedExperience,
    String updatedSpec,
  ) async {
    try {
      await ApiHelper.updateuserd(doctorId, updatedImageUrl, updatedName,
          updatedPhone, updatedLocation, updatedExperience, updatedSpec);
      print('Doctor profile updated successfully.');
    } catch (e) {
      print('Error updating doctor profile: $e');
    }
  }

  // Fetch doctor details by ID
  Future<Map> getDoctorDetailsById(String doctorId) async {
    try {
      var doctorDetails = await ApiHelper.getoneuser(doctorId);

      if (kDebugMode) {
        print("Doctor Details: $doctorDetails");
      }

      return doctorDetails; // Return the fetched doctor details
    } catch (e) {
      print("Error fetching doctor details: $e");
      return {};

    }
  }

  // Future<List<Map<String, dynamic>>> fetchAppointmentCalendar(
  //     String doctorId, String day) async {
  //   try {
  //     if (!db.isConnected) {
  //       await connect();
  //     }
  //     final collection = db.collection('appointmentCalendar');
  //     final cursor = collection.find(
  //       where.eq('doctorId', doctorId).eq('day', day),
  //     );
  //     final appointments = await cursor.toList();
  //     return appointments.map((appointment) => appointment).toList();
  //   } catch (e) {
  //     print('Error fetching appointment calendar: $e');
  //     return [];
  //   } finally {
  //     await db.close();
  //   }
  // }
}
