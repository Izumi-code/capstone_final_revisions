// import 'package:capstone_project/pages/pages_navigation.dart';
// import 'package:capstone_project/pages/login_or_register_page.dart';
// import 'package:capstone_project/pages/login_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return PagesNavigation();
//           } else {
//             return LoginOrRegisterPage();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/pages_navigation.dart';
import 'package:capstone_project/pages/login_or_register_page.dart';
import 'package:capstone_project/pages/login_page.dart';
import 'package:capstone_project/pages/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if authentication state is not yet determined
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // Check if the user's email is verified
            if (snapshot.data!.emailVerified) {
              // Email is verified, redirect to the main page
              return PagesNavigation();
            } else {
              // Email is not verified, show the VerifyScreen or an email verification message
              return VerifyScreen();
            }
          } else {
            // User is not authenticated, show the login or registration page
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
