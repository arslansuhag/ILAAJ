import 'package:get/get.dart';

class AppointmentController extends GetxController {
  var selectedIndex = RxInt(-1);

  void setColor(int val) {
    selectedIndex.value = val;
  }
}
