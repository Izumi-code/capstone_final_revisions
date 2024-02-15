import 'package:capstone_project/pages/auth_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay for 2 seconds before navigating to the login page
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/newimage/agrosense.png', // Replace with the path to your splash screen image
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Text(
              'AgroSense',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
