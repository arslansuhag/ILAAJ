import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../utils/app-utils.dart';

const url = 'http://10.0.2.2:3000/';

// auth
const registrationlink = "${url}signup";
const loginlink = "${url}login";
const getoneuserlink = "${url}getoneuser";
const updateuserlink = "${url}updateuser";
const updateuserdlink = "${url}updateuserd";
const getdoctorlink = "${url}getdoctor";
const forgetpasswordlink = "${url}forgetpassword";
const updatedoctorratinglink = "${url}updatedoctorrating";
const alluserlink = "${url}alluser";
const deleteuserlink = "${url}deleteuser";
const updatedoctorstatuslink = "${url}updatedoctorstatus";

// helth article
const registerhealthArticleslink = "${url}registerhealthArticles";
const allhealthArticleslink = "${url}allhealthArticles";
const updatehealthArticleslink = "${url}updatehealthArticles";
const deletehealthArticleslink = "${url}deletehealthArticles";
const allhealthArticlestouserlink = "${url}allhealthArticlestouser";

// appointment
const registerappointmentlink = "${url}registerappointment";
const getbypatientlink = "${url}getbypatient";
const getbydoctorlink = "${url}getbydoctor";
const deleteappointmentlink = "${url}deleteappointment";
const updateappointmentlink = "${url}updateappointment";

// market
const registermarketlink = "${url}registermarket";
const allmarketlink = "${url}allmarket";
const addwishlistlink = "${url}addwishlist";
const removewishlistlink = "${url}removewishlist";
const marketonelink = "${url}marketone";
const deletemarketlink = "${url}deletemarket";
const updatemarketlink = "${url}updatemarket";

// order
const registerorderlink = "${url}registerorder";
const allorderlink = "${url}allorder";
const allorderbypatlink = "${url}allorderbypat";
const cancleorderlink = "${url}cancleorder";
const updatestatuslink = "${url}updatestatus";

// chat
const registerchatlink = "${url}registerchat";
const allchatbyidlink = "${url}allchatbyid";
const addchatlink = "${url}addchat";
const allchatbydidlink = "${url}allchatbydid";

// remainder
const registerremainderlink = "${url}registerremainder";
const allremainderbyidlink = "${url}allremainderbyid";

// emergency
const registeremergencelink = "${url}registeremergence";
const allemergencebypatlink = "${url}allemergencebypat";
const cancleemergencelink = "${url}cancleemergence";
const updateemergencelink = "${url}updateemergence";

