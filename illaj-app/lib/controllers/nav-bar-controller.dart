import 'package:get/get.dart';

class NavBarController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  RxInt get currentIndex => _currentIndex;

  void setCurrentIndex(int val) {
    _currentIndex.value = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
