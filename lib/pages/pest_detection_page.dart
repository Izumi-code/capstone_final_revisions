// import 'package:capstone_project/pages/pest_analytics.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_pytorch/pigeon.dart';
// import 'package:flutter_pytorch/flutter_pytorch.dart';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:capstone_project/pages/pest_counter_measure.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// class PestDetectionPage extends StatefulWidget {
//   final User? user;

//   PestDetectionPage({this.user});

//   @override
//   _PestDetectionPageState createState() => _PestDetectionPageState();
// }

// class _PestDetectionPageState extends State<PestDetectionPage> {
//   late ModelObjectDetection _objectModel;
//   List<ResultObjectDetection?> _objDetect = [];
//   File? _imageFile;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     String pathObjectDetectionModel =
//         "assets/models/rice-pest-11-s-latestv5-export640.torchscript";
//     try {
//       _objectModel = await FlutterPytorch.loadObjectDetectionModel(
//         pathObjectDetectionModel,
//         6,
//         640,
//         640,
//         labelPath: "assets/labels/labelmap_pest.txt",
//       );
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }

//   Future<void> runObjectDetection(Uint8List imageBytes) async {
//     setState(() {
//       _loading = true;
//       _objDetect = [];
//     });

//     _objDetect = await _objectModel.getImagePrediction(
//       imageBytes,
//       minimumScore: 0.3,
//       IOUThershold: 0.3,
//     );

//     await storeDetectedPest();

//     _objDetect.forEach((element) {
//       print({
//         "score": element?.score,
//         "className": element?.className,
//         "class": element?.classIndex,
//         "rect": {
//           "left": element?.rect.left,
//           "top": element?.rect.top,
//           "width": element?.rect.width,
//           "height": element?.rect.height,
//           "right": element?.rect.right,
//           "bottom": element?.rect.bottom,
//         },
//       });
//     });

//     setState(() {
//       _loading = false;
//     });
//   }

//   Future<void> storeDetectedPest() async {
//     if (widget.user != null) {
//       print("User is not null.");

//       final CollectionReference detectedPestCollection =
//           FirebaseFirestore.instance.collection("detected_pest");

//       if (widget.user!.uid != null) {
//         print("User UID is not null.");

//         final DocumentReference userDoc =
//             detectedPestCollection.doc(widget.user!.uid!);

//         if (_imageFile != null && _objDetect.isNotEmpty) {
//           print("_imageFile and _objDetect are not null/empty.");

//           final CollectionReference detectionSessionCollection =
//               userDoc.collection("detection_sessions");

//           final DocumentReference detectionSessionDoc =
//               detectionSessionCollection.doc(DateTime.now().toIso8601String());

