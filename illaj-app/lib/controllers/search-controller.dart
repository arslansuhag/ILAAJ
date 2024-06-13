import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Rx<DateTime> _dateTime = DateTime.now().obs;
  DateTime get dateTime => _dateTime.value;

  RxString selectSpecialization = 'Doctor, Specialist'.obs;

  void updateSpecialization(String newValue) {
    selectSpecialization.value = newValue;
  }

  void showDatePicker() async {
    DateTime? value = await Get.defaultDialog<DateTime>(
      title: 'Select Date',
      content: Container(
        child: CalendarDatePicker(
          initialDate: _dateTime.value,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          onDateChanged: (date) {
            Get.back(result: date);
          },
        ),
      ),
    );

    if (value != null) {
      _dateTime.value = value;
    }
  }
}
