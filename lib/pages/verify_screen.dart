// import 'package:capstone_project/pages/login_or_register_page.dart';
// import 'package:capstone_project/pages/pages_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';

// class VerifyScreen extends StatefulWidget {
//   @override
//   _VerifyScreenState createState() => _VerifyScreenState();
// }

// class _VerifyScreenState extends State<VerifyScreen> {
//   final auth = FirebaseAuth.instance;
//   User? user;
//   Timer? timer;

//   @override
//   void initState() {
//     user = auth.currentUser;
//     user?.sendEmailVerification();

//     timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       checkEmailVerified();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Future<void> checkEmailVerified() async {
//     user = auth.currentUser;
//     await user?.reload();
//     if (user!.emailVerified) {
//       timer?.cancel();
//       // Once the email is verified, navigate to the login page
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => LoginOrRegisterPage(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'An email has been sent to ${user?.email} for verification. Please check your inbox.',
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Resend the verification email if needed
//                 user?.sendEmailVerification();
//               },
//               child: Text('Resend Verification Email'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:capstone_project/pages/login_or_register_page.dart';
// import 'package:capstone_project/pages/pages_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';

// class VerifyScreen extends StatefulWidget {
//   @override
//   _VerifyScreenState createState() => _VerifyScreenState();
// }

// class _VerifyScreenState extends State<VerifyScreen> {
//   final auth = FirebaseAuth.instance;
//   User? user;
//   Timer? timer;

//   @override
//   void initState() {
//     user = auth.currentUser;
//     user?.sendEmailVerification();

//     timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       checkEmailVerified();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Future<void> checkEmailVerified() async {
//     user = auth.currentUser;
//     await user?.reload();
//     if (user!.emailVerified) {
//       timer?.cancel();
//       // Once the email is verified, navigate to the login page
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => PagesNavigation(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'An email has been sent to ${user?.email} for verification. Please check your inbox.',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/login_or_register_page.dart';
import 'package:capstone_project/pages/login_page.dart';
import 'package:capstone_project/pages/pages_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel();
      // Once the email is verified, navigate to the login page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PagesNavigation(),
      ));
    }
  }

  // Function to navigate back to the login page
  void goBackToLoginPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(
        onTap: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'An email has been sent to ${user?.email} for verification. Please check your inbox.',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: goBackToLoginPage,
              child: Text('Go Back to Login Page'),
            ),
          ],
        ),
      ),
    );
  }
}
