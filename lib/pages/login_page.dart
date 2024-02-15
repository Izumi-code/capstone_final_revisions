// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:capstone_project/components/my_textfield.dart';
// import 'package:capstone_project/components/my_button.dart';

// class LoginPage extends StatefulWidget {
//   final Function()? onTap;
//   LoginPage({Key? key, required this.onTap});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void signUserIn() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     try {
//       final userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       if (isAdmin()) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AdminPage()),
//         );
//       } else {
//         if (userCredential.user != null && userCredential.user!.emailVerified) {
//           Navigator.of(context, rootNavigator: true).pop();
//           // Navigate to your main page or wherever you want to go after successful login
//         } else {
//           Navigator.pop(context);
//           showErrorMessage(
//               "Email is not verified. Please check your email for a verification link.");
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       showErrorMessage(e.code);
//     }
//   }

//   bool isAdmin() {
//     // Replace this with the email of the admin account created on Firebase Console
//     String adminEmail = 'agrosensemod@gmail.com';
//     return emailController.text.toLowerCase() == adminEmail.toLowerCase();
//   }

//   Future<void> resetPassword(String email) async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       showSuccessMessage("Password reset email sent. Check your inbox.");
//     } on FirebaseAuthException catch (e) {
//       showErrorMessage(e.message!);
//     }
//   }

//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.deepOrange,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void showSuccessMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.green,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 50),
//                 Image.asset(
//                   'assets/images/newimage/farmer.png',
//                   width: 150,
//                   height: 150,
//                 ),
//                 SizedBox(height: 50),
//                 Text(
//                   'Welcome back!',
//                   style: TextStyle(
//                     color: Colors.brown,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Enter your Email',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 25),
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Enter your Password',
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     resetPassword(emailController.text);
//                   },
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.green, fontSize: 18),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 MyButton(
//                   text: 'Sign In',
//                   onTap: signUserIn,
//                 ),
//                 SizedBox(height: 50),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Not a member?'),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: Text(
//                         'Register now',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AdminLoginPage()),
//                     );
//                   },
//                   child: Text(
//                     'Admin? Login here',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AdminLoginPage extends StatelessWidget {
//   final TextEditingController adminEmailController = TextEditingController();
//   final TextEditingController adminPasswordController = TextEditingController();

//   void signAdminIn(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: adminEmailController.text,
//         password: adminPasswordController.text,
//       );

//       if (FirebaseAuth.instance.currentUser != null &&
//           FirebaseAuth.instance.currentUser!.emailVerified) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AdminPage()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Admin email not verified.'),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print('Admin login error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Admin login error: ${e.message}'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MyTextField(
//               controller: adminEmailController,
//               hintText: 'Admin Email',
//               obscureText: false,
//             ),
//             SizedBox(height: 25),
//             MyTextField(
//               controller: adminPasswordController,
//               hintText: 'Admin Password',
//               obscureText: true,
//             ),
//             SizedBox(height: 25),
//             MyButton(
//               text: 'Admin Sign In',
//               onTap: () => signAdminIn(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AdminPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Page'),
//       ),
//       body: Center(
//         child: Text('Welcome Admin!'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(
//         onTap: () {
//           // Handle the registration page navigation
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:capstone_project/components/my_textfield.dart';
// import 'package:capstone_project/components/my_button.dart';

// class LoginPage extends StatefulWidget {
//   final Function()? onTap;
//   LoginPage({Key? key, required this.onTap});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void signUserIn() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     try {
//       final userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       if (isAdmin()) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AdminPage()),
//         );
//       } else {
//         if (userCredential.user != null && userCredential.user!.emailVerified) {
//           Navigator.of(context, rootNavigator: true).pop();
//           // Navigate to your main page or wherever you want to go after successful login
//         } else {
//           Navigator.pop(context);
//           showErrorMessage(
//               "Email is not verified. Please check your email for a verification link.");
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       showErrorMessage(e.code);
//     }
//   }

//   bool isAdmin() {
//     // Replace this with the email of the admin account created on Firebase Console
//     String adminEmail = 'agrosensemod@gmail.com';
//     return emailController.text.toLowerCase() == adminEmail.toLowerCase();
//   }

//   Future<void> resetPassword(String email) async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       showSuccessMessage("Password reset email sent. Check your inbox.");
//     } on FirebaseAuthException catch (e) {
//       showErrorMessage(e.message!);
//     }
//   }

//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.deepOrange,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void showSuccessMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.green,
//           title: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 50),
//                 Image.asset(
//                   'assets/images/newimage/farmer.png',
//                   width: 150,
//                   height: 150,
//                 ),
//                 SizedBox(height: 50),
//                 Text(
//                   'Welcome back!',
//                   style: TextStyle(
//                     color: Colors.brown,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Enter your Email',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 25),
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Enter your Password',
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     resetPassword(emailController.text);
//                   },
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.green, fontSize: 18),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 MyButton(
//                   text: 'Sign In',
//                   onTap: signUserIn,
//                 ),
//                 SizedBox(height: 50),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Not a member?'),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: Text(
//                         'Register now',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AdminLoginPage()),
//                     );
//                   },
//                   child: Text(
//                     'Admin? Login here',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AdminLoginPage extends StatelessWidget {
//   final TextEditingController adminEmailController = TextEditingController();
//   final TextEditingController adminPasswordController = TextEditingController();

//   void signAdminIn(BuildContext context) async {
//     String adminEmail = 'agrosensemod@gmail.com';

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: adminEmail, password: adminPasswordController.text);

