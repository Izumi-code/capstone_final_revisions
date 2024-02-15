// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HistoricalWeatherPage extends StatefulWidget {
//   @override
//   _HistoricalWeatherPageState createState() => _HistoricalWeatherPageState();
// }

// class _HistoricalWeatherPageState extends State<HistoricalWeatherPage> {
//   final String apiKey =
//       '575eb43a29434f6bb7c44646233010'; // Replace with your API key
//   List<HistoricalWeatherData> historicalData = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   void _fetchData() async {
//     final weatherFetcher = HistoricalWeatherFetcher(apiKey);
//     final data = await weatherFetcher.fetchHistoricalWeatherData();
//     setState(() {
//       historicalData = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Historical Weather Data'),
//       ),
//       body: ListView.builder(
//         itemCount: historicalData.length,
//         itemBuilder: (context, index) {
//           final data = historicalData[index];
//           return ListTile(
//             title: Text(data.date),
//             subtitle: Text('Max Temp: ${data.maxTempC}°C'),
//           );
//         },
//       ),
//     );
//   }
// }

// class HistoricalWeatherFetcher {
//   final String apiKey;

//   HistoricalWeatherFetcher(this.apiKey);

//   Future<List<HistoricalWeatherData>> fetchHistoricalWeatherData() async {
//     final List<HistoricalWeatherData> historicalData = [];

//     for (int i = 0; i < 7; i++) {
//       final DateTime currentDate = DateTime.now().subtract(Duration(days: i));
//       final String formattedDate =
//           currentDate.toLocal().toString().split(' ')[0];

//       final url =
//           'https://api.weatherapi.com/v1/history.json?key=$apiKey&q=Philippines,Manila&dt=$formattedDate';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         historicalData.add(
//             HistoricalWeatherData.fromJson(data['forecast']['forecastday'][0]));
//       }
//     }

//     return historicalData;
//   }
// }

// class HistoricalWeatherData {
//   final String date;
//   final double maxTempC;
//   final double minTempC;
//   final double avgTempC;
//   final double maxWindMph;
//   final double totalPrecipMm;
//   final num avgHumidity; // Updated data type to 'num'
//   final String conditionText;
//   final String conditionIcon;
//   final double uv;
//   final String sunrise;
//   final String sunset;

//   HistoricalWeatherData({
//     required this.date,
//     required this.maxTempC,
//     required this.minTempC,
//     required this.avgTempC,
//     required this.maxWindMph,
//     required this.totalPrecipMm,
//     required this.avgHumidity,
//     required this.conditionText,
//     required this.conditionIcon,
//     required this.uv,
//     required this.sunrise,
//     required this.sunset,
//   });

//   factory HistoricalWeatherData.fromJson(Map<String, dynamic> data) {
//     final day = data['day'];
//     final astro = data['astro'];

