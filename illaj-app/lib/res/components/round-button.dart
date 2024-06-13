import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height, width;
  final Color textColor, buttonColor;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height = 50,
      this.width = 80,
      this.textColor = Colors.white,
      this.buttonColor = Colors.cyan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        elevation: 1.5,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(0, 3), color: Colors.grey.withOpacity(0.26))
          ], color: buttonColor, borderRadius: BorderRadius.circular(10.r)),
          child: Text(
            title,
            style: TextStyle(
                color: textColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
