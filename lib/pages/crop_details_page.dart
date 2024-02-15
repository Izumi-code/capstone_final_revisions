// import 'package:flutter/material.dart';
// import 'package:capstone_project/components/crop.dart';
// import 'package:capstone_project/components/crop_data.dart';

// class CropDetailsPage extends StatelessWidget {
//   final Crop crop;

//   const CropDetailsPage({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Change this to the number of learning modules you have
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green[600],
//           title: Text(crop.name),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Crop Basics'),
//               Tab(text: 'Crop Growth'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             LearningModulePage(
//               moduleNumber: 1,
//               crop: crop,
//               topics: module1Topics,
//             ),
//             LearningModulePage(
//               moduleNumber: 2,
//               crop: crop,
//               topics: module2Topics,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LearningModulePage extends StatefulWidget {
//   final int moduleNumber;
//   final Crop crop;
//   final List<String> topics;

//   LearningModulePage({
//     required this.moduleNumber,
//     required this.crop,
//     required this.topics,
//   });

//   @override
//   _LearningModulePageState createState() => _LearningModulePageState();
// }

// class _LearningModulePageState extends State<LearningModulePage> {
//   int? _expandedIndex;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Image.asset(
//               widget.crop.imagePath,
//               width: 200,
//               height: 200,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Module ${widget.moduleNumber}:',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Content for Module ${widget.moduleNumber}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             ExpansionPanelList(
//               elevation: 1,
//               expandedHeaderPadding: EdgeInsets.all(8),
//               expansionCallback: (int index, bool isExpanded) {
//                 _handleIndexChanged(index);
//               },
//               children: widget.topics.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final topic = entry.value;
//                 final topicContent = widget.crop.topicContent[topic] ?? '';

//                 return ExpansionPanel(
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return Container(
//                       margin: EdgeInsets.all(8),
//                       child: ListTile(
//                         title: Text(
//                           topic,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     );
//                   },
//                   body: Container(
//                     padding: EdgeInsets.all(8),
//                     child: AnimatedCrossFade(
//                       firstChild: SizedBox.shrink(),
//                       secondChild: ListTile(
//                         title: Text(topicContent),
//                       ),
//                       crossFadeState: _expandedIndex == index
//                           ? CrossFadeState.showSecond
//                           : CrossFadeState.showFirst,
//                       duration: const Duration(milliseconds: 300),
//                     ),
//                   ),
//                   isExpanded: index == _expandedIndex,
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleIndexChanged(int newIndex) {
//     setState(() {
//       if (_expandedIndex == newIndex) {
//         _expandedIndex = null;
//       } else {
//         _expandedIndex = newIndex;
//       }
//     });
//   }
// }

// List<String> module1Topics = [
//   'Soil Health: Basics of soil testing and soil improvement techniques.',
//   'Planting and Sowing: Best practices for starting your crops.',
//   'Water Management: Strategies for effective irrigation and water conservation.',
// ];

// List<String> module2Topics = [
//   'Fertilization: Properly nourishing your crops with the right nutrients is vital for healthy growth.',
//   'Pest and Disease Management: Identifying and addressing crop threats is critical to prevent losses.',
//   'Equipment and Tools: Proper use and maintenance of farming equipment.',
// ];

// import 'package:flutter/material.dart';
// import 'package:capstone_project/components/crop.dart';

// class CropDetailsPage extends StatelessWidget {
//   final Crop crop;

//   const CropDetailsPage({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[600],
//         title: Text(crop.name),
//       ),
//       body: LearningModulePage(crop: crop),
//     );
//   }
// }

// class LearningModulePage extends StatelessWidget {
//   final Crop crop;

//   LearningModulePage({
//     required this.crop,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Image.asset(
//             crop.imagePath,
//             width: 200,
//             height: 200,
//           ),
//           SizedBox(height: 20),
//           for (var entry in crop.topicContent.entries)
//             TopicItem(topic: entry.key, content: entry.value),
//         ],
//       ),
//     );
//   }
// }

// class TopicItem extends StatelessWidget {
//   final String topic;
//   final String content;

//   const TopicItem({required this.topic, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 16),
//         Text(
//           topic,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         Text(
//           content,
//           style: TextStyle(fontSize: 18),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:capstone_project/components/crop.dart';

class CropDetailsPage extends StatelessWidget {
  final Crop crop;

  const CropDetailsPage({required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text(crop.name),
      ),
      body: LearningModulePage(crop: crop),
    );
  }
}

class LearningModulePage extends StatelessWidget {
  final Crop crop;

  LearningModulePage({
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            crop.imagePath,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          for (var entry in crop.topicContent.entries)
            TopicItem(topic: entry.key, content: entry.value),
        ],
      ),
    );
  }
}

class TopicItem extends StatelessWidget {
  final String topic;
  final String content;

  const TopicItem({required this.topic, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          topic,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
