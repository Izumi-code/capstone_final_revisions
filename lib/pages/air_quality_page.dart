// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MaterialApp(
//     home: AirQualityPage(),
//   ));
// }

// class AirQualityPage extends StatefulWidget {
//   @override
//   _AirQualityPageState createState() => _AirQualityPageState();
// }

// class _AirQualityPageState extends State<AirQualityPage> {
//   final String apiKey =
//       'YOUR_API_KEY_HERE'; // Replace with your OpenWeather API key
//   Map<String, dynamic> airQualityData = {};
//   Position? currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     fetchCurrentLocation();
//   }

//   Future<void> fetchCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       currentPosition = position;
//     });
//     fetchAirQualityData(position.latitude, position.longitude);
//   }

//   Future<void> fetchAirQualityData(double latitude, double longitude) async {
//     final response = await http.get(Uri.parse(
//         'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         airQualityData = data;
//       });
//     }
//   }

//   String getAirQualityText(int aqi) {
//     if (aqi == 1) return 'Good';
//     if (aqi == 2) return 'Fair';
//     if (aqi == 3) return 'Moderate';
//     if (aqi == 4) return 'Poor';
//     if (aqi == 5) return 'Very Poor';
//     return 'Unknown';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Air Quality'),
//       ),
//       body: airQualityData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 if (currentPosition != null)
//                   ListTile(
//                     title: Text('Location'),
//                     subtitle: Text(
//                         'Lat: ${currentPosition!.latitude.toStringAsFixed(2)}, Lon: ${currentPosition!.longitude.toStringAsFixed(2)}'),
//                   ),
//                 ListTile(
//                   title: Text('Date and Time'),
//                   subtitle: Text(
//                       DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())),
//                 ),
//                 ListTile(
//                   title: Text('Air Quality Index (AQI)'),
//                   subtitle:
//                       Text(airQualityData['list'][0]['main']['aqi'].toString()),
//                 ),
//                 ListTile(
//                   title: Text('Air Quality'),
//                   subtitle: Text(getAirQualityText(
//                       airQualityData['list'][0]['main']['aqi'])),
//                 ),
//                 ListTile(
//                   title: Text('Carbon Monoxide (CO)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['co']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Nitrogen Monoxide (NO)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['no']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Nitrogen Dioxide (NO2)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['no2']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Ozone (O3)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['o3']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Sulphur Dioxide (SO2)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['so2']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('PM2.5'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['pm2_5']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('PM10'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['pm10']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Ammonia (NH3)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['nh3']} μg/m³'),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:geocoding/geocoding.dart';

// void main() {
//   runApp(MaterialApp(
//     home: AirQualityPage(),
//   ));
// }

// class AirQualityPage extends StatefulWidget {
//   @override
//   _AirQualityPageState createState() => _AirQualityPageState();
// }

// class _AirQualityPageState extends State<AirQualityPage> {
//   final String apiKey =
//       'd035a3d4def60ad850d19bac5675129b'; // Replace with your OpenWeather API key
//   Map<String, dynamic> airQualityData = {};
//   Position? currentPosition;
//   String? currentLocationName;
//   String searchLocationName = ''; // Store the searched location

//   @override
//   void initState() {
//     super.initState();
//     fetchAirQualityDataForManila(); // Fetch data for Manila by default
//   }

//   Future<void> fetchAirQualityDataForManila() async {
//     double latitude = 13.41;
//     double longitude = 122.56;
//     fetchAirQualityData(latitude, longitude);
//     await setLocationName(latitude, longitude);
//   }

//   Future<void> fetchAirQualityData(double latitude, double longitude) async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey'));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           airQualityData = data;
//         });
//       }
//     } catch (e) {
//       print('Error fetching air quality data: $e');
//     }
//   }

//   String getAirQualityText(int aqi) {
//     if (aqi == 1) return 'Good';
//     if (aqi == 2) return 'Fair';
//     if (aqi == 3) return 'Moderate';
//     if (aqi == 4) return 'Poor';
//     if (aqi == 5) return 'Very Poor';
//     return 'Unknown';
//   }

