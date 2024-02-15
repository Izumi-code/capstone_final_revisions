// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:capstone_project/pages/verify_screen.dart'; // Import the VerifyScreen

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final currentPasswordController = TextEditingController();

//   // Function to re-authenticate the user
//   Future<void> reauthenticateUser() async {
//     try {
//       User user = FirebaseAuth.instance.currentUser!;
//       AuthCredential credential = EmailAuthProvider.credential(
//         email: user.email!,
//         password: currentPasswordController.text,
//       );

//       await user.reauthenticateWithCredential(credential);

//       // After successful re-authentication, allow the user to update email and password
//       updateEmail();
//       updatePassword();
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.message!),
//         ),
//       );
//     }
//   }

//   // Function to update the user's email
//   Future<void> updateEmail() async {
//     try {
//       User user = FirebaseAuth.instance.currentUser!;
//       await user.updateEmail(emailController.text);

//       // Redirect to the VerifyScreen after successfully updating email
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => VerifyScreen(),
//       ));

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Email updated successfully"),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.message!),
//         ),
//       );
//     }
//   }

//   // Function to update the user's password
//   Future<void> updatePassword() async {
//     try {
//       User user = FirebaseAuth.instance.currentUser!;
//       await user.updatePassword(passwordController.text);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Password updated successfully"),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.message!),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: currentPasswordController,
//             decoration: InputDecoration(labelText: 'Current Password'),
//           ),
//           TextField(
//             controller: emailController,
//             decoration: InputDecoration(labelText: 'New Email'),
//           ),
//           ElevatedButton(
//             onPressed: reauthenticateUser,
//             child: Text('Update Email'),
//           ),
//           TextField(
//             controller: passwordController,
//             decoration: InputDecoration(labelText: 'New Password'),
//           ),
//           ElevatedButton(
//             onPressed: reauthenticateUser,
//             child: Text('Update Password'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/pages/verify_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  // Function to re-authenticate the user
  Future<void> reauthenticateUser() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPasswordController.text,
      );

      await user.reauthenticateWithCredential(credential);

      // After successful re-authentication, allow the user to update email and password
      updateEmail();
      updatePassword();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  // Function to update the user's email
  Future<void> updateEmail() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updateEmail(emailController.text);

      // Redirect to the VerifyScreen after successfully updating email
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => VerifyScreen(),
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email updated successfully"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  // Function to update the user's password
  Future<void> updatePassword() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updatePassword(passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password updated successfully"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      //   backgroundColor: Colors.green, // Set app bar background color
      // ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User greeting
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Hello, ${FirebaseAuth.instance.currentUser!.email}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            StackButton(
              text: 'Account Settings',
              onTap: showUpdateDialog,
            ),
            StackButton(
              text: 'Privacy and Security',
              onTap: () {
                // Handle Privacy and Security
              },
            ),
            StackButton(
              text: 'Appearance',
              onTap: () {
                // Handle Appearance
              },
            ),
            StackButton(
              text: 'Help and Support',
              onTap: () {
                // Handle Help and Support
              },
            ),
            StackButton(
              text: 'Report a Bug',
              onTap: () {
                // Handle Report a Bug
              },
            ),
            StackButton(
              text: 'Logout',
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Navigate to the login or home screen as needed
              },
              textColor: Colors.white, // Text color for the logout button
              buttonColor:
                  Colors.red, // Button background color for the logout button
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Email and Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'New Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: currentPasswordController,
                decoration: InputDecoration(labelText: 'Current Password'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                reauthenticateUser();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}

class StackButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final Color buttonColor;

  StackButton({
    required this.text,
    required this.onTap,
    this.textColor = Colors.black, // Default text color
    this.buttonColor = Colors.white, // Default button color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8.0),
          color: buttonColor, // Set the background color of the button
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor, // Set the text color
            ),
          ),
        ),
      ),
    );
  }
}
