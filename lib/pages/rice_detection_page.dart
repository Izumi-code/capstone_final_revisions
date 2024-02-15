// import 'package:flutter/material.dart';
// import 'package:capstone_project/pages/disease_detection_page.dart';
// import 'package:capstone_project/pages/pest_detection_page.dart';

// class RiceDetectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PestDetectionPage(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 200, // Increase button width
//                   height: 200, // Increase button height
//                   decoration: BoxDecoration(
//                     color: Colors.brown, // Pest color
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.asset(
//                         'assets/images/newimage/pest.png', // Replace with your image path
//                         width: 80, // Adjust the image size as needed
//                         height: 80,
//                       ),
//                       Text(
//                         'Pest Detection',
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20), // Add vertical spacing
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DiseaseDetectionPage(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 200, // Increase button width
//                   height: 200, // Increase button height
//                   decoration: BoxDecoration(
//                     color: Colors.green, // Disease color
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.asset(
//                         'assets/images/newimage/disease.png', // Replace with your image path
//                         width: 80, // Adjust the image size as needed
//                         height: 80,
//                       ),
//                       Text(
//                         'Disease Detection',
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone_project/pages/disease_live_detect.dart';
// import 'package:capstone_project/pages/pest_live_detect.dart';
// import 'package:capstone_project/pages/disease_detection_page.dart';
// import 'package:capstone_project/pages/pest_detection_page.dart';

// class RiceDetectionPage extends StatelessWidget {
//   User? currentUser = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: GridView(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Number of columns in the grid
//               mainAxisSpacing: 20.0, // Vertical spacing between grid items
//               crossAxisSpacing: 20.0, // Horizontal spacing between grid items
//             ),
//             padding: EdgeInsets.all(20.0),
//             children: [
//               buildButton(
//                 context,
//                 PestDetectionPage(user: currentUser),
//                 'Pest Detection',
//                 'assets/images/newimage/pest.png',
//                 Colors.brown,
//               ),
//               buildButton(
//                 context,
//                 DiseaseDetectionPage(),
//                 'Disease Detection',
//                 'assets/images/newimage/disease.png',
//                 Colors.green,
//               ),
//               // buildButton(
//               //   context,
//               //   CameraScreen(),
//               //   'Detect Pest Live',
//               //   'assets/images/newimage/pest.png',
//               //   Colors.blue,
//               // ),
//               // buildButton(
//               //   context,
//               //   CameraScreenDisease(),
//               //   'Detect Disease Live',
//               //   'assets/images/newimage/disease.png',
//               //   Colors.orange,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildButton(
//     BuildContext context,
//     Widget destinationPage,
//     String buttonText,
//     String imagePath,
//     Color buttonColor,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => destinationPage,
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               imagePath,
//               width: 80,
//               height: 80,
//             ),
//             SizedBox(height: 10),
//             Text(
//               buttonText,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone_project/pages/disease_live_detect.dart';
// import 'package:capstone_project/pages/pest_live_detect.dart';
// import 'package:capstone_project/pages/disease_detection_page.dart';
// import 'package:capstone_project/pages/pest_detection_page.dart';

// class RiceDetectionPage extends StatelessWidget {
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   'Rice Pest and Disease Detection',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     buildButton(
//                       context,
//                       PestDetectionPage(user: currentUser),
//                       'Pest Detection',
//                       'assets/images/newimage/pest.png',
//                       Color.fromARGB(255, 117, 117, 117),
//                     ),
//                     buildButton(
//                       context,
//                       DiseaseDetectionPage(user: currentUser),
//                       'Disease Detection',
//                       'assets/images/newimage/disease.png',
//                       Color.fromARGB(255, 117, 117, 117),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       buildCard(
//                         'Brown Plant Hopper',
//                         'assets/images/newimage/brown plant.jpg',
//                         'Brown Plant Hopper is a common rice pest that causes damage to rice plants by sucking sap from the stems and leaves.',
//                       ),
//                       buildCard(
//                         'Yellow Stem-Borer',
//                         'assets/images/newimage/yellowstem.jpg',
//                         'Yellow Stem-Borer is a major pest that bores into the rice stem, affecting the growth and yield of the plant.',
//                       ),
//                       buildCard(
//                         'Rice Bug',
//                         'assets/images/newimage/blackbug.jpg',
//                         'Rice Bug is a pest that feeds on developing rice grains, causing damage to the crop.',
//                       ),
//                       buildCard(
//                         'Whorl Maggot',
//                         'assets/images/newimage/whorlmaggot.jpg',
//                         'Whorl Maggot is a pest that damages rice plants by feeding on the whorl and young leaves.',
//                       ),
//                       buildCard(
//                         'Green Leaf Hopper',
//                         'assets/images/newimage/riceleafhopper.png',
//                         'Green Leaf Hopper is a pest that feeds on the sap of rice plants, leading to reduced growth and yield.',
//                       ),
//                       buildCard(
//                         'Leaf Folder',
//                         'assets/images/newimage/leaffolder.jpg',
//                         'Leaf Folder is a pest that folds and feeds on rice leaves, affecting the overall health of the plant.',
//                       ),
//                       buildCard(
//                         'Bacterial Blight',
//                         'assets/images/newimage/bacterialblight.jpg',
//                         'Bacterial Blight is a bacterial disease that affects rice leaves, causing characteristic lesions and affecting crop yield.',
//                       ),
//                       buildCard(
//                         'Rice Blast',
//                         'assets/images/newimage/rice blast.jpg',
//                         'Rice Blast is a fungal disease that affects rice plants, causing lesions on leaves, panicles, and stems.',
//                       ),
//                       buildCard(
//                         'Brown Spot',
//                         'assets/images/newimage/brown spot.jpg',
//                         'Brown Spot is a fungal disease that manifests as brown spots on rice leaves, affecting photosynthesis and grain development.',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildButton(
//     BuildContext context,
//     Widget destinationPage,
//     String buttonText,
//     String imagePath,
//     Color buttonColor,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => destinationPage,
//           ),
//         );
//       },
//       child: Container(
//         width: 160,
//         height: 160,
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               imagePath,
//               width: 80,
//               height: 80,
//             ),
//             SizedBox(height: 10),
//             Text(
//               buttonText,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCard(String title, String imagePath, String description) {
//     return Container(
//       width: 200, // Adjust the width as needed
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             imagePath,
//             width: 250,
//             height: 150,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/pages/disease_live_detect.dart';
import 'package:capstone_project/pages/pest_live_detect.dart';
import 'package:capstone_project/pages/disease_detection_page.dart';
import 'package:capstone_project/pages/pest_detection_page.dart';

class RiceDetectionPage extends StatelessWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.green],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Rice Pest and Disease Detection',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildButton(
                              context,
                              PestDetectionPage(user: currentUser),
                              'Pest Detection',
                              'assets/images/newimage/pest.png',
                              Color.fromARGB(255, 117, 117, 117),
                            ),
                            buildButton(
                              context,
                              DiseaseDetectionPage(user: currentUser),
                              'Disease Detection',
                              'assets/images/newimage/disease.png',
                              Color.fromARGB(255, 117, 117, 117),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildCard(
                                'Brown Plant Hopper',
                                'assets/images/newimage/brown plant.jpg',
                                'Brown Plant Hopper is a common rice pest that causes damage to rice plants by sucking sap from the stems and leaves.',
                              ),
                              buildCard(
                                'Yellow Stem-Borer',
                                'assets/images/newimage/yellowstem.jpg',
                                'Yellow Stem-Borer is a major pest that bores into the rice stem, affecting the growth and yield of the plant.',
                              ),
                              buildCard(
                                'Rice Bug',
                                'assets/images/newimage/blackbug.jpg',
                                'Rice Bug is a pest that feeds on developing rice grains, causing damage to the crop.',
                              ),
                              buildCard(
                                'Whorl Maggot',
                                'assets/images/newimage/whorlmaggot.jpg',
                                'Whorl Maggot is a pest that damages rice plants by feeding on the whorl and young leaves.',
                              ),
                              buildCard(
                                'Green Leaf Hopper',
                                'assets/images/newimage/riceleafhopper.png',
                                'Green Leaf Hopper is a pest that feeds on the sap of rice plants, leading to reduced growth and yield.',
                              ),
                              buildCard(
                                'Leaf Folder',
                                'assets/images/newimage/leaffolder.jpg',
                                'Leaf Folder is a pest that folds and feeds on rice leaves, affecting the overall health of the plant.',
                              ),
                              buildCard(
                                'Bacterial Blight',
                                'assets/images/newimage/bacterialblight.jpg',
                                'Bacterial Blight is a bacterial disease that affects rice leaves, causing characteristic lesions and affecting crop yield.',
                              ),
                              buildCard(
                                'Rice Blast',
                                'assets/images/newimage/rice blast.jpg',
                                'Rice Blast is a fungal disease that affects rice plants, causing lesions on leaves, panicles, and stems.',
                              ),
                              buildCard(
                                'Brown Spot',
                                'assets/images/newimage/brown spot.jpg',
                                'Brown Spot is a fungal disease that manifests as brown spots on rice leaves, affecting photosynthesis and grain development.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
    BuildContext context,
    Widget destinationPage,
    String buttonText,
    String imagePath,
    Color buttonColor,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destinationPage,
          ),
        );
      },
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            SizedBox(height: 10),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String imagePath, String description) {
    return Container(
      width: 200, // Adjust the width as needed
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 250,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