//   Future<void> setLocationName(double latitude, double longitude) async {
//     try {
//       final List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//       if (placemarks.isNotEmpty) {
//         setState(() {
//           currentLocationName = placemarks[0].locality;
//         });
//       }
//     } catch (e) {
//       print('Error fetching location name: $e');
//       setState(() {
//         currentLocationName = 'Location Name Unavailable';
//       });
//     }
//   }

//   Future<void> fetchCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         currentPosition = position;
//       });
//       await setLocationName(position.latitude, position.longitude);
//       fetchAirQualityData(position.latitude, position.longitude);
//     } catch (e) {
//       print('Error fetching current location: $e');
//     }
//   }

//   Future<void> searchLocation() async {
//     if (searchLocationName.isNotEmpty) {
//       try {
//         List<Location> locations =
//             await locationFromAddress(searchLocationName);
//         if (locations.isNotEmpty) {
//           Location firstLocation = locations.first;
//           double latitude = firstLocation.latitude;
//           double longitude = firstLocation.longitude;
//           fetchAirQualityData(latitude, longitude);
//           await setLocationName(latitude, longitude);
//         } else {
//           print('Location not found');
//           setState(() {
//             currentLocationName = 'Location Not Found';
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Location not found'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//       } catch (e) {
//         print('Error searching location: $e');
//       }
//     } else {
//       print('Location name is empty');
//       setState(() {
//         currentLocationName = 'Location Name Unavailable';
//       });
//     }
//   }

