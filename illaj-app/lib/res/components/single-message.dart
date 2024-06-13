import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final String name;
  final bool isMe;
  const SingleMessage(
      {super.key,
      required this.message,
      required this.isMe,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Align(
            alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(
                  right: 16, top: 5, left: 16, bottom: 16),
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                  color: isMe
                      ? const Color(0xff0E6D53).withOpacity(0.7)
                      : Color(0xff2060c9),
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))
                      : const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ],
    );
  }
}
