// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';

// class DiseaseAnalyticsPage extends StatelessWidget {
//   final String userId;

//   DiseaseAnalyticsPage({required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         title: Text(
//           'Disease Analytics',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Disease Detection Analytics',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               SizedBox(height: 16),
//               FutureBuilder<Map<String, dynamic>>(
//                 future: _getDiseaseAnalytics(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text(
//                       'Error loading analytics: ${snapshot.error}',
//                       style: TextStyle(color: Colors.red),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data == null) {
//                     return Text(
//                       'No data available',
//                       style: TextStyle(color: Colors.grey),
//                     );
//                   } else {
//                     // Display analytics data and chart
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildAnalyticsUI(snapshot.data!),
//                         SizedBox(height: 24),
//                         _buildChart(snapshot.data!['diseaseFrequency']),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> _getDiseaseAnalytics() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await FirebaseFirestore.instance
//               .collection('detected_disease')
//               .doc(userId)
//               .collection('detection_sessions')
//               .get();

//       int totalDetectionSessions = querySnapshot.size;
//       int totalDetectedDiseases = 0;
//       Map<String, int> diseaseFrequency = {};

//       querySnapshot.docs.forEach((doc) {
//         List<dynamic> diseases = doc['diseases'];

//         totalDetectedDiseases += diseases.length;

//         diseases.forEach((pest) {
//           String className = pest['className'] as String;
//           int count = (diseaseFrequency[className] as int?) ?? 0;
//           diseaseFrequency[className] = count + 1;
//         });
//       });

//       return {
//         'totalDetectionSessions': totalDetectionSessions,
//         'totalDetectedDiseases': totalDetectedDiseases,
//         'diseaseFrequency': diseaseFrequency,
//       };
//     } catch (e) {
//       print('Error getting pest analytics: $e');
//       return {};
//     }
//   }

//   Widget _buildAnalyticsUI(Map<String, dynamic> analyticsData) {
//     int totalDetectionSessions = analyticsData['totalDetectionSessions'];
//     int totalDetectedDiseases = analyticsData['totalDetectedDiseases'];
//     Map<String, int> pestFrequency = analyticsData['diseaseFrequency'];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Total Detection Sessions: $totalDetectionSessions',
//           style: TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//         Text(
//           'Total Detected Diseases: $totalDetectedDiseases',
//           style: TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//         SizedBox(height: 16),
//         Text(
//           'Disease Frequency:',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
//         ),
//         ...pestFrequency.entries
//             .map((entry) => Text('${entry.key}: ${entry.value}',
//                 style: TextStyle(fontSize: 16, color: Colors.black87)))
//             .toList(),
//       ],
//     );
//   }

//   Widget _buildChart(Map<String, int> diseaseFrequency) {
//     List<Color> colorList = [
//       Colors.blue,
//       Colors.green,
//       Colors.orange,
//     ];

