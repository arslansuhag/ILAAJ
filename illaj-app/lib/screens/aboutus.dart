import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {

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
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
              ],
            ),

            Text("This App is Final Year Project developed by Arslan Ali and Naveen Kingrani. Supervised by Sheikh Usama Khalid. Arslan Ali and Naveen Kingrani are Computer Science students from Batch 2020. This App is created with Aim to facilitate patients and doctors.",
            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,letterSpacing: 3.0),
            )
          ],
        ),
      ),
    );
  }
}
