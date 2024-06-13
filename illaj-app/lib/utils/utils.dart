import 'package:get/get.dart';
import 'package:illaj_app/utils/global.dart';

class Utils {
  static String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    } else {
      return null;
    }
  }

  static String? passValidator(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$');

    if (value!.isEmpty) {
      return 'Please this field must be filled';
    } else if (value.length < 6) {
      return 'Please enter minimum 6 chars';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    } else if (!value.isPhoneNumber) {
      return 'Please enter a valid number';
    } else {
      return null;
    }
  }

  static String? numberValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    } else if (!value.isNumericOnly && value.length < 2) {
      return 'Please enter a number';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? values) {
    if (values!.isEmpty) {
      return "This field must be filled";
    } else if (!GetUtils.isEmail(values.toString())) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? subjectValidator(String? values) {
    if (values!.isEmpty) {
      return "This field must be filled";
    }
    return null;
  }

  static String? messageValidator(String? values) {
    if (values!.isEmpty) {
      return "Please enter a message";
    }
    return null;
  }

  static isdoctor() {
    var res = storage.read("doctor");
    return res;
  }

  static setDoctor(val) async {
    var res = await storage.write("doctor", val);
    return res;
  }
}