//           try {
//             await detectionSessionDoc.set({
//               'imagePath': _imageFile!.path,
//               'pests': _objDetect
//                   .map((obj) => {
//                         'className': obj?.className,
//                         'confidence': obj?.score,
//                         'boundingBox': {
//                           'left': obj?.rect.left,
//                           'top': obj?.rect.top,
//                           'width': obj?.rect.width,
//                           'height': obj?.rect.height,
//                         },
//                       })
//                   .toList(),
//               'timestamp': FieldValue.serverTimestamp(),
//             });
//             print("Detected pest stored successfully!");
//           } catch (e) {
//             print("Error storing detected pest: $e");
//           }
//         } else {
//           print("_imageFile is null or _objDetect is empty.");
//         }
//       } else {
//         print("User UID is null.");
//       }
//     } else {
//       print("User is null.");
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     setState(() {
//       _loading = true;
//     });

//     var pickedFile = await ImagePicker().pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });

//       Uint8List imageBytes = await _imageFile!.readAsBytes();
//       await runObjectDetection(imageBytes);
//     } else {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   void _showInformationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('How to Use The Detection Feature'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     '1. Pick an image on your gallery or capture using your smartphone camera to perform the detection.'),
//                 Text(
//                     '2. The app will display the detected pests on the image.'),
//                 Text('3. Click the Information button to get help.'),
//                 // Add more instructions as needed
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Add a function to handle countermeasures button click
//   void _showCountermeasures() {
//     if (_objDetect.isNotEmpty) {
//       String detectedPestClassName = _objDetect.first?.className ?? 'Unknown';
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CountermeasurePage(
//             detectedPestClassName: detectedPestClassName,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget buildResultImage() {
//     if (_loading) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text("Performing detection..."),
//           ],
//         ),
//       );
//     } else if (_imageFile == null) {
//       return Container();
//     }

//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               Container(
//                 color: Colors.black,
//                 child: Image.file(
//                   _imageFile!,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               ..._objDetect.map((obj) {
//                 if (obj != null) {
//                   return Positioned(
//                     left: obj.rect.left * MediaQuery.of(context).size.width,
//                     top: obj.rect.top * MediaQuery.of(context).size.width,
//                     width: obj.rect.width * MediaQuery.of(context).size.width,
//                     height: obj.rect.height * MediaQuery.of(context).size.width,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.red,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Container();
//                 }
//               }),
//               ..._objDetect.map((obj) {
//                 if (obj != null) {
//                   return Positioned(
//                     left: obj.rect.left * MediaQuery.of(context).size.width,
//                     top: obj.rect.top * MediaQuery.of(context).size.width - 40,
//                     child: Container(
//                       padding: EdgeInsets.all(4),
//                       color: Colors.red,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${obj.className ?? 'Unknown'}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "Confidence: ${obj.score?.toStringAsFixed(2) ?? 'N/A'}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Container();
//                 }
//               }),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: _showCountermeasures,
//             child: Text('Countermeasure'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.green,
//               onPrimary: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rice Pest Detection'),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: _showInformationDialog,
//           ),
//           IconButton(
//             icon: Icon(Icons.analytics),
//             onPressed: _showAnalytics,
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: buildResultImage(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: SpeedDial(
//         animatedIcon: AnimatedIcons.menu_close,
//         animatedIconTheme: IconThemeData(size: 22.0),
//         visible: true,
//         curve: Curves.bounceIn,
//         children: [
//           SpeedDialChild(
//             child: Icon(Icons.image),
//             backgroundColor: Colors.green,
//             label: 'Gallery',
//             onTap: () => _pickImage(ImageSource.gallery),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.camera_alt),
//             backgroundColor: Colors.green,
//             label: 'Camera',
//             onTap: () => _pickImage(ImageSource.camera),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.security),
//             backgroundColor: Colors.blue,
//             label: 'Countermeasure',
//             onTap: _showCountermeasures,
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAnalytics() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PestAnalyticsPage(userId: widget.user!.uid),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:pytorch_lite/pytorch_lite.dart';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:capstone_project/pages/pest_counter_measure.dart';
// import 'package:capstone_project/pages/pest_analytics.dart'; // Import PestAnalyticsPage
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// class PestDetectionPage extends StatefulWidget {
//   final User? user;

//   PestDetectionPage({this.user});

//   @override
//   _PestDetectionPageState createState() => _PestDetectionPageState();
// }

// class _PestDetectionPageState extends State<PestDetectionPage> {
//   late ModelObjectDetection _objectModel;
//   List<ResultObjectDetection?> _objDetect = [];
//   File? _imageFile;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     String pathObjectDetectionModel =
//         "assets/models/rice-pest-100-s-latestv3-416-export416.torchscript";
//     try {
//       _objectModel = await PytorchLite.loadObjectDetectionModel(
//         pathObjectDetectionModel,
//         6,
//         416,
//         416,
//         labelPath: "assets/labels/labelmap_pest.txt",
//       );
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }

//   Future<void> runObjectDetection(Uint8List imageBytes) async {
//     setState(() {
//       _loading = true;
//       _objDetect = [];
//     });

//     _objDetect = await _objectModel.getImagePrediction(
//       imageBytes,
//       minimumScore: 0.3,
//       iOUThreshold: 0.3,
//     );

//     await storeDetectedPest();

//     _objDetect.forEach((element) {
//       print({
//         "score": element?.score,
//         "className": element?.className,
//         "class": element?.classIndex,
//         "rect": {
//           "left": element?.rect.left,
//           "top": element?.rect.top,
//           "width": element?.rect.width,
//           "height": element?.rect.height,
//           "right": element?.rect.right,
//           "bottom": element?.rect.bottom,
//         },
//       });
//     });

//     setState(() {
//       _loading = false;
//     });
//   }

//   Future<void> storeDetectedPest() async {
//     if (widget.user != null) {
//       print("User is not null.");

//       final CollectionReference detectedPestCollection =
//           FirebaseFirestore.instance.collection("detected_pest");

//       if (widget.user!.uid != null) {
//         print("User UID is not null.");

//         final DocumentReference userDoc =
//             detectedPestCollection.doc(widget.user!.uid!);

//         if (_imageFile != null && _objDetect.isNotEmpty) {
//           print("_imageFile and _objDetect are not null/empty.");

//           final CollectionReference detectionSessionCollection =
//               userDoc.collection("detection_sessions");

//           final DocumentReference detectionSessionDoc =
//               detectionSessionCollection.doc(DateTime.now().toIso8601String());

//           try {
//             await detectionSessionDoc.set({
//               'imagePath': _imageFile!.path,
//               'pests': _objDetect
//                   .map((obj) => {
//                         'className': obj?.className,
//                         'confidence': obj?.score,
//                         'boundingBox': {
//                           'left': obj?.rect.left,
//                           'top': obj?.rect.top,
//                           'width': obj?.rect.width,
//                           'height': obj?.rect.height,
//                         },
//                       })
//                   .toList(),
//               'timestamp': FieldValue.serverTimestamp(),
//             });
//             print("Detected pest stored successfully!");
//           } catch (e) {
//             print("Error storing detected pest: $e");
//           }
//         } else {
//           print("_imageFile is null or _objDetect is empty.");
//         }
//       } else {
//         print("User UID is null.");
//       }
//     } else {
//       print("User is null.");
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     setState(() {
//       _loading = true;
//     });

//     var pickedFile = await ImagePicker().pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });

//       Uint8List imageBytes = await _imageFile!.readAsBytes();
//       await runObjectDetection(imageBytes);
//     } else {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   void _showInformationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('How to Use The Detection Feature'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     '1. Pick an image on your gallery or capture using your smartphone camera to perform the detection.'),
//                 Text(
//                     '2. The app will display the detected pests on the image.'),
//                 Text('3. Click the Information button to get help.'),
//                 // Add more instructions as needed
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Add a function to handle countermeasures button click
//   void _showCountermeasures() {
//     if (_objDetect.isNotEmpty) {
//       String detectedPestClassName = _objDetect.first?.className ?? 'Unknown';
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CountermeasurePage(
//             detectedPestClassName: detectedPestClassName,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rice Pest Detection'),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: _showInformationDialog,
//           ),
//           IconButton(
//             icon: Icon(Icons.analytics), // Analytics icon
//             onPressed: _showAnalytics, // Function to show analytics page
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _buildResultImage(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: SpeedDial(
//         animatedIcon: AnimatedIcons.menu_close,
//         animatedIconTheme: IconThemeData(size: 22.0),
//         visible: true,
//         curve: Curves.bounceIn,
//         children: [
//           SpeedDialChild(
//             child: Icon(Icons.image),
//             backgroundColor: Colors.green,
//             label: 'Gallery',
//             onTap: () => _pickImage(ImageSource.gallery),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.camera_alt),
//             backgroundColor: Colors.green,
//             label: 'Camera',
//             onTap: () => _pickImage(ImageSource.camera),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.security),
//             backgroundColor: Colors.blue,
//             label: 'Countermeasure',
//             onTap: _showCountermeasures,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultImage() {
//     if (_loading) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text("Performing detection..."),
//           ],
//         ),
//       );
//     } else if (_imageFile == null) {
//       return Container();
//     }

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.width * 0.9,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   color: Colors.black,
//                   child: Image.file(
//                     _imageFile!,
//                     width: double.infinity,
//                     height: double.infinity,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 ..._objDetect.map((obj) {
//                   if (obj != null) {
//                     String className = obj.className ?? 'Unknown';
//                     double confidence = obj.score ?? 0.0;
//                     String confidenceText =
//                         (confidence * 100).toStringAsFixed(2) + '%';

//                     double left =
//                         obj.rect.left * MediaQuery.of(context).size.width * 0.9;
//                     double top =
//                         obj.rect.top * MediaQuery.of(context).size.width * 0.9;
//                     double width = obj.rect.width *
//                         MediaQuery.of(context).size.width *
//                         0.9;
//                     double height = obj.rect.height *
//                         MediaQuery.of(context).size.width *
//                         0.9;

//                     return Stack(
//                       children: [
//                         Positioned(
//                           left: left,
//                           top: top,
//                           width: width,
//                           height: height,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.red,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: left,
//                           top: top - 40, // Adjust this value as needed
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 4,
//                               vertical: 2,
//                             ),
//                             color: Colors.black.withOpacity(0.5),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   className ?? 'Unknown',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Confidence: $confidenceText',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Container();
//                   }
//                 }),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: _showCountermeasures,
//               child: Text('Countermeasure'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green,
//                 onPrimary: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAnalytics() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PestAnalyticsPage(userId: widget.user!.uid),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pytorch_lite/pytorch_lite.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/pages/pest_counter_measure.dart';
import 'package:capstone_project/pages/pest_analytics.dart'; // Import PestAnalyticsPage
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PestDetectionPage extends StatefulWidget {
  final User? user;

  PestDetectionPage({this.user});

  @override
  _PestDetectionPageState createState() => _PestDetectionPageState();
}

class _PestDetectionPageState extends State<PestDetectionPage> {
  late ModelObjectDetection _objectModel;
  List<ResultObjectDetection?> _objDetect = [];
  File? _imageFile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String pathObjectDetectionModel =
        "assets/models/rice-pest-75-m-latestv-416-export416.torchscript";
    try {
      _objectModel = await PytorchLite.loadObjectDetectionModel(
        pathObjectDetectionModel,
        6,
        416,
        416,
        labelPath: "assets/labels/labelmap_pest.txt",
      );
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> runObjectDetection(Uint8List imageBytes) async {
    setState(() {
      _loading = true;
      _objDetect = [];
    });

    _objDetect = await _objectModel.getImagePrediction(
      imageBytes,
      minimumScore: 0.3,
      iOUThreshold: 0.3,
    );

    await storeDetectedPest();

    _objDetect.forEach((element) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });

    setState(() {
      _loading = false;
    });
  }

  Future<void> storeDetectedPest() async {
    if (widget.user != null) {
      print("User is not null.");

      final CollectionReference detectedPestCollection =
          FirebaseFirestore.instance.collection("detected_pest");

      if (widget.user!.uid != null) {
        print("User UID is not null.");

        final DocumentReference userDoc =
            detectedPestCollection.doc(widget.user!.uid!);

        if (_imageFile != null && _objDetect.isNotEmpty) {
          print("_imageFile and _objDetect are not null/empty.");

          final CollectionReference detectionSessionCollection =
              userDoc.collection("detection_sessions");

          final DocumentReference detectionSessionDoc =
              detectionSessionCollection.doc(DateTime.now().toIso8601String());

          try {
            await detectionSessionDoc.set({
              'imagePath': _imageFile!.path,
              'pests': _objDetect
                  .map((obj) => {
                        'className': obj?.className,
                        'confidence': obj?.score,
                        'boundingBox': {
                          'left': obj?.rect.left,
                          'top': obj?.rect.top,
                          'width': obj?.rect.width,
                          'height': obj?.rect.height,
                        },
                      })
                  .toList(),
              'timestamp': FieldValue.serverTimestamp(),
            });
            print("Detected pest stored successfully!");
          } catch (e) {
            print("Error storing detected pest: $e");
          }
        } else {
          print("_imageFile is null or _objDetect is empty.");
        }
      } else {
        print("User UID is null.");
      }
    } else {
      print("User is null.");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _loading = true;
    });

    var pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      Uint8List imageBytes = await _imageFile!.readAsBytes();
      await runObjectDetection(imageBytes);
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showInformationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How to Use The Detection Feature'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '1. Pick an image on your gallery or capture using your smartphone camera to perform the detection.'),
                Text(
                    '2. The app will display the detected pests on the image.'),
                Text('3. Click the Information button to get help.'),
                // Add more instructions as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Add a function to handle countermeasures button click
  void _showCountermeasures() {
    if (_objDetect.isNotEmpty) {
      String detectedPestClassName = _objDetect.first?.className ?? 'Unknown';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountermeasurePage(
            detectedPestClassName: detectedPestClassName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rice Pest Detection'),
        backgroundColor: Colors.green, // Change appbar color to green
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showInformationDialog,
          ),
          IconButton(
            icon: Icon(Icons.analytics), // Analytics icon
            onPressed: _showAnalytics, // Function to show analytics page
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildResultImage(),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.image),
            backgroundColor: Colors.green,
            label: 'Gallery',
            onTap: () => _pickImage(ImageSource.gallery),
          ),
          SpeedDialChild(
            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.green,
            label: 'Camera',
            onTap: () => _pickImage(ImageSource.camera),
          ),
          SpeedDialChild(
            child: Icon(Icons.security),
            backgroundColor: Colors.blue,
            label: 'Countermeasure',
            onTap: _showCountermeasures,
          ),
        ],
      ),
    );
  }

  Widget _buildResultImage() {
    if (_loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Performing detection..."),
          ],
        ),
      );
    } else if (_imageFile == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/newimage/detection.png', // Replace this with the path to your custom image
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: Text('Select Image'),
          ),
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.black,
                  child: Image.file(
                    _imageFile!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                ..._objDetect.map((obj) {
                  if (obj != null) {
                    String className = obj.className ?? 'Unknown';
                    double confidence = obj.score ?? 0.0;
                    String confidenceText =
                        (confidence * 100).toStringAsFixed(2) + '%';

                    double left =
                        obj.rect.left * MediaQuery.of(context).size.width * 0.9;
                    double top =
                        obj.rect.top * MediaQuery.of(context).size.width * 0.9;
                    double width = obj.rect.width *
                        MediaQuery.of(context).size.width *
                        0.9;
                    double height = obj.rect.height *
                        MediaQuery.of(context).size.width *
                        0.9;

                    return Stack(
                      children: [
                        Positioned(
                          left: left,
                          top: top,
                          width: width,
                          height: height,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: left,
                          top: top - 40, // Adjust this value as needed
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            color: Colors.black.withOpacity(0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  className ?? 'Unknown',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Confidence: $confidenceText',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showCountermeasures,
              child: Text('Countermeasure'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAnalytics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PestAnalyticsPage(userId: widget.user!.uid),
      ),
    );
  }
}