//     return HistoricalWeatherData(
//       date: data['date'],
//       maxTempC: day['maxtemp_c'],
//       minTempC: day['mintemp_c'],
//       avgTempC: day['avgtemp_c'],
//       maxWindMph: day['maxwind_mph'],
//       totalPrecipMm: day['totalprecip_mm'],
//       avgHumidity: day['avghumidity'],
//       conditionText: day['condition']['text'],
//       conditionIcon: day['condition']['icon'],
//       uv: day['uv'],
//       sunrise: astro['sunrise'],
//       sunset: astro['sunset'],
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HistoricalWeatherPage(),
//   ));
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MaterialApp(
//     home: HistoricalWeatherPage(),
//   ));
// }

// class HistoricalWeatherPage extends StatefulWidget {
//   @override
//   _HistoricalWeatherPageState createState() => _HistoricalWeatherPageState();
// }

// class _HistoricalWeatherPageState extends State<HistoricalWeatherPage> {
//   final String apiKey =
//       '575eb43a29434f6bb7c44646233010'; // Replace with your API key
//   List<HistoricalWeatherData> historicalData = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   void _fetchData() async {
//     final weatherFetcher = HistoricalWeatherFetcher(apiKey);
//     final data = await weatherFetcher.fetchHistoricalWeatherData();
//     setState(() {
//       historicalData = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Historical Weather Data'),
//       ),
//       body: Container(
//         child: historicalData.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: historicalData.length,
//                 itemBuilder: (context, index) {
//                   final data = historicalData[index];
//                   return Card(
//                     elevation: 2.0,
//                     margin: EdgeInsets.all(8.0),
//                     child: ListTile(
//                       title: Text(data.date),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Max Temp: ${data.maxTempC}°C'),
//                           Text('Min Temp: ${data.minTempC}°C'),
//                           Text('Avg Temp: ${data.avgTempC}°C'),
//                           Text('Max Wind: ${data.maxWindMph} mph'),
//                           Text('Total Precip: ${data.totalPrecipMm} mm'),
//                           Text('Avg Humidity: ${data.avgHumidity}%'),
//                           Text('Condition: ${data.conditionText}'),
//                           Text('UV: ${data.uv}'),
//                           Text('Sunrise: ${data.sunrise}'),
//                           Text('Sunset: ${data.sunset}'),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

// class HistoricalWeatherFetcher {
//   final String apiKey;

//   HistoricalWeatherFetcher(this.apiKey);

//   Future<List<HistoricalWeatherData>> fetchHistoricalWeatherData() async {
//     final List<HistoricalWeatherData> historicalData = [];

//     for (int i = 0; i < 7; i++) {
//       final DateTime currentDate = DateTime.now().subtract(Duration(days: i));
//       final String formattedDate =
//           currentDate.toLocal().toString().split(' ')[0];

//       final url =
//           'https://api.weatherapi.com/v1/history.json?key=$apiKey&q=Philippines,Manila&dt=$formattedDate';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         historicalData.add(
//             HistoricalWeatherData.fromJson(data['forecast']['forecastday'][0]));
//       }
//     }

//     return historicalData;
//   }
// }

// class HistoricalWeatherData {
//   final String date;
//   final double maxTempC;
//   final double minTempC;
//   final double avgTempC;
//   final double maxWindMph;
//   final double totalPrecipMm;
//   final num avgHumidity; // Updated data type to 'num'
//   final String conditionText;
//   final String conditionIcon;
//   final double uv;
//   final String sunrise;
//   final String sunset;

//   HistoricalWeatherData({
//     required this.date,
//     required this.maxTempC,
//     required this.minTempC,
//     required this.avgTempC,
//     required this.maxWindMph,
//     required this.totalPrecipMm,
//     required this.avgHumidity,
//     required this.conditionText,
//     required this.conditionIcon,
//     required this.uv,
//     required this.sunrise,
//     required this.sunset,
//   });

//   factory HistoricalWeatherData.fromJson(Map<String, dynamic> data) {
//     final day = data['day'];
//     final astro = data['astro'];

//     return HistoricalWeatherData(
//       date: data['date'],
//       maxTempC: day['maxtemp_c'],
//       minTempC: day['mintemp_c'],
//       avgTempC: day['avgtemp_c'],
//       maxWindMph: day['maxwind_mph'],
//       totalPrecipMm: day['totalprecip_mm'],
//       avgHumidity: day['avghumidity'],
//       conditionText: day['condition']['text'],
//       conditionIcon: day['condition']['icon'],
//       uv: day['uv'],
//       sunrise: astro['sunrise'],
//       sunset: astro['sunset'],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MaterialApp(
//     home: HistoricalWeatherPage(),
//   ));
// }

class HistoricalWeatherPage extends StatefulWidget {
  @override
  _HistoricalWeatherPageState createState() => _HistoricalWeatherPageState();
}

class _HistoricalWeatherPageState extends State<HistoricalWeatherPage> {
  final String apiKey =
      '575eb43a29434f6bb7c44646233010'; // Replace with your API key
  String currentLocation = 'Manila, Philippines';
  List<HistoricalWeatherData> historicalData = [];
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData(currentLocation);
  }

  void _fetchData(String location) async {
    final weatherFetcher = HistoricalWeatherFetcher(apiKey);
    final data = await weatherFetcher.fetchHistoricalWeatherData(location);

    if (!mounted) {
      // Check if the widget is still mounted before calling setState
      return;
    }

    setState(() {
      historicalData = data;
    });
  }

  void _searchLocation() {
    final newLocation = locationController.text;
    if (newLocation.isNotEmpty) {
      setState(() {
        currentLocation = newLocation;
      });
      _fetchData(newLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical Weather Data'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Enter Location'),
              ),
            ),
            ElevatedButton(
              onPressed: _searchLocation,
              child: Text('Search'),
            ),
            Text(
              'Location: $currentLocation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: historicalData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: historicalData.length,
                      itemBuilder: (context, index) {
                        final data = historicalData[index];
                        return Card(
                          elevation: 2.0,
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(data.date),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Max Temp: ${data.maxTempC}°C'),
                                Text('Min Temp: ${data.minTempC}°C'),
                                Text('Avg Temp: ${data.avgTempC}°C'),
                                Text('Max Wind: ${data.maxWindMph} mph'),
                                Text('Total Precip: ${data.totalPrecipMm} mm'),
                                Text('Avg Humidity: ${data.avgHumidity}%'),
                                Text('Condition: ${data.conditionText}'),
                                Text('UV: ${data.uv}'),
                                Text('Sunrise: ${data.sunrise}'),
                                Text('Sunset: ${data.sunset}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoricalWeatherFetcher {
  final String apiKey;

  HistoricalWeatherFetcher(this.apiKey);

  Future<List<HistoricalWeatherData>> fetchHistoricalWeatherData(
      String location) async {
    final List<HistoricalWeatherData> historicalData = [];

    for (int i = 0; i < 7; i++) {
      final DateTime currentDate = DateTime.now().subtract(Duration(days: i));
      final String formattedDate =
          currentDate.toLocal().toString().split(' ')[0];

      final url =
          'https://api.weatherapi.com/v1/history.json?key=$apiKey&q=$location&dt=$formattedDate';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        historicalData.add(HistoricalWeatherData.fromJson(
            data['forecast']['forecastday'][0], location));
      }
    }

    return historicalData;
  }
}

class HistoricalWeatherData {
  final String date;
  final double maxTempC;
  final double minTempC;
  final double avgTempC;
  final double maxWindMph;
  final double totalPrecipMm;
  final num avgHumidity;
  final String conditionText;
  final String conditionIcon;
  final double uv;
  final String sunrise;
  final String sunset;
  final String location;

  HistoricalWeatherData({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.maxWindMph,
    required this.totalPrecipMm,
    required this.avgHumidity,
    required this.conditionText,
    required this.conditionIcon,
    required this.uv,
    required this.sunrise,
    required this.sunset,
    required this.location,
  });

  factory HistoricalWeatherData.fromJson(
      Map<String, dynamic> data, String location) {
    final day = data['day'];
    final astro = data['astro'];

    return HistoricalWeatherData(
      date: data['date'],
      maxTempC: day['maxtemp_c'],
      minTempC: day['mintemp_c'],
      avgTempC: day['avgtemp_c'],
      maxWindMph: day['maxwind_mph'],
      totalPrecipMm: day['totalprecip_mm'],
      avgHumidity: day['avghumidity'],
      conditionText: day['condition']['text'],
      conditionIcon: day['condition']['icon'],
      uv: day['uv'],
      sunrise: astro['sunrise'],
      sunset: astro['sunset'],
      location: location,
    );
  }
}
