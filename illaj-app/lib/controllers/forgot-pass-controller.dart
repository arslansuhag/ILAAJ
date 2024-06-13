import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>().obs;
}
