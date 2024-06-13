import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Terms extends StatefulWidget {
  @override
  _Terms createState() => _Terms();
}

class _Terms extends State<Terms> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Welcome to ILAAJ These terms and conditions outline the rules and regulations for the use of [ILAAJ] App.\n',
              style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'You are specifically restricted from all of the following:\n',
              style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2.0,
              fontWeight: FontWeight.w600),
            ),
            Text('• Publishing any App material in any other media\n'
                '• Selling, sublicensing and/or otherwise commercializing any App material\n'
                '• Publicly performing and/or showing any App material\n'
                '• Using this App in any way that is or may be damaging to this App\n'
                '• Using this App in any way that impacts user access to this App\n'
                '• Using this App contrary to applicable laws and regulations, or in any way may cause harm to the App, or to any person\n'
                '• Engaging in any data mining, data harvesting, data extracting or any other similar activity in relation to this App\n'
                '• [ILAAJ] will not be held accountable for any damages that will arise with the use or inability to use the materials on ILAAJ App.',
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
