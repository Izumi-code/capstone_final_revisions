// import 'package:flutter/material.dart';
// import 'package:capstone_project/components/pest.dart';

// class PestInformationScreen extends StatelessWidget {
//   final PestInformation pestInfo;

//   PestInformationScreen({required this.pestInfo});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(pestInfo.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Description:"),
//             Text(pestInfo.description),
//             SizedBox(height: 20),
//             Text("Countermeasures:"),
//             Text(pestInfo.countermeasures),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:capstone_project/components/pest.dart';

class PestInformationScreen extends StatelessWidget {
  final PestInformation pestInfo;

  PestInformationScreen({required this.pestInfo});

  @override
  Widget build(BuildContext context) {
    // Split the countermeasures string into a list
    List<String> countermeasuresList = pestInfo.countermeasures.split('\n');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pestInfo.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Colors.green, // Set the AppBar background color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                pestInfo.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Countermeasures:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: countermeasuresList
                    .map((countermeasure) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            countermeasure,
                            style: TextStyle(fontSize: 16),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
