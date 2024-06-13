import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class NeedHelp extends StatefulWidget {
  @override
  _NeedHelp createState() => _NeedHelp();
}

class _NeedHelp extends State<NeedHelp> {

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
        title: Text('Need Help'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '𝗜n case of any query or help email us at bscs2012110@szabist.pk or use feedback feature to directly chat with admin ',
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '',
              maxLines: 2,
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2.0,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
