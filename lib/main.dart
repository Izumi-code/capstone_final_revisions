import 'package:capstone_project/pages/auth_page.dart';
import 'package:capstone_project/pages/login_page.dart';
import 'package:capstone_project/pages/pest_detection_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:capstone_project/components/splash_screen.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialRoute: '/',
//     routes: {
//       '/': (context) => AuthPage(),
//       // '/': (context) => PestDetection(),
//     },
//   ));
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // Set the initial route to SplashScreen
  ));
}