class ApiHelper {
  // emergence
  static Future<bool> registeremergence(
      String uid, String name, String number) async {
    try {
      var response = await http.post(Uri.parse(registeremergencelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid, "name": name, "number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> allemergencebypat(String uid) async {
    try {
      var response = await http.post(Uri.parse(allemergencebypatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> cancleemergence(String id) async {
    try {
      var response = await http.post(Uri.parse(cancleemergencelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateemergence(
      String id, String name, String number) async {
    try {
      var response = await http.post(Uri.parse(updateemergencelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "name": name, "number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  // auth
  static Future<bool> registration(
      String email,
      String name,
      String phone,
      String password,
      String type,
      String experience,
      String specialization,
      String description,
      String status) async {
    try {
      String? v = await FirebaseMessaging.instance.getToken();
      var response = await http.post(Uri.parse(registrationlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "name": name,
            "phone": phone,
            "password": password,
            "type": type,
            "deviceid": v,
            "experience": experience,
            "specialization": specialization,
            "description": description,
            "location": "",
            "img": "",
            "itemrating": "0",
            "itemuser": "0",
            "status": status
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> updateuser(
      String id, String img, String name, String phone, String location) async {
    try {
      var response = await http.post(Uri.parse(updateuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "img": img,
            "name": name,
            "phone": phone,
            "location": location,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> updatedoctorstatus(String id) async {
    try {
      var response = await http.post(Uri.parse(updatedoctorstatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": "active",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateuserd(
      String id,
      String img,
      String name,
      String phone,
      String location,
      String experience,
      String specialization) async {
    try {
      var response = await http.post(Uri.parse(updateuserdlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "img": img,
            "name": name,
            "phone": phone,
            "location": location,
            "experience": experience,
            "specialization": specialization
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> updatedoctorrating(String id, String itemrating) async {
    try {
      var response = await http.post(Uri.parse(updatedoctorratinglink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "itemrating": itemrating}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> forgetpassword(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(forgetpasswordlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email, "password": password}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<Map> login(String email, String password) async {
    try {
      String? v = await FirebaseMessaging.instance.getToken();
      var response = await http.post(Uri.parse(loginlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"email": email, "password": password, "deviceid": v}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        return data['data'] as Map;
      } else {
        AppUtils.snackBar('Login', data['message'], const Duration(seconds: 2));
        return {};
      }
    } catch (e) {
      AppUtils.snackBar('Login', 'Try again later', const Duration(seconds: 2));
      return {};
    }
  }

  static Future<List> alluser() async {
    try {
      var response = await http.post(Uri.parse(alluserlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteuser(String id) async {
    try {
      var response = await http.post(Uri.parse(deleteuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<Map> getoneuser(String id) async {
    try {
      var response = await http.post(Uri.parse(getoneuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        return data['data'] as Map;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  static Future<List> getdoctor() async {
    try {
      var response = await http.post(Uri.parse(getdoctorlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        return data['data'] as List;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // health article
  static Future<bool> registerhealthArticles(
      String uid, String title, String description, String imageUrl) async {
    try {
      var response = await http.post(Uri.parse(registerhealthArticleslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "title": title,
            "description": description,
            "imageUrl": imageUrl,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> updatehealthArticles(
      String title, String description, String imageUrl, String id) async {
    try {
      var response = await http.post(Uri.parse(updatehealthArticleslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "title": title,
            "description": description,
            "imageUrl": imageUrl,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> deletehealthArticles(String id) async {
    try {
      var response = await http.post(Uri.parse(deletehealthArticleslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> allhealthArticles(String uid) async {
    try {
      var response = await http.post(Uri.parse(allhealthArticleslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> allhealthArticlestouser() async {
    try {
      var response = await http.post(Uri.parse(allhealthArticlestouserlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  // remainder
  static Future<bool> registerremainder(
      String uid, String name, String date, String time) async {
    try {
      var response = await http.post(Uri.parse(registerremainderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "name": name,
            "date": date,
            "time": time,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> allremainderbyid(String uid) async {
    try {
      var response = await http.post(Uri.parse(allremainderbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  // appointment
  static Future<bool> registerappointment(String doctorId, String doctorName,
      String time, String date, String patientID, String patientName) async {
    try {
      var response = await http.post(Uri.parse(registerappointmentlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "doctorId": doctorId,
            "doctorName": doctorName,
            "time": time,
            "date": date,
            "patientID": patientID,
            "patientName": patientName,
            "status": "new",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> updateappointment(String id,
      {String status = 'old'}) async {
    try {
      var response = await http.post(Uri.parse(updateappointmentlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": status,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'appointment', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> getbypatient(String patientID) async {
    try {
      var response = await http.post(Uri.parse(getbypatientlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"patientID": patientID}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> getbydoctor(String doctorId) async {
    try {
      var response = await http.post(Uri.parse(getbydoctorlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"doctorId": doctorId}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteappointment(String id) async {
    try {
      var response = await http.post(Uri.parse(deleteappointmentlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  // market
  static Future<bool> registermarket(
      String title, String des, String img, String type, String price) async {
    try {
      var response = await http.post(Uri.parse(registermarketlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "title": title,
            "des": des,
            "img": img,
            "type": type,
            "wishlist": [],
            "price": price
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> allmarket() async {
    try {
      var response = await http.post(Uri.parse(allmarketlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<Map> marketone(String id) async {
    try {
      var response = await http.post(Uri.parse(marketonelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<bool> deletemarket(String id) async {
    try {
      var response = await http.post(Uri.parse(deletemarketlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatemarket(String id, String title, String des,
      String img, String type, String price) async {
    try {
      var response = await http.post(Uri.parse(updatemarketlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "title": title,
            "des": des,
            "img": img,
            "type": type,
            "price": price
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addwishlist(String id, String uid) async {
    try {
      var response = await http.post(Uri.parse(addwishlistlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<bool> removewishlist(String id, String uid) async {
    try {
      var response = await http.post(Uri.parse(removewishlistlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  // orders
  static Future<bool> registerorder(
      String mid, String uid, String quantity, String paymode) async {
    try {
      var response = await http.post(Uri.parse(registerorderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "mid": mid,
            "uid": uid,
            "status": "new",
            "quantity": quantity,
            "paymode": paymode
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }

  static Future<List> allorder() async {
    try {
      var response = await http.post(Uri.parse(allorderlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> allorderbypat(String uid) async {
    try {
      var response = await http.post(Uri.parse(allorderbypatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> cancleorder(String id) async {
    try {
      var response = await http.post(Uri.parse(cancleorderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatestatus(String id) async {
    try {
      var response = await http.post(Uri.parse(updatestatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  // chat
  static Future<Map> registerchat(String uid, String did) async {
    try {
      var response = await http.post(Uri.parse(registerchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "c": [],
            "date": DateTime.now().toString(),
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return {};
    }
  }

  static Future<Map> allchatbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(allchatbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allchatbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allchatbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addchat(String id, Map dataa) async {
    try {
      var response = await http.post(Uri.parse(addchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "data": dataa}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      AppUtils.snackBar(
          'signup', 'Try again later', const Duration(seconds: 2));
      return false;
    }
  }
}
