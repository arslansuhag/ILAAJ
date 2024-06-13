import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static void snackBar(String title, String message, Duration duration) {
    Get.snackbar(title, message, duration: duration);
  }

  static void errorSnackBar(String title, String message, Duration duration) {
    Get.snackbar(
      title,
      message,
      duration: duration,
      backgroundColor: Colors.red.withOpacity(0.76),
      colorText: Colors.white,
    );
  }

  static Widget displaysimpleprogress(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 6.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  static void displayprogress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        );
      },
    );
  }

  static void hideprogress(BuildContext context) {
    Navigator.pop(context);
  }
}
