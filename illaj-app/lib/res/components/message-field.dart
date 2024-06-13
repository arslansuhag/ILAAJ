// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/colors/app-colors.dart';

class MessageField extends StatefulWidget {
  final Function(String) onSend;
  final Function(String) onimage;
  MessageField({super.key, required this.onSend,required this.onimage});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      widget.onSend(messageController.text);
      messageController.clear();
      FocusScope.of(context).unfocus(); // Hide the keyboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                  hintText: 'Enter Message',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 0, color: AppColors.greenColor))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: IconButton(
                onPressed:()=>widget.onimage(messageController.text),
                icon: const Icon(Icons.attach_file,
                    size: 40, color: AppColors.greenColor)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send,
                    size: 40, color: AppColors.greenColor)),
          )
        ],
      ),
    );
  }
}
