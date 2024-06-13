import 'package:flutter/material.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/screens/splash-screen.dart';

class mainsplashscreen extends StatefulWidget {
  const mainsplashscreen({super.key});

  @override
  State<mainsplashscreen> createState() => _mainsplashscreenState();
}

class _mainsplashscreenState extends State<mainsplashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.appLogo,height: 200, width: 200,),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Progress indicator
          ],
        ),

      ),

    );
  }
}
