import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool doctor = false.obs;

  set setDoctor(bool val) {
    doctor.value = val;
    update();
  }
}