//       if (userCredential.user != null &&
//           userCredential.user!.email == adminEmail &&
//           userCredential.user!.emailVerified) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => AdminPage()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Admin email not verified.'),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print('Admin login error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Admin login error: ${e.message}'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MyTextField(
//               controller: adminEmailController,
//               hintText: 'Admin Email',
//               obscureText: false,
//             ),
//             SizedBox(height: 25),
//             MyTextField(
//               controller: adminPasswordController,
//               hintText: 'Admin Password',
//               obscureText: true,
//             ),
//             SizedBox(height: 25),
//             MyButton(
//               text: 'Admin Sign In',
//               onTap: () => signAdminIn(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AdminPage extends StatelessWidget {
//   void _logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pop(context); // Pop the admin page
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Page'),
//         leading: IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: () => _logout(context),
//         ),
//       ),
//       body: Center(
//         child: Text('Welcome Admin!'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(
//         onTap: () {
//           // Handle the registration page navigation
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/components/my_textfield.dart';
import 'package:capstone_project/components/my_button.dart';
import 'admin_page.dart'; // Import the AdminPage class from the new file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(
        onTap: () {
          // Handle the registration page navigation
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({Key? key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (isAdmin()) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        if (userCredential.user != null && userCredential.user!.emailVerified) {
          Navigator.of(context, rootNavigator: true).pop();
          // Navigate to your main page or wherever you want to go after successful login
        } else {
          Navigator.pop(context);
          showErrorMessage(
              "Email is not verified. Please check your email for a verification link.");
        }
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  bool isAdmin() {
    // Replace this with the email of the admin account created on Firebase Console
    String adminEmail = 'agrosensemod@gmail.com';
    return emailController.text.toLowerCase() == adminEmail.toLowerCase();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSuccessMessage("Password reset email sent. Check your inbox.");
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message!);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset(
                  'assets/images/newimage/farmer.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 50),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  obscureText: false,
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    resetPassword(emailController.text);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ),
                SizedBox(height: 25),
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLoginPage()),
                    );
                  },
                  child: Text(
                    'Admin? Login here',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminLoginPage extends StatelessWidget {
  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController adminPasswordController = TextEditingController();

  void signAdminIn(BuildContext context) async {
    String adminEmail = 'agrosensemoderator@gmail.com';

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: adminEmail, password: adminPasswordController.text);

      if (userCredential.user != null &&
          userCredential.user!.email == adminEmail &&
          userCredential.user!.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Admin email not verified.'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Admin login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Admin login error: ${e.message}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: adminEmailController,
              hintText: 'Admin Email',
              obscureText: false,
            ),
            SizedBox(height: 25),
            MyTextField(
              controller: adminPasswordController,
              hintText: 'Admin Password',
              obscureText: true,
            ),
            SizedBox(height: 25),
            MyButton(
              text: 'Admin Sign In',
              onTap: () => signAdminIn(context),
            ),
          ],
        ),
      ),
    );
  }
}
