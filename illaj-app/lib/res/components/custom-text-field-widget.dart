// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
Widget CustomTextFieldWidget({
  required String hintText,
  String? labelText,
  var errorStyle,
  bool filled = false,
  Color? filledColor,
  // required double height,
  var labelStyle,
  var preffixIcon,
  Widget? SuffixIcon,
  var initialValue,
  int maxLines = 1,
  FocusNode? focusNode,
  bool autoFocus = false,
  bool obscureText = false,
  bool readOnly = false,
  bool inDense = false,
  var style,
  int? maxLength,
  double radius = 8,
  TextEditingController? controller,
  String? Function(String?)? onValidator,
  String? Function(String)? onChanged,
  String? Function(String)? onFieldSubmitted,
  Widget? suffixTap,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  List<TextInputFormatter> formatter = const [],
}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
    // height: mq.height * .4,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      // ignore: prefer_const_constructors
    ),
    child: TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      autofocus: autoFocus,
      readOnly: readOnly,
      style: style,
      inputFormatters: formatter,
      maxLines: maxLines,
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: onValidator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        isDense: inDense,
        fillColor: filledColor,
        suffix: suffixTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        errorStyle: errorStyle,
        labelStyle: labelStyle,
        labelText: labelText,
        filled: filled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        suffixIcon: SuffixIcon,
        hintText: hintText,
        prefixIcon: preffixIcon,
        hintStyle: const TextStyle(
          fontFamily: "Montserrat-SemiBold",
          fontWeight: FontWeight.w600,
          color: Color(0xff979797),
          fontSize: 16,
        ),
      ),
    ),
  );
}
