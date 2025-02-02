// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:capstone_project/components/crop_data.dart';
// import 'package:capstone_project/components/crop.dart';
// import 'package:translator/translator.dart';

// class LearnPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[600], // Adjust the app bar color
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: Image.asset(
//             'assets/images/newimage/agrosense.png',
//             width: 30,
//             height: 30,
//           ),
//           onPressed: () {},
//         ),
//         title: Text(
//           'AgroSense',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         color: Colors.grey[200], // Adjust the background color
//         child: SafeArea(
//           child: ListView.builder(
//             itemCount: crops.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 color: Colors.white, // Adjust the card color
//                 child: ListTile(
//                   leading: Image.asset(
//                     crops[index].imagePath,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(
//                     crops[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CropDetailsPage(crop: crops[index]),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CropDetailsPage extends StatelessWidget {
//   final Crop crop;

//   CropDetailsPage({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(crop.name),
//         backgroundColor: Colors.green[600], // Adjust the app bar color
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius:
//                   BorderRadius.circular(12), // Adjust the radius as needed
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.all(16),
//             child: ClipRRect(
//               borderRadius:
//                   BorderRadius.circular(12), // Same as above for consistency
//               child: AspectRatio(
//                 aspectRatio: 16 / 9, // Adjust aspect ratio as needed
//                 child: YoutubePlayer(
//                   controller: YoutubePlayerController(
//                     initialVideoId: crop.youtubeVideoId,
//                     flags: YoutubePlayerFlags(
//                       autoPlay: true,
//                       mute: false,
//                     ),
//                   ),
//                   showVideoProgressIndicator: true,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: crop.topicContent.length,
//               itemBuilder: (context, index) {
//                 var topic = crop.topicContent.keys.elementAt(index);
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   color: Colors.white, // Adjust the card color
//                   child: ListTile(
//                     title: Text(
//                       topic,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TopicDetailsPage(
//                             topic: topic,
//                             content: crop.topicContent[topic]!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TopicDetailsPage extends StatefulWidget {
//   final String topic;
//   final String content;

//   TopicDetailsPage({required this.topic, required this.content});

//   @override
//   _TopicDetailsPageState createState() => _TopicDetailsPageState();
// }

// class _TopicDetailsPageState extends State<TopicDetailsPage> {
//   late GoogleTranslator translator;
//   String translatedContent = "";
//   String selectedLanguage = 'en';

//   static const String englishCode = 'en';

//   Map<String, String> languageMap = {
//     englishCode: 'English',
//     'tl': 'Tagalog',
//     'ceb': 'Cebuano',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translator = GoogleTranslator();
//     translateContent();
//   }

//   void translateContent() async {
//     var translation = await translator.translate(
//       widget.content,
//       to: selectedLanguage,
//     );
//     setState(() {
//       translatedContent = translation.text!;
//     });
//   }

//   void changeLanguage(String language) {
//     setState(() {
//       selectedLanguage = language;
//       translatedContent = '';
//     });
//     translateContent();
//   }

//   List<DropdownMenuItem<String>> getDropdownItems() {
//     return languageMap.keys.map((code) {
//       return DropdownMenuItem<String>(
//         value: code,
//         child: Text(languageMap[code]!),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.topic),
//         backgroundColor: Colors.green[600], // Adjust the app bar color
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DropdownButton<String>(
//               value: selectedLanguage,
//               onChanged: (value) {
//                 changeLanguage(value!);
//               },
//               items: getDropdownItems(),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   translatedContent.isNotEmpty ? translatedContent : '',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Roboto',
//                     color: Colors.black87,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 0.5,
//                     height: 1.4,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:capstone_project/components/pdfviewer.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:capstone_project/components/crop_data.dart';
// import 'package:capstone_project/components/crop.dart';
// import 'package:translator/translator.dart';

// class LearnPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[600],
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: Image.asset(
//             'assets/images/newimage/agrosense.png',
//             width: 30,
//             height: 30,
//           ),
//           onPressed: () {},
//         ),
//         title: Text(
//           'AgroSense',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         color: Colors.grey[200],
//         child: SafeArea(
//           child: ListView.builder(
//             itemCount: crops.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 color: Colors.white,
//                 child: ListTile(
//                   leading: Image.asset(
//                     crops[index].imagePath,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(
//                     crops[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CropDetailsPage(crop: crops[index]),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CropDetailsPage extends StatelessWidget {
//   final Crop crop;

//   CropDetailsPage({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(crop.name),
//         backgroundColor: Colors.green[600],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.all(16),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: YoutubePlayer(
//                   controller: YoutubePlayerController(
//                     initialVideoId: crop.youtubeVideoId,
//                     flags: YoutubePlayerFlags(
//                       autoPlay: true,
//                       mute: false,
//                     ),
//                   ),
//                   showVideoProgressIndicator: true,
//                 ),
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PdfViewerPage(pdfAssetPath: crop.pdfAssetPath),
//                 ),
//               );
//             },
//             child: Text('View PDF'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: crop.topicContent.length,
//               itemBuilder: (context, index) {
//                 var topic = crop.topicContent.keys.elementAt(index);
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   color: Colors.white,
//                   child: ListTile(
//                     title: Text(
//                       topic,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TopicDetailsPage(
//                             topic: topic,
//                             content: crop.topicContent[topic]!,
//                             pdfUrl: crop.pdfAssetPath,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TopicDetailsPage extends StatefulWidget {
//   final String topic;
//   final String content;
//   final String pdfUrl;

//   TopicDetailsPage(
//       {required this.topic, required this.content, required this.pdfUrl});

//   @override
//   _TopicDetailsPageState createState() => _TopicDetailsPageState();
// }

// class _TopicDetailsPageState extends State<TopicDetailsPage> {
//   late GoogleTranslator translator;
//   String translatedContent = "";
//   String selectedLanguage = 'en';

//   static const String englishCode = 'en';

//   Map<String, String> languageMap = {
//     englishCode: 'English',
//     'tl': 'Tagalog',
//     'ceb': 'Cebuano',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translator = GoogleTranslator();
//     translateContent();
//   }

//   void translateContent() async {
//     var translation = await translator.translate(
//       widget.content,
//       to: selectedLanguage,
//     );
//     setState(() {
//       translatedContent = translation.text!;
//     });
//   }

//   void changeLanguage(String language) {
//     setState(() {
//       selectedLanguage = language;
//       translatedContent = '';
//     });
//     translateContent();
//   }

//   List<DropdownMenuItem<String>> getDropdownItems() {
//     return languageMap.keys.map((code) {
//       return DropdownMenuItem<String>(
//         value: code,
//         child: Text(languageMap[code]!),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.topic),
//         backgroundColor: Colors.green[600],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DropdownButton<String>(
//               value: selectedLanguage,
//               onChanged: (value) {
//                 changeLanguage(value!);
//               },
//               items: getDropdownItems(),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   translatedContent.isNotEmpty ? translatedContent : '',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Roboto',
//                     color: Colors.black87,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 0.5,
//                     height: 1.4,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:capstone_project/components/pdfviewer.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:capstone_project/components/crop_data.dart';
// import 'package:capstone_project/components/crop.dart';
// import 'package:translator/translator.dart';

// class LearnPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[600],
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: Image.asset(
//             'assets/images/newimage/agrosense.png',
//             width: 30,
//             height: 30,
//           ),
//           onPressed: () {},
//         ),
//         title: Text(
//           'AgroSense',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         color: Colors.grey[200],
//         child: SafeArea(
//           child: ListView.builder(
//             itemCount: crops.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 color: Colors.white,
//                 child: ListTile(
//                   leading: Image.asset(
//                     crops[index].imagePath,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(
//                     crops[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CropDetailsPage(crop: crops[index]),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CropDetailsPage extends StatelessWidget {
//   final Crop crop;

//   CropDetailsPage({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(crop.name),
//         backgroundColor: Colors.green[600],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.all(16),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: YoutubePlayer(
//                   controller: YoutubePlayerController(
//                     initialVideoId: crop.youtubeVideoId,
//                     flags: YoutubePlayerFlags(
//                       autoPlay: true,
//                       mute: false,
//                     ),
//                   ),
//                   showVideoProgressIndicator: true,
//                 ),
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PdfViewerPage(pdfAssetPath: crop.pdfAssetPath),
//                 ),
//               );
//             },
//             child: Text('View PDF'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: crop.topicContent.length,
//               itemBuilder: (context, index) {
//                 var topic = crop.topicContent.keys.elementAt(index);
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   color: Colors.white,
//                   child: ListTile(
//                     title: Text(
//                       topic,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TopicDetailsPage(
//                             topic: topic,
//                             content: crop.topicContent[topic]!,
//                             pdfUrl: crop.pdfAssetPath,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TopicDetailsPage extends StatefulWidget {
//   final String topic;
//   final String content;
//   final String pdfUrl;

//   TopicDetailsPage(
//       {required this.topic, required this.content, required this.pdfUrl});

//   @override
//   _TopicDetailsPageState createState() => _TopicDetailsPageState();
// }

// class _TopicDetailsPageState extends State<TopicDetailsPage> {
//   late GoogleTranslator translator;
//   String translatedContent = "";
//   String selectedLanguage = 'en';

//   static const String englishCode = 'en';

//   Map<String, String> languageMap = {
//     englishCode: 'English',
//     'tl': 'Tagalog',
//     'ceb': 'Cebuano',
//   };

//   @override
//   void initState() {
//     super.initState();
//     translator = GoogleTranslator();
//     translateContent();
//   }

//   void translateContent() async {
//     var translation = await translator.translate(
//       widget.content,
//       to: selectedLanguage,
//     );
//     setState(() {
//       translatedContent = translation.text!;
//     });
//   }

//   void changeLanguage(String language) {
//     setState(() {
//       selectedLanguage = language;
//       translatedContent = '';
//     });
//     translateContent();
//   }

//   List<DropdownMenuItem<String>> getDropdownItems() {
//     return languageMap.keys.map((code) {
//       return DropdownMenuItem<String>(
//         value: code,
//         child: Text(languageMap[code]!),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.topic),
//         backgroundColor: Colors.green[600],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DropdownButton<String>(
//               value: selectedLanguage,
//               onChanged: (value) {
//                 changeLanguage(value!);
//               },
//               items: getDropdownItems(),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   translatedContent.isNotEmpty ? translatedContent : '',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Roboto',
//                     color: Colors.black87,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 0.5,
//                     height: 1.4,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:capstone_project/components/crop_data.dart';
import 'package:capstone_project/components/crop.dart';
import 'package:capstone_project/components/pdfviewer.dart';
import 'package:translator/translator.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/newimage/agrosense.png',
            width: 30,
            height: 30,
          ),
          onPressed: () {},
        ),
        title: Text(
          'AgroSense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: SafeArea(
          child: ListView.builder(
            itemCount: crops.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8),
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    crops[index].imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    crops[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CropDetailsPage(crop: crops[index]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CropDetailsPage extends StatelessWidget {
  final Crop crop;

  CropDetailsPage({required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crop.name),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: crop.youtubeVideoId,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PdfViewerPage(pdfAssetPath: crop.pdfAssetPath),
                ),
              );
            },
            child: Text('View PDF'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: crop.topicContent.length,
              itemBuilder: (context, index) {
                var topic = crop.topicContent.keys.elementAt(index);
                return Card(
                  margin: EdgeInsets.all(8),
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      topic,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicDetailsPage(
                            topic: topic,
                            content: crop.topicContent[topic]!,
                            pdfUrl: crop.pdfAssetPath,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum TtsState { playing, stopped, paused, continued }

class TopicDetailsPage extends StatefulWidget {
  final String topic;
  final String content;
  final String pdfUrl;

  TopicDetailsPage({
    required this.topic,
    required this.content,
    required this.pdfUrl,
  });

  @override
  _TopicDetailsPageState createState() => _TopicDetailsPageState();
}

class _TopicDetailsPageState extends State<TopicDetailsPage> {
  late FlutterTts flutterTts;
  late GoogleTranslator translator;
  String translatedContent = "";
  String selectedLanguage = 'en';
  double pitch = 1.0; // Default pitch value
  double speed = 1.0; // Default speed value
  double volume = 1.0; // Default volume value
  bool isPaused = false; // Track pause state
  TtsState ttsState = TtsState.stopped; // Track TTS state

  static const String englishCode = 'en';

  Map<String, String> languageMap = {
    englishCode: 'English',
    'tl': 'Tagalog',
    'ceb': 'Cebuano',
  };

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    translator = GoogleTranslator();
    translateContent(); // Initialize translated content
  }

  void translateContent() async {
    var translation = await translator.translate(
      widget.content,
      to: selectedLanguage,
    );
    setState(() {
      translatedContent = translation.text!;
    });
  }

  void changeLanguage(String? language) {
    if (language != null) {
      setState(() {
        selectedLanguage = language;
        translatedContent = ''; // Clear translated content
      });
      translateContent(); // Translate content when language changes
      flutterTts.setLanguage(selectedLanguage); // Set TTS language
    }
  }

  Future<void> speakContent() async {
    await flutterTts.setLanguage(selectedLanguage);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speed);
    await flutterTts.setVolume(volume);
    await flutterTts.speak(translatedContent);
    setState(() {
      ttsState = TtsState.playing;
    });
  }

  void setPitch(double value) async {
    await flutterTts.setPitch(value);
    setState(() {
      pitch = value;
    });
  }

  void setSpeed(double value) async {
    await flutterTts.setSpeechRate(value);
    setState(() {
      speed = value;
    });
  }

  void setVolume(double value) async {
    await flutterTts.setVolume(value);
    setState(() {
      volume = value;
    });
  }

  void togglePause() {
    if (isPaused) {
      flutterTts.stop(); // Stop speech synthesis
      speakContent(); // Resume speech synthesis
    } else {
      flutterTts.pause(); // Pause speech synthesis
    }
    setState(() {
      isPaused = !isPaused; // Toggle pause state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: changeLanguage,
              items: languageMap.keys.map((code) {
                return DropdownMenuItem<String>(
                  value: code,
                  child: Text(languageMap[code]!),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Slider(
              value: pitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: 'Pitch: $pitch',
              onChanged: setPitch,
            ),
            SizedBox(height: 20),
            Slider(
              value: speed,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: 'Speed: $speed',
              onChanged: setSpeed,
            ),
            SizedBox(height: 20),
            Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: 'Volume: $volume',
              onChanged: setVolume,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: togglePause,
              child: Text(isPaused ? 'Resume' : 'Pause/Play'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  translatedContent.isNotEmpty ? translatedContent : '',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