//   void _showInfoDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Air Quality Information'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Air Quality Index (AQI):'),
//                 Text(
//                     'The AQI is a measure of how clean or polluted the air is and what health effects you might experience.'),
//                 Text('Effect on People:'),
//                 Text(
//                     '1. Good: Minimal impact on health.\n2. Fair: Moderate health concern for a very small number of people.\n3. Moderate: Unusually sensitive people may experience health effects. The general public is unlikely to be affected.\n4. Poor: Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.\n5. Very Poor: Health alert: everyone may experience more serious health effects.'),
//                 Text('Gases:'),
//                 Text(
//                     'The API returns data about various polluting gases, such as Carbon monoxide (CO), Nitrogen monoxide (NO), Nitrogen dioxide (NO2), Ozone (O3), Sulphur dioxide (SO2), Ammonia (NH3), and particulates (PM2.5 and PM10). The levels of these gases can affect air quality and health.'),
//                 Text('Effect on Crops/Plants:'),
//                 Text(
//                     'High levels of certain gases can damage crops and plants.'),
//                 Text('General Air Pollution:'),
//                 Text(
//                     'High levels of air pollution can be harmful to human health and the environment.'),
//                 Text('Additional Information on Gases:'),
//                 _buildGasSection(
//                   'CO (Carbon monoxide)',
//                   'Concentration (μg/m³): This measures the amount of carbon monoxide in the air.',
//                   'Effects on Crops: High levels of CO can reduce crop yields and damage plant health. It can interfere with the photosynthesis process and negatively impact plant growth. In particular, fruits and vegetables can be adversely affected by elevated CO levels.',
//                 ),
//                 _buildGasSection(
//                   'NO (Nitrogen monoxide)',
//                   'Concentration (μg/m³): This measures the amount of nitrogen monoxide in the air.',
//                   'Effects on Crops: Elevated NO levels can lead to reduced crop production and impact the quality of crops. It can disrupt plant metabolism and nutrient uptake, affecting the growth of various crops.',
//                 ),
//                 _buildGasSection(
//                   'NO2 (Nitrogen dioxide)',
//                   'Concentration (μg/m³): This measures the amount of nitrogen dioxide in the air.',
//                   'Effects on Crops: High levels of NO2 can lead to leaf damage, reduced growth, and yield loss in crops. It can also impair the plant\'s ability to absorb essential nutrients from the soil.',
//                 ),
//                 _buildGasSection(
//                   'O3 (Ozone)',
//                   'Concentration (μg/m³): This measures the amount of ozone in the air.',
//                   'Effects on Crops: Ozone can cause visible injury to crops, such as leaf damage and yellowing. It can reduce crop yields, particularly in sensitive plants like beans, grapes, and tobacco.',
//                 ),
//                 _buildGasSection(
//                   'SO2 (Sulphur dioxide)',
//                   'Concentration (μg/m³): This measures the amount of sulfur dioxide in the air.',
//                   'Effects on Crops: High SO2 levels can result in leaf injury, reduced photosynthesis, and yield loss in crops. Sulfur dioxide can also disrupt the plant\'s ability to take up essential nutrients.',
//                 ),
//                 _buildGasSection(
//                   'PM2.5 (Fine Particles Matter)',
//                   'Concentration (μg/m³): This measures the concentration of fine particles with a diameter of 2.5 micrometers or smaller.',
//                   'Effects on Crops: PM2.5 can settle on plant surfaces, reducing the amount of sunlight that reaches leaves. It can also negatively affect plant growth, reduce photosynthesis, and lead to decreased crop yields.',
//                 ),
//                 _buildGasSection(
//                   'PM10 (Coarse Particulate Matter)',
//                   'Concentration (μg/m³): This measures the concentration of larger particles with a diameter of 10 micrometers or smaller.',
//                   'Effects on Crops: PM10 can physically damage plant tissues, leading to leaf necrosis and reduced crop quality. It can also disrupt the overall health of plants and reduce crop yields.',
//                 ),
//                 _buildGasSection(
//                   'NH3 (Ammonia)',
//                   'Concentration (μg/m³): This measures the amount of ammonia in the air.',
//                   'Effects on Crops: High ammonia levels can cause damage to plant leaves, impair photosynthesis, and negatively impact crop growth. It can also lead to nutrient imbalances in plants.',
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildGasSection(
//       String title, String concentration, String effectsOnCrops) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//         Text(concentration),
//         Text(effectsOnCrops),
//         SizedBox(height: 10), // Add some space between sections
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Air Quality'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info),
//             onPressed: _showInfoDialog,
//           ),
//         ],
//       ),
//       body: airQualityData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 Text(
//                   'Location: ${currentLocationName ?? "Fetching location..."}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 ListTile(
//                   title: Text('Search Location (e.g., "Manila, Philippines")'),
//                   subtitle: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         searchLocationName = value;
//                       });
//                     },
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     searchLocation();
//                   },
//                   child: Text('Search Location'),
//                 ),
//                 ListTile(
//                   title: Text('Date and Time'),
//                   subtitle: Text(
//                     DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text('Air Quality Index (AQI)'),
//                   subtitle:
//                       Text(airQualityData['list'][0]['main']['aqi'].toString()),
//                 ),
//                 ListTile(
//                   title: Text('Air Quality'),
//                   subtitle: Text(getAirQualityText(
//                       airQualityData['list'][0]['main']['aqi'])),
//                 ),
//                 ListTile(
//                   title: Text('Carbon Monoxide (CO)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['co']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Nitrogen Monoxide (NO)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['no']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Nitrogen Dioxide (NO2)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['no2']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Ozone (O3)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['o3']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('Sulphur Dioxide (SO2)'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['so2']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('PM2.5'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['pm2_5']} μg/m³'),
//                 ),
//                 ListTile(
//                   title: Text('PM10'),
//                   subtitle: Text(
//                       '${airQualityData['list'][0]['components']['pm10']} μg/m³'),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MaterialApp(
    home: AirQualityPage(),
  ));
}

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  final String apiKey =
      'd035a3d4def60ad850d19bac5675129b'; // Replace with your OpenWeather API key
  Map<String, dynamic> airQualityData = {};
  Position? currentPosition;
  String currentLocationName = "Manila"; // Default to Manila
  String searchLocationName = '';

  @override
  void initState() {
    super.initState();
    currentLocationName = "Manila"; // Set the default location to Manila
    fetchAirQualityDataForManila(); // Fetch data for Manila by default
  }

  Future<void> fetchAirQualityDataForManila() async {
    double latitude = 13.41;
    double longitude = 122.56;
    fetchAirQualityData(latitude, longitude);
    await setLocationName(latitude, longitude);
  }

  Future<void> fetchAirQualityData(double latitude, double longitude) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          airQualityData = data;
        });
      }
    } catch (e) {
      print('Error fetching air quality data: $e');
    }
  }

  String getAirQualityText(int aqi) {
    if (aqi == 1) return 'Good';
    if (aqi == 2) return 'Fair';
    if (aqi == 3) return 'Moderate';
    if (aqi == 4) return 'Poor';
    if (aqi == 5) return 'Very Poor';
    return 'Unknown';
  }

  Future<void> setLocationName(double latitude, double longitude) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          currentLocationName = placemarks[0].locality!;
        });
      }
    } catch (e) {
      print('Error fetching location name: $e');
      setState(() {
        currentLocationName = 'Location Name Unavailable';
      });
    }
  }

  Future<void> fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentPosition = position;
      });
      await setLocationName(position.latitude, position.longitude);
      fetchAirQualityData(position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching current location: $e');
    }
  }

  Future<void> searchLocation() async {
    if (searchLocationName.isNotEmpty) {
      try {
        List<Location> locations =
            await locationFromAddress(searchLocationName);

        if (locations.isNotEmpty) {
          Location firstLocation = locations.first;
          double latitude = firstLocation.latitude;
          double longitude = firstLocation.longitude;

          List<Placemark> placemarks =
              await placemarkFromCoordinates(latitude, longitude);

          bool isLocationInPhilippines = false;

          for (var placemark in placemarks) {
            if (placemark.country == 'Philippines') {
              isLocationInPhilippines = true;
              break;
            }
          }

          if (isLocationInPhilippines) {
            fetchAirQualityData(latitude, longitude);
            await setLocationName(latitude, longitude);
          } else {
            print('Location not found in the Philippines');
            setState(() {
              currentLocationName = 'Location Not Found in the Philippines';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Location not found in the Philippines'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          print('Location not found');
          setState(() {
            currentLocationName = 'Location Not Found';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location not found'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print('Error searching location: $e');
      }
    } else {
      print('Location name is empty');
      setState(() {
        currentLocationName = 'Location Name Unavailable';
      });
    }
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Air Quality Information'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Air Quality Index (AQI):'),
                Text(
                    'The AQI is a measure of how clean or polluted the air is and what health effects you might experience.'),
                Text('Effect on People:'),
                Text(
                    '1. Good: Minimal impact on health.\n2. Fair: Moderate health concern for a very small number of people.\n3. Moderate: Unusually sensitive people may experience health effects. The general public is unlikely to be affected.\n4. Poor: Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.\n5. Very Poor: Health alert: everyone may experience more serious health effects.'),
                Text('Gases:'),
                Text(
                    'The API returns data about various polluting gases, such as Carbon monoxide (CO), Nitrogen monoxide (NO), Nitrogen dioxide (NO2), Ozone (O3), Sulphur dioxide (SO2), Ammonia (NH3), and particulates (PM2.5 and PM10). The levels of these gases can affect air quality and health.'),
                Text('Effect on Crops/Plants:'),
                Text(
                    'High levels of certain gases can damage crops and plants.'),
                Text('General Air Pollution:'),
                Text(
                    'High levels of air pollution can be harmful to human health and the environment.'),
                Text('Additional Information on Gases:'),
                _buildGasSection(
                  'CO (Carbon monoxide)',
                  'Concentration (μg/m³): This measures the amount of carbon monoxide in the air.',
                  'Effects on Crops: High levels of CO can reduce crop yields and damage plant health. It can interfere with the photosynthesis process and negatively impact plant growth. In particular, fruits and vegetables can be adversely affected by elevated CO levels.',
                ),
                _buildGasSection(
                  'NO (Nitrogen monoxide)',
                  'Concentration (μg/m³): This measures the amount of nitrogen monoxide in the air.',
                  'Effects on Crops: Elevated NO levels can lead to reduced crop production and impact the quality of crops. It can disrupt plant metabolism and nutrient uptake, affecting the growth of various crops.',
                ),
                _buildGasSection(
                  'NO2 (Nitrogen dioxide)',
                  'Concentration (μg/m³): This measures the amount of nitrogen dioxide in the air.',
                  'Effects on Crops: High levels of NO2 can lead to leaf damage, reduced growth, and yield loss in crops. It can also impair the plant\'s ability to absorb essential nutrients from the soil.',
                ),
                _buildGasSection(
                  'O3 (Ozone)',
                  'Concentration (μg/m³): This measures the amount of ozone in the air.',
                  'Effects on Crops: Ozone can cause visible injury to crops, such as leaf damage and yellowing. It can reduce crop yields, particularly in sensitive plants like beans, grapes, and tobacco.',
                ),
                _buildGasSection(
                  'SO2 (Sulphur dioxide)',
                  'Concentration (μg/m³): This measures the amount of sulfur dioxide in the air.',
                  'Effects on Crops: High SO2 levels can result in leaf injury, reduced photosynthesis, and yield loss in crops. Sulfur dioxide can also disrupt the plant\'s ability to take up essential nutrients.',
                ),
                _buildGasSection(
                  'PM2.5 (Fine Particles Matter)',
                  'Concentration (μg/m³): This measures the concentration of fine particles with a diameter of 2.5 micrometers or smaller.',
                  'Effects on Crops: PM2.5 can settle on plant surfaces, reducing the amount of sunlight that reaches leaves. It can also negatively affect plant growth, reduce photosynthesis, and lead to decreased crop yields.',
                ),
                _buildGasSection(
                  'PM10 (Coarse Particulate Matter)',
                  'Concentration (μg/m³): This measures the concentration of larger particles with a diameter of 10 micrometers or smaller.',
                  'Effects on Crops: PM10 can physically damage plant tissues, leading to leaf necrosis and reduced crop quality. It can also disrupt the overall health of plants and reduce crop yields.',
                ),
                _buildGasSection(
                  'NH3 (Ammonia)',
                  'Concentration (μg/m³): This measures the amount of ammonia in the air.',
                  'Effects on Crops: High ammonia levels can cause damage to plant leaves, impair photosynthesis, and negatively impact crop growth. It can also lead to nutrient imbalances in plants.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGasSection(
      String title, String concentration, String effectsOnCrops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(concentration),
        Text(effectsOnCrops),
        SizedBox(height: 10), // Add some space between sections
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Quality'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showInfoDialog,
          ),
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: fetchCurrentLocation,
          ),
        ],
      ),
      body: airQualityData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  'Location: $currentLocationName',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Search Location (e.g., "Manila, Philippines")'),
                  subtitle: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchLocationName = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    searchLocation();
                  },
                  child: Text('Search Location'),
                ),
                ListTile(
                  title: Text('Date and Time'),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                  ),
                ),
                ListTile(
                  title: Text('Air Quality Index (AQI)'),
                  subtitle:
                      Text(airQualityData['list'][0]['main']['aqi'].toString()),
                ),
                ListTile(
                  title: Text('Air Quality'),
                  subtitle: Text(getAirQualityText(
                      airQualityData['list'][0]['main']['aqi'])),
                ),
                ListTile(
                  title: Text('Carbon Monoxide (CO)'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['co']} μg/m³'),
                ),
                ListTile(
                  title: Text('Nitrogen Monoxide (NO)'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['no']} μg/m³'),
                ),
                ListTile(
                  title: Text('Nitrogen Dioxide (NO2)'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['no2']} μg/m³'),
                ),
                ListTile(
                  title: Text('Ozone (O3)'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['o3']} μg/m³'),
                ),
                ListTile(
                  title: Text('Sulphur Dioxide (SO2)'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['so2']} μg/m³'),
                ),
                ListTile(
                  title: Text('PM2.5'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['pm2_5']} μg/m³'),
                ),
                ListTile(
                  title: Text('PM10'),
                  subtitle: Text(
                      '${airQualityData['list'][0]['components']['pm10']} μg/m³'),
                ),
              ],
            ),
    );
  }
}
