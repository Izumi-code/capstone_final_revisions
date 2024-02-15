// import 'package:capstone_project/components/my_button.dart';
// import 'package:capstone_project/components/my_textfield.dart';
// import 'package:capstone_project/components/square_tile.dart';
// import 'package:capstone_project/pages/verify_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class RegisterPage extends StatefulWidget {
//   final Function()? onTap;
//   RegisterPage({super.key, required this.onTap});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   // Text editing controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   // Sign user up method
//   Future<void> signUserUp() async {
//     // Show loading circle
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     // Try creating the user
//     if (passwordController.text != confirmPasswordController.text) {
//       if (mounted) {
//         Navigator.pop(context);
//         showErrorMessage("Passwords do not match");
//       }
//       return;
//     }

//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       // Send email verification
//       await userCredential.user!.sendEmailVerification();

//       if (mounted) {
//         // Navigate to the verification screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => VerifyScreen()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         Navigator.pop(context);
//         showErrorMessage(e.code);
//       }
//     }
//   }

//   // Error message to the user
//   void showErrorMessage(String message) {
//     if (mounted) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.deepOrange, // Agriculture-like color
//             title: Center(
//               child: Text(
//                 message,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16, // Increased font size
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100], // Background color resembling fields
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 25),
//                 // Logo
//                 Icon(
//                   Icons.lock,
//                   size: 100,
//                 ),
//                 SizedBox(height: 25),
//                 // Welcome back
//                 Text(
//                   "Let's create an account for you!",
//                   style: TextStyle(
//                     color: Colors.brown, // Earthy tones
//                     fontSize: 24, // Increased font size
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 SizedBox(height: 25),

//                 // Username textfield
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Enter your Email',
//                   obscureText: false,
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 // Password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Enter your Password',
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 10),

//                 MyTextField(
//                   controller: confirmPasswordController,
//                   hintText: 'Confirm Password',
//                   obscureText: true,
//                 ),
//                 SizedBox(
//                   height: 20, // Increased spacing
//                 ),

//                 SizedBox(height: 25),

//                 // Sign up button
//                 MyButton(
//                   text: 'Sign Up',
//                   onTap: () => signUserUp(),
//                 ),

//                 SizedBox(
//                   height: 40, // Increased spacing
//                 ),
//                 // Not a member? Register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Already have an account?',
//                       style: TextStyle(
//                         fontSize: 16, // Increased font size
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: Text(
//                         'Login now',
//                         style: TextStyle(
//                           color: Colors.green, // Natural and fresh color
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16, // Increased font size
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Image.asset(
//                   'assets/images/newimage/agriculture.png',
//                   width: 120,
//                   height: 120,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:capstone_project/components/my_button.dart';
import 'package:capstone_project/components/my_textfield.dart';
import 'package:capstone_project/pages/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({Key? key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign user up method
  Future<void> signUserUp() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try creating the user
    if (passwordController.text != confirmPasswordController.text) {
      if (mounted) {
        Navigator.pop(context);
        showErrorMessage("Passwords do not match");
      }
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Save additional user information to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': emailController.text,
        'uid': userCredential.user!.uid, // Store the user's UID
        // Add any other user-related data you want to store
      });

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      if (mounted) {
        // Navigate to the verification screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      }
    }
  }

  // Error message to the user
  void showErrorMessage(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepOrange, // Agriculture-like color
            title: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Increased font size
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100], // Background color resembling fields
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                // Logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(height: 25),
                // Welcome back
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.brown, // Earthy tones
                    fontSize: 24, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 25),

                // Username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 20, // Increased spacing
                ),

                SizedBox(height: 25),

                // Sign up button
                MyButton(
                  text: 'Sign Up',
                  onTap: () => signUserUp(),
                ),

                SizedBox(
                  height: 40, // Increased spacing
                ),
                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 16, // Increased font size
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.green, // Natural and fresh color
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Increased font size
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/newimage/agriculture.png',
                  width: 120,
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
