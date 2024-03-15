// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? controller;
//   List<CameraDescription>? cameras;
//   bool isModelLoaded = false;
//   List<dynamic> recognitions = [];
//   bool isModelBusy = false;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     setupCamera();
//   }

//   Future<void> loadModel() async {
//     await Tflite.loadModel(
//       model: 'assets/new_rice_pest/model_unquant.tflite',
//       labels: 'assets/new_rice_pest/labels.txt',
//     );
//     setState(() {
//       isModelLoaded = true;
//     });
//   }

//   Future<void> setupCamera() async {
//     cameras = await availableCameras();
//     controller = CameraController(cameras![0], ResolutionPreset.high);
//     await controller!.initialize();
//     if (mounted) {
//       setState(() {});
//     }

//     controller!.startImageStream((CameraImage image) async {
//       if (!isModelBusy && isModelLoaded) {
//         isModelBusy = true;

//         try {
//           List<dynamic>? tempResults = await Tflite.runModelOnFrame(
//             bytesList: image.planes.map((plane) => plane.bytes).toList(),
//             imageHeight: image.height ?? 0,
//             imageWidth: image.width ?? 0,
//             numResults: 10,
//           );

//           if (tempResults != null) {
//             setState(() {
//               recognitions = tempResults!;
//               logResults(recognitions);

//               // Add print statement for recognitions here
//               debugPrint("Recognitions: $recognitions");
//             });
//           }
//         } catch (e) {
//           print('Error running model: $e');
//         } finally {
//           isModelBusy = false;
//         }
//       }
//     });
//   }

//   void logResults(List<dynamic> results) {
//     for (dynamic result in results) {
//       debugPrint('Detected Object: ${result['label']}');
//       debugPrint('Confidence: ${result['confidence']}');

//       // Add additional information as needed
//     }
//   }

//   // Add this method to properly dispose of camera resources
//   Future<void> _disposeCamera() async {
//     try {
//       if (controller != null) {
//         await controller!.stopImageStream();
//         await controller!.dispose();
//       }
//       await Tflite.close(); // Close the model
//     } catch (e) {
//       print('Error disposing camera: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _disposeCamera();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return Container();
//     }

//     final size = MediaQuery.of(context).size;
//     final double targetWidth = size.width * 0.9; // 80% of the screen width
//     final double targetHeight =
//         targetWidth * 1.2; // Maintain a 4:5 aspect ratio

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('Rice Pest Detector'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: targetWidth,
//               height: targetHeight,
//               margin: EdgeInsets.all(20.0),
//               child: OverflowBox(
//                 maxWidth: double.infinity,
//                 alignment: Alignment.center,
//                 child: AspectRatio(
//                   aspectRatio: targetWidth / targetHeight,
//                   child: CameraPreview(controller!),
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.black, // Adjust the background color as needed
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Detected Pest: ${(recognitions.isNotEmpty) ? recognitions[0]["label"] : "N/A"}",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     "Confidence: ${(recognitions.isNotEmpty) ? (recognitions[0]["confidence"] * 100).toStringAsFixed(0) : "N/A"}%",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