//     return Container(
//       height: 500,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: PieChart(
//               PieChartData(
//                 sectionsSpace: 8,
//                 centerSpaceRadius: 40,
//                 sections: diseaseFrequency.entries
//                     .map((entry) => PieChartSectionData(
//                           value: entry.value.toDouble(),
//                           color:
//                               colorList[entry.key.hashCode % colorList.length],
//                           radius: 100,
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: diseaseFrequency.entries
//                 .map((entry) => Row(
//                       children: [
//                         Container(
//                           width: 12,
//                           height: 12,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: colorList[
//                                 entry.key.hashCode % colorList.length],
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           '${entry.key} (${_calculatePercentage(diseaseFrequency, entry.key).toStringAsFixed(2)}%)',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   double _calculatePercentage(
//       Map<String, int> diseaseFrequency, String className) {
//     int totalCount =
//         diseaseFrequency.values.reduce((sum, count) => sum + count);
//     int classCount = diseaseFrequency[className] ?? 0;

//     return (classCount / totalCount * 100).toDouble();
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DiseaseAnalyticsPage extends StatelessWidget {
  final String userId;

  DiseaseAnalyticsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Disease Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disease Detection Analytics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 16),
              _buildAnalyticsSection('week'),
              SizedBox(height: 16),
              _buildAnalyticsSection('month'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(String timeUnit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeUnit == 'week'
              ? 'Analytics for the Past Week'
              : 'Analytics for the Past Month',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 16),
        FutureBuilder<Map<String, dynamic>>(
          future: _getDiseaseAnalytics(timeUnit),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(
                'Error loading analytics: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text(
                'No data available',
                style: TextStyle(color: Colors.grey),
              );
            } else {
              // Display analytics data and chart
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnalyticsUI(snapshot.data!),
                  SizedBox(height: 24),
                  _buildChart(snapshot.data!['diseaseFrequency']),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> _getDiseaseAnalytics(String timeUnit) async {
    try {
      // Define the start and end dates based on the selected time unit
      DateTime endDate = DateTime.now();
      DateTime startDate;

      if (timeUnit == 'week') {
        startDate = endDate.subtract(Duration(days: 7));
      } else if (timeUnit == 'month') {
        startDate = endDate.subtract(Duration(days: 30));
      } else {
        // Default to fetching all data if timeUnit is not 'week' or 'month'
        startDate = DateTime(1970, 1, 1);
      }

      // Query the Firestore collection with the date range filter
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('detected_disease')
              .doc(userId)
              .collection('detection_sessions')
              .where('timestamp', isGreaterThanOrEqualTo: startDate)
              .where('timestamp', isLessThanOrEqualTo: endDate)
              .get();

      int totalDetectionSessions = querySnapshot.size;
      int totalDetectedDiseases = 0;
      Map<String, int> diseaseFrequency = {};

      querySnapshot.docs.forEach((doc) {
        List<dynamic> diseases = doc['diseases'];

        totalDetectedDiseases += diseases.length;

        diseases.forEach((disease) {
          String className = disease['className'] as String;
          int count = (diseaseFrequency[className] as int?) ?? 0;
          diseaseFrequency[className] = count + 1;
        });
      });

      return {
        'totalDetectionSessions': totalDetectionSessions,
        'totalDetectedDiseases': totalDetectedDiseases,
        'diseaseFrequency': diseaseFrequency,
      };
    } catch (e) {
      print('Error getting disease analytics: $e');
      return {};
    }
  }

  Widget _buildAnalyticsUI(Map<String, dynamic> analyticsData) {
    int totalDetectionSessions = analyticsData['totalDetectionSessions'];
    int totalDetectedDiseases = analyticsData['totalDetectedDiseases'];
    Map<String, int> diseaseFrequency = analyticsData['diseaseFrequency'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Detection Sessions: $totalDetectionSessions',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          'Total Detected Diseases: $totalDetectedDiseases',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        SizedBox(height: 16),
        Text(
          'Disease Frequency:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        ...diseaseFrequency.entries
            .map((entry) => Text('${entry.key}: ${entry.value}',
                style: TextStyle(fontSize: 16, color: Colors.black87)))
            .toList(),
      ],
    );
  }

  Widget _buildChart(Map<String, int> diseaseFrequency) {
    List<Color> colorList = [
      Colors.blue,
      Colors.green,
      Colors.orange,
    ];

    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 8,
                centerSpaceRadius: 40,
                sections: diseaseFrequency.entries
                    .map((entry) => PieChartSectionData(
                          value: entry.value.toDouble(),
                          color:
                              colorList[entry.key.hashCode % colorList.length],
                          radius: 100,
                        ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: diseaseFrequency.entries
                .map((entry) => Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorList[
                                entry.key.hashCode % colorList.length],
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${entry.key} (${_calculatePercentage(diseaseFrequency, entry.key).toStringAsFixed(2)}%)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  double _calculatePercentage(
      Map<String, int> diseaseFrequency, String className) {
    int totalCount =
        diseaseFrequency.values.reduce((sum, count) => sum + count);
    int classCount = diseaseFrequency[className] ?? 0;

    return (classCount / totalCount * 100).toDouble();
  }
}
