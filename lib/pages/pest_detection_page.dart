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
//         "assets/models/pest-100-64-M-v2dataset.torchscript";
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
//       minimumScore: 0.6,
//       IOUThershold: 0.6,
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

//         if (_imageFile != null) {
//           print("_imageFile is not null.");

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
//           print("_imageFile is null.");
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
//               Image.file(_imageFile!,
//                   width: double.infinity, fit: BoxFit.cover),
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
//                     top: obj.rect.top * MediaQuery.of(context).size.width - 60,
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
//         backgroundColor: Colors.green,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: _showInformationDialog,
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
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () => _pickImage(ImageSource.gallery),
//             tooltip: 'Pick Image',
//             child: Icon(Icons.image),
//             heroTag: "gallery",
//           ),
//           SizedBox(width: 16),
//           FloatingActionButton(
//             onPressed: () => _pickImage(ImageSource.camera),
//             tooltip: 'Take Photo',
//             child: Icon(Icons.camera_alt),
//             heroTag: "camera",
//           ),
//         ],
//       ),
//     );
//   }
// }

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
//         "assets/models/pest-200-64-M-v1dataset.torchscript";
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
//       minimumScore: 0.4,
//       IOUThershold: 0.4,
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
//         backgroundColor: Colors.black, // Changed app bar color to black
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: _showInformationDialog,
//           ),
//           IconButton(
//             icon: Icon(Icons.analytics),
//             onPressed: _showAnalytics, // Add this line for analytics button
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
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () => _pickImage(ImageSource.gallery),
//             tooltip: 'Pick Image',
//             child: Icon(Icons.image),
//             heroTag: "gallery",
//             backgroundColor: Colors.green, // Changed fab button color
//           ),
//           SizedBox(width: 16),
//           FloatingActionButton(
//             onPressed: () => _pickImage(ImageSource.camera),
//             tooltip: 'Take Photo',
//             child: Icon(Icons.camera_alt),
//             heroTag: "camera",
//             backgroundColor: Colors.green, // Changed fab button color
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

import 'package:capstone_project/pages/pest_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/pages/pest_counter_measure.dart';
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
        "assets/models/pest-200-64-M-v1dataset.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
        pathObjectDetectionModel,
        6,
        640,
        640,
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
      minimumScore: 0.4,
      IOUThershold: 0.4,
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
  Widget buildResultImage() {
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
      return Container();
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                child: Image.file(
                  _imageFile!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ..._objDetect.map((obj) {
                if (obj != null) {
                  return Positioned(
                    left: obj.rect.left * MediaQuery.of(context).size.width,
                    top: obj.rect.top * MediaQuery.of(context).size.width,
                    width: obj.rect.width * MediaQuery.of(context).size.width,
                    height: obj.rect.height * MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              ..._objDetect.map((obj) {
                if (obj != null) {
                  return Positioned(
                    left: obj.rect.left * MediaQuery.of(context).size.width,
                    top: obj.rect.top * MediaQuery.of(context).size.width - 40,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${obj.className ?? 'Unknown'}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Confidence: ${obj.score?.toStringAsFixed(2) ?? 'N/A'}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rice Pest Detection'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showInformationDialog,
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: _showAnalytics,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: buildResultImage(),
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

  void _showAnalytics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PestAnalyticsPage(userId: widget.user!.uid),
      ),
    );
  }
}
