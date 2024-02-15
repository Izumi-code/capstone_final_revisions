// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'location_search_delegate.dart';

// class WeatherForecastPage extends StatefulWidget {
//   @override
//   _WeatherForecastPageState createState() => _WeatherForecastPageState();
// }

// class _WeatherForecastPageState extends State<WeatherForecastPage> {
//   final String apiKey = '575eb43a29434f6bb7c44646233010';
//   String location = ''; // Empty string as the default location
//   Map<String, dynamic> weatherData = {};

//   final String hiveBoxName = 'settings';

//   // Hive box for storing weather data
//   late Box<Map<String, dynamic>> weatherDataBox;

//   Widget loadWeatherIcon(String iconUrl) {
//     if (iconUrl != null && iconUrl.isNotEmpty) {
//       return Image.network(
//         'https:$iconUrl',
//         width: 50,
//         height: 50,
//       );
//     } else {
//       return Image.asset(
//         'assets/images/weather/day/113.png',
//         width: 50,
//         height: 50,
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     initHive();
//     // Load default location from Hive and fetch weather data
//     loadDefaultLocationAndFetchWeatherData();
//   }

//   late Box<Map<String, dynamic>> forecastDataBox;
//   late Box<List<dynamic>> hourlyForecastDataBox;
//   Future<void> initHive() async {
//     WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
//     final appDocumentDirectory = await getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDirectory.path);

//     // Open Hive box for weather data
//     weatherDataBox = await Hive.openBox<Map<String, dynamic>>(
//       'weatherDataBox',
//     );

//     /// Open Hive box for forecast data
//     forecastDataBox = await Hive.openBox<Map<String, dynamic>>(
//       'forecastDataBox',
//     );
//     // Open Hive box for hourly forecast data
//     hourlyForecastDataBox = await Hive.openBox<List<dynamic>>(
//       'hourlyForecastDataBox',
//     );
//   }

//   Future<void> loadDefaultLocationAndFetchWeatherData() async {
//     await initHive(); // Ensure Hive is initialized before usage
//     // Check if the default location is already set in Hive
//     final box = await Hive.openBox(hiveBoxName);
//     final storedLocation = box.get('location', defaultValue: '');

//     if (storedLocation.isNotEmpty) {
//       // Default location is set, fetch weather data
//       setState(() {
//         location = 'Philippines, $storedLocation';
//       });
//       fetchWeatherData();
//     } else {
//       // Default location is not set, show the set default location page
//       setDefaultLocation();
//     }
//   }

//   Future<void> fetchWeatherData() async {
//     final url =
//         'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=Philippines,$location&days=3';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final weatherData = json.decode(response.body);

//       // Save current weather data to Hive
//       await weatherDataBox.put('weatherData', weatherData['current']);

//       // Save entire forecast data to Hive
//       await forecastDataBox.put('forecastData', weatherData['forecast']);

//       // Save hourly forecast data to Hive for all days
//       await hourlyForecastDataBox.put('hourlyForecastData', [
//         for (var day in weatherData['forecast']['forecastday']) ...day['hour'],
//       ]);

//       // Print the stored data for confirmation
//       final storedWeatherData = weatherDataBox.get('weatherData');
//       final storedForecastData = forecastDataBox.get('forecastData');
//       final storedHourlyForecastData =
//           hourlyForecastDataBox.get('hourlyForecastData', defaultValue: []);

//       print('Stored Weather Data: $storedWeatherData');
//       print('Stored Forecast Data: $storedForecastData');
//       print('Stored Hourly Forecast Data: $storedHourlyForecastData');

//       setState(() {
//         this.weatherData = weatherData;
//       });
//     }
//   }

//   // Function to build the hourly weather conditions
//   List<Widget> buildHourlyWeatherConditions(List<dynamic> hourlyForecastList) {
//     List<Widget> hourlyConditions = [];
//     for (var hourData in hourlyForecastList) {
//       hourlyConditions.add(
//         ListTile(
//           title: Text('Time: ${hourData['time']}'),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Temperature: ${hourData['temp_c']}°C'),
//               Text('Weather Condition: ${hourData['condition']['text']}'),
//             ],
//           ),
//         ),
//       );
//     }
//     return hourlyConditions;
//   }

//   List<Widget> buildWeatherConditions(List<dynamic> forecastList) {
//     List<Widget> conditions = [];
//     for (var forecast in forecastList) {
//       conditions.add(
//         GestureDetector(
//           onTap: () {
//             show4HourForecastDialog(context, forecast['hour']);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.green, width: 2),
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.only(bottom: 10),
//             child: Column(
//               children: [
//                 Text(
//                   'Date: ${forecast['date']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Max Temp: ${forecast['day']['maxtemp_c']}°C',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     Text(
//                       'Min Temp: ${forecast['day']['mintemp_c']}°C',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Weather Condition: ', style: TextStyle(fontSize: 18)),
//                     Text(
//                       forecast['day']['condition']['text'],
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     loadWeatherIcon(forecast['day']['condition']['icon']),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     return conditions;
//   }

//   Future<void> setLocationAndFetchWeatherData(String selectedLocation) async {
//     await Hive.openBox(hiveBoxName).then((box) {
//       box.put('location', selectedLocation);
//       setState(() {
//         location = 'Philippines, $selectedLocation';
//       });
//       fetchWeatherData();
//     });
//   }

//   Future<void> fetchWeatherDataForLocation(Position position) async {
//     final url =
//         'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${position.latitude},${position.longitude}&days=3';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final weatherData = json.decode(response.body);

//       // Save data to Hive
//       await weatherDataBox.put('weatherData', weatherData);

//       setState(() {
//         this.weatherData = weatherData;
//       });
//     }
//   }

//   Future<void> getLocationAndFetchWeatherData() async {
//     LocationPermission permission = await Geolocator.requestPermission();

//     if (permission == LocationPermission.denied) {
//       // Handle the case where the user denies location permission.
//     } else if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       fetchWeatherDataForLocation(position);
//     }
//   }

//   Future<void> setDefaultLocation() async {
//     await Future.delayed(Duration.zero);

//     // Check if the default location is already set
//     if (location.isNotEmpty) {
//       bool setDefaultAgain = await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Set Default Location'),
//           content: Text('Do you want to set a new default location?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pop(true); // User wants to set a new default location
//               },
//               child: Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(
//                     false); // User doesn't want to set a new default location
//               },
//               child: Text('No'),
//             ),
//           ],
//         ),
//       );

//       if (setDefaultAgain != null && setDefaultAgain) {
//         // User wants to set a new default location
//         final String? selectedLocation = await showSearch(
//           context: context,
//           delegate: LocationSearchDelegate(),
//         );

//         if (selectedLocation != null && selectedLocation.isNotEmpty) {
//           await Hive.openBox(hiveBoxName).then((box) async {
//             await box.put('location', selectedLocation);
//           });

//           setState(() {
//             location = 'Philippines, $selectedLocation';
//           });

//           fetchWeatherData();

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Default location set to $selectedLocation'),
//             ),
//           );
//         }
//       } else {
//         // User doesn't want to set a new default location
//         return;
//       }
//     } else {
//       // Default location is not set, show the search page
//       final String? selectedLocation = await showSearch(
//         context: context,
//         delegate: LocationSearchDelegate(),
//       );

//       if (selectedLocation != null && selectedLocation.isNotEmpty) {
//         await Hive.openBox(hiveBoxName).then((box) async {
//           await box.put('location', selectedLocation);
//         });

//         setState(() {
//           location = 'Philippines, $selectedLocation';
//         });

//         fetchWeatherData();

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Default location set to $selectedLocation'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (location.isEmpty) {
//       // Show an empty state until the user sets their default location
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Agriculture Weather Forecast'),
//           backgroundColor: Colors.green,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.location_city),
//               onPressed: setDefaultLocation,
//             ),
//           ],
//         ),
//         body: Center(
//           child: Text(
//             'Please set your default location',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       );
//     }

//     if (weatherData.isEmpty) {
//       return Center(child: CircularProgressIndicator());
//     }

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Agriculture Weather Forecast'),
//           backgroundColor: Colors.green,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: LocationSearchDelegate(),
//                 ).then((value) {
//                   if (value != null) {
//                     setLocationAndFetchWeatherData(value);
//                   }
//                 });
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.location_on),
//               onPressed: getLocationAndFetchWeatherData,
//             ),
//             IconButton(
//               icon: Icon(Icons.location_city),
//               onPressed: setDefaultLocation,
//             ),
//           ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Current Weather'),
//               Tab(text: 'Notification'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             buildCurrentWeatherTab(),
//             buildNotificationTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCurrentWeatherTab() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Card(
//             elevation: 4,
//             shadowColor: Colors.green,
//             child: Container(
//               padding: EdgeInsets.all(16),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Location: ${weatherData['location']['name']}, ${weatherData['location']['region']}',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Local Time: ${weatherData['location']['localtime']}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'Last Updated: ${weatherData['current']['last_updated']}',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Temperature: ${weatherData['current']['temp_c']}°C',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Row(
//                       children: [
//                         Text('Weather Condition: ',
//                             style: TextStyle(fontSize: 18)),
//                         Text(
//                           weatherData['current']['condition']['text'],
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         loadWeatherIcon(
//                             weatherData['current']['condition']['icon']),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Precipitation: ${weatherData['current']['precip_mm']} mm',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'Wind Speed: ${weatherData['current']['wind_kph']} km/h',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'Humidity: ${weatherData['current']['humidity']}%',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'Cloud Cover: ${weatherData['current']['cloud']}%',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'UV Index: ${weatherData['current']['uv']}',
//                       style: TextStyle(fontSize: 18),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             '3-Day Forecast',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: ListView(
//               children: buildWeatherConditions(
//                   weatherData['forecast']['forecastday']),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildNotificationTab() {
//     // Check conditions for displaying a notification
//     bool showNotification = checkNotificationConditions();

//     if (showNotification) {
//       // Get specific insights based on weather conditions
//       List<String> actionableInsights = getActionableInsights();
//       double uvIndex = weatherData['current']['uv'];
//       double precipitation = weatherData['current']['precip_mm'];
//       int cloudCover = weatherData['current']['cloud'];

//       return SingleChildScrollView(
//         child: Column(
//           children: [
//             // Display weather data
//             Card(
//               elevation: 4,
//               shadowColor: Colors.blue, // Customize the shadow color
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.lightBlue[100], // Use a light blue color
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '🌦️ Current Weather',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text('UV Index: $uvIndex'),
//                     Text('Precipitation: $precipitation mm'),
//                     Text('Cloud Cover: $cloudCover%'),
//                   ],
//                 ),
//               ),
//             ),

//             // Display actionable insights
//             ...actionableInsights.map((insight) => Card(
//                   elevation: 4,
//                   shadowColor: Colors.green, // Customize the shadow color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.lightGreen[100], // Use a light green color
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '🌦️ Weather Insights',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(insight, style: TextStyle(fontSize: 18)),
//                       ],
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       );
//     } else {
//       // Return an empty container if no notification is needed
//       return Container();
//     }
//   }

//   List<String> getActionableInsights() {
//     List<String> insights = [];

//     double uvIndex = weatherData['current']['uv'];
//     double precipitation = weatherData['current']['precip_mm'];
//     int cloudCover = weatherData['current']['cloud'];

//     // Additional actionable insights based on different conditions
//     // Customize these based on your specific criteria

//     // UV Index Insight
//     if (uvIndex > 0 && uvIndex <= 7) {
//       insights.add(
//           'Precautions: The UV index is moderate. Consider using sunscreen and wearing protective clothing for outdoor activities. '
//           'Protecting yourself from harmful UV rays is crucial for your health during prolonged sun exposure. '
//           'Crops Recommendation: Crops like tomatoes and peppers can be sensitive to excessive sunlight. Consider providing shade or using shade nets to protect them.');
//     }

// // Precipitation Insight
//     if (precipitation >= 0 && precipitation <= 5) {
//       insights.add(
//           'Precautions: Light precipitation is expected. Check soil moisture for your crops to ensure they receive adequate hydration. '
//           'Monitoring soil moisture helps optimize irrigation and supports healthy crop growth. '
//           'Crops Recommendation: Crops such as lettuce and spinach benefit from consistent moisture. Adjust irrigation schedules accordingly.');
//     }

// // Cloud Cover Insight
//     if (cloudCover > 30 && cloudCover <= 70) {
//       insights.add(
//           'Precautions: Moderate cloud cover is observed. Assess the potential impact on crop photosynthesis and growth. '
//           'While clouds can provide relief from excessive sunlight, prolonged periods of cloud cover may affect crop development. Monitor closely. '
//           'Crops Recommendation: Crops like wheat and barley are sensitive to changes in sunlight. Adjust nitrogen fertilization to compensate for reduced photosynthesis.');
//     }

//     return insights;
//   }

//   bool checkNotificationConditions() {
//     // Customize the conditions based on your criteria
//     double uvIndex = weatherData['current']['uv'];
//     double precipitation = weatherData['current']['precip_mm'];
//     int cloudCover = weatherData['current']['cloud'];

//     // Example: Show a notification if UV index is high (greater than 7)
//     // or if precipitation is above a certain threshold, or cloud cover is high
//     // or chance of rain is significant.
//     return uvIndex > 0 || precipitation > 0 || cloudCover > 0;
//   }

//   void show4HourForecastDialog(BuildContext context, List<dynamic> hourlyData) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('1-Hour Interval Forecast'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: hourlyData.map<Widget>((hourData) {
//                 return ListTile(
//                   title: Text('Time: ${hourData['time']}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Temperature: ${hourData['temp_c']}°C'),
//                       Text(
//                           'Weather Condition: ${hourData['condition']['text']}'),
//                       Text(
//                         'Chance of Rain: ${hourData['chance_of_rain']}%',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
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
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'location_search_delegate.dart';

class WeatherForecastPage extends StatefulWidget {
  @override
  _WeatherForecastPageState createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final String apiKey = '575eb43a29434f6bb7c44646233010';
  String location = ''; // Empty string as the default location
  Map<String, dynamic> weatherData = {};

  final String hiveBoxName = 'settings';

  // Hive box for storing weather data
  late Box<Map<String, dynamic>> weatherDataBox;

  Widget loadWeatherIcon(String iconUrl) {
    if (iconUrl != null && iconUrl.isNotEmpty) {
      return Image.network(
        'https:$iconUrl',
        width: 50,
        height: 50,
      );
    } else {
      return Image.asset(
        'assets/images/weather/day/113.png',
        width: 50,
        height: 50,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initHive();
    // Load default location from Hive and fetch weather data
    loadDefaultLocationAndFetchWeatherData();
  }

  late Box<Map<String, dynamic>> forecastDataBox;
  late Box<List<dynamic>> hourlyForecastDataBox;
  Future<void> initHive() async {
    WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // Open Hive box for weather data
    weatherDataBox = await Hive.openBox<Map<String, dynamic>>(
      'weatherDataBox',
    );

    /// Open Hive box for forecast data
    forecastDataBox = await Hive.openBox<Map<String, dynamic>>(
      'forecastDataBox',
    );
    // Open Hive box for hourly forecast data
    hourlyForecastDataBox = await Hive.openBox<List<dynamic>>(
      'hourlyForecastDataBox',
    );
  }

  Future<void> loadDefaultLocationAndFetchWeatherData() async {
    await initHive(); // Ensure Hive is initialized before usage
    // Check if the default location is already set in Hive
    final box = await Hive.openBox(hiveBoxName);
    final storedLocation = box.get('location', defaultValue: '');

    if (storedLocation.isNotEmpty) {
      // Default location is set, fetch weather data
      setState(() {
        location = 'Philippines, $storedLocation';
      });
      fetchWeatherData();
    } else {
      // Default location is not set, show the set default location page
      setDefaultLocation();
    }
  }

  Future<void> fetchWeatherData() async {
    final url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=Philippines,$location&days=3';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);

      // Save current weather data to Hive
      await weatherDataBox.put('weatherData', weatherData['current']);

      // Save entire forecast data to Hive
      await forecastDataBox.put('forecastData', weatherData['forecast']);

      // Save hourly forecast data to Hive for all days
      await hourlyForecastDataBox.put('hourlyForecastData', [
        for (var day in weatherData['forecast']['forecastday']) ...day['hour'],
      ]);

      // Print the stored data for confirmation
      final storedWeatherData = weatherDataBox.get('weatherData');
      final storedForecastData = forecastDataBox.get('forecastData');
      final storedHourlyForecastData =
          hourlyForecastDataBox.get('hourlyForecastData', defaultValue: []);

      print('Stored Weather Data: $storedWeatherData');
      print('Stored Forecast Data: $storedForecastData');
      print('Stored Hourly Forecast Data: $storedHourlyForecastData');

      setState(() {
        this.weatherData = weatherData;
      });
    }
  }

  // Function to build the hourly weather conditions
  List<Widget> buildHourlyWeatherConditions(List<dynamic> hourlyForecastList) {
    List<Widget> hourlyConditions = [];
    for (var hourData in hourlyForecastList) {
      hourlyConditions.add(
        ListTile(
          title: Text('Time: ${hourData['time']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Temperature: ${hourData['temp_c']}°C'),
              Text('Weather Condition: ${hourData['condition']['text']}'),
            ],
          ),
        ),
      );
    }
    return hourlyConditions;
  }

  List<Widget> buildWeatherConditions(List<dynamic> forecastList) {
    List<Widget> conditions = [];
    for (var forecast in forecastList) {
      conditions.add(
        GestureDetector(
          onTap: () {
            show4HourForecastDialog(context, forecast['hour']);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  'Date: ${forecast['date']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Max Temp: ${forecast['day']['maxtemp_c']}°C',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Min Temp: ${forecast['day']['mintemp_c']}°C',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Weather Condition: ', style: TextStyle(fontSize: 18)),
                    Text(
                      forecast['day']['condition']['text'],
                      style: TextStyle(fontSize: 14),
                    ),
                    loadWeatherIcon(forecast['day']['condition']['icon']),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return conditions;
  }

  Future<void> setLocationAndFetchWeatherData(String selectedLocation) async {
    await Hive.openBox(hiveBoxName).then((box) {
      box.put('location', selectedLocation);
      setState(() {
        location = 'Philippines, $selectedLocation';
      });
      fetchWeatherData();
    });
  }

  Future<void> fetchWeatherDataForLocation(Position position) async {
    final url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${position.latitude},${position.longitude}&days=3';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);

      // Save data to Hive
      await weatherDataBox.put('weatherData', weatherData);

      setState(() {
        this.weatherData = weatherData;
      });
    }
  }

  Future<void> getLocationAndFetchWeatherData() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle the case where the user denies location permission.
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      fetchWeatherDataForLocation(position);
    }
  }

  Future<void> setDefaultLocation() async {
    await Future.delayed(Duration.zero);

    // Check if the default location is already set
    if (location.isNotEmpty) {
      bool setDefaultAgain = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Set Default Location'),
          content: Text('Do you want to set a new default location?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // User wants to set a new default location
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // User doesn't want to set a new default location
              },
              child: Text('No'),
            ),
          ],
        ),
      );

      if (setDefaultAgain != null && setDefaultAgain) {
        // User wants to set a new default location
        final String? selectedLocation = await showSearch(
          context: context,
          delegate: LocationSearchDelegate(),
        );

        if (selectedLocation != null && selectedLocation.isNotEmpty) {
          await Hive.openBox(hiveBoxName).then((box) async {
            await box.put('location', selectedLocation);
          });

          setState(() {
            location = 'Philippines, $selectedLocation';
          });

          fetchWeatherData();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Default location set to $selectedLocation'),
            ),
          );
        }
      } else {
        // User doesn't want to set a new default location
        return;
      }
    } else {
      // Default location is not set, show the search page
      final String? selectedLocation = await showSearch(
        context: context,
        delegate: LocationSearchDelegate(),
      );

      if (selectedLocation != null && selectedLocation.isNotEmpty) {
        await Hive.openBox(hiveBoxName).then((box) async {
          await box.put('location', selectedLocation);
        });

        setState(() {
          location = 'Philippines, $selectedLocation';
        });

        fetchWeatherData();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Default location set to $selectedLocation'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (location.isEmpty) {
      // Show an empty state until the user sets their default location
      return Scaffold(
        appBar: AppBar(
          title: Text('Agriculture Weather Forecast'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.location_city),
              onPressed: setDefaultLocation,
            ),
          ],
        ),
        body: Center(
          child: Text(
            'Please set your default location',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    if (weatherData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Agriculture Weather Forecast'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: LocationSearchDelegate(),
                ).then((value) {
                  if (value != null) {
                    setLocationAndFetchWeatherData(value);
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: getLocationAndFetchWeatherData,
            ),
            IconButton(
              icon: Icon(Icons.location_city),
              onPressed: setDefaultLocation,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Current Weather'),
              Tab(text: 'Insights'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildCurrentWeatherTab(),
            buildNotificationTab(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentWeatherTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 4,
            shadowColor: Colors.green,
            child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Location: ${weatherData['location']['name']}, ${weatherData['location']['region']}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Local Time: ${weatherData['location']['localtime']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Last Updated: ${weatherData['current']['last_updated']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Temperature: ${weatherData['current']['temp_c']}°C',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text('Weather Condition: ',
                            style: TextStyle(fontSize: 18)),
                        Text(
                          weatherData['current']['condition']['text'],
                          style: TextStyle(fontSize: 18),
                        ),
                        loadWeatherIcon(
                            weatherData['current']['condition']['icon']),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Precipitation: ${weatherData['current']['precip_mm']} mm',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Wind Speed: ${weatherData['current']['wind_kph']} km/h',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Humidity: ${weatherData['current']['humidity']}%',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Cloud Cover: ${weatherData['current']['cloud']}%',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'UV Index: ${weatherData['current']['uv']}',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '3-Day Forecast',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: buildWeatherConditions(
                  weatherData['forecast']['forecastday']),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationTab() {
    // Check conditions for displaying a notification
    bool showNotification = checkNotificationConditions();

    if (showNotification) {
      // Get specific insights based on weather conditions
      List<Widget> insights = getActionableInsights();
      double uvIndex = weatherData['current']['uv'];
      double precipitation = weatherData['current']['precip_mm'];
      int cloudCover = weatherData['current']['cloud'];
      double temperature = weatherData['current']['temp_c'];
      double windSpeed = weatherData['current']['wind_kph'];
      int humidity = weatherData['current']['humidity'];

      return SingleChildScrollView(
        child: Card(
          elevation: 4,
          shadowColor: Colors.blue, // Customize the shadow color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100], // Use a light blue color
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🌦️ Current Weather',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text('UV Index: $uvIndex'),
                Text('Precipitation: $precipitation mm'),
                Text('Cloud Cover: $cloudCover%'),
                SizedBox(height: 10),
                Text(
                  'Temperature: $temperature °C',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Text('Weather Condition: ', style: TextStyle(fontSize: 18)),
                    Text(
                      weatherData['current']['condition']['text'],
                      style: TextStyle(fontSize: 18),
                    ),
                    loadWeatherIcon(
                        weatherData['current']['condition']['icon']),
                  ],
                ),
                SizedBox(height: 10),
                Text('Wind Speed: $windSpeed km/h',
                    style: TextStyle(fontSize: 18)),
                Text('Humidity: $humidity%', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                // Display actionable insights
                ...insights,
              ],
            ),
          ),
        ),
      );
    } else {
      // Return an empty container if no notification is needed
      return Container();
    }
  }

  List<Widget> getActionableInsights() {
    List<Widget> insights = [];

    double uvIndex = weatherData['current']['uv'];
    double precipitation = weatherData['current']['precip_mm'];
    int cloudCover = weatherData['current']['cloud'];
    double temperature = weatherData['current']['temp_c'];
    double windSpeed = weatherData['current']['wind_kph'];
    int humidity = weatherData['current']['humidity'];

    // Temperature Insight Levels
    if (temperature > 40) {
      insights.add(
        buildInsightCard(
          'Extreme high temperature. Take immediate measures to protect crops from heat stress. Consider providing additional shade and adjusting irrigation.',
          'Extreme High Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    } else if (temperature > 45) {
      insights.add(
        buildInsightCard(
          'Very high temperature. Ensure that crops are suitable for the current temperature. Provide shade or adjust planting times for temperature-sensitive crops.',
          'Very High Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    } else if (temperature > 35) {
      insights.add(
        buildInsightCard(
          'High temperature. Monitor crops for signs of heat stress. Consider providing shade for sensitive crops.',
          'High Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    } else if (temperature > 30) {
      insights.add(
        buildInsightCard(
          'Moderate to high temperature. Conditions are generally favorable for most crops.',
          'Moderate to High Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    } else if (temperature > 25) {
      insights.add(
        buildInsightCard(
          'Moderate temperature. Conditions are generally favorable for most crops.',
          'Moderate Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    } else {
      insights.add(
        buildInsightCard(
          'Low temperature. Protect cold-sensitive crops from frost. Consider adjusting planting times for temperature-sensitive crops.',
          'Low Temperature',
          'Temperature',
          '$temperature °C',
        ),
      );
    }

    // Humidity Insight Levels
    if (humidity > 90) {
      insights.add(
        buildInsightCard(
          'Very high humidity is observed. Evaluate the risk of fungal diseases and adjust crop management practices accordingly.',
          'Very High Humidity',
          'Humidity',
          '$humidity%',
        ),
      );
    } else if (humidity > 70) {
      insights.add(
        buildInsightCard(
          'Moderate to high humidity is observed. Monitor for potential fungal diseases and adjust irrigation practices if needed.',
          'Moderate Humidity',
          'Humidity',
          '$humidity%',
        ),
      );
    } else if (humidity > 50) {
      insights.add(
        buildInsightCard(
          'Moderate humidity is observed. Conditions are generally favorable, but monitor for any signs of stress.',
          'Moderate Humidity',
          'Humidity',
          '$humidity%',
        ),
      );
    } else if (humidity > 30) {
      insights.add(
        buildInsightCard(
          'Low to moderate humidity is observed. Consider adjusting irrigation practices if crops show signs of stress.',
          'Low to Moderate Humidity',
          'Humidity',
          '$humidity%',
        ),
      );
    } else {
      insights.add(
        buildInsightCard(
          'Low humidity is observed. Monitor for signs of drought stress. Adjust irrigation practices accordingly.',
          'Low Humidity',
          'Humidity',
          '$humidity%',
        ),
      );
    }

    /// Wind Speed Insight Levels
    if (windSpeed > 40) {
      insights.add(
        buildInsightCard(
          'Very high wind speed is expected. Take immediate measures to secure crops against wind damage. Consider harvesting if necessary.',
          'Very High Wind Speed',
          'Wind Speed',
          '$windSpeed km/h',
        ),
      );
    } else if (windSpeed > 30) {
      insights.add(
        buildInsightCard(
          'High wind speed is expected. Protect crops from strong winds with support structures. Adjust planting patterns to minimize wind exposure for vulnerable crops.',
          'High Wind Speed',
          'Wind Speed',
          '$windSpeed km/h',
        ),
      );
    } else if (windSpeed > 20) {
      insights.add(
        buildInsightCard(
          'Moderate to high wind speed is expected. Secure loose items, and consider additional support for crops vulnerable to wind damage.',
          'Moderate to High Wind Speed',
          'Wind Speed',
          '$windSpeed km/h',
        ),
      );
    } else if (windSpeed > 10) {
      insights.add(
        buildInsightCard(
          'Moderate wind speed is expected. Conditions are generally favorable for most crops.',
          'Moderate Wind Speed',
          'Wind Speed',
          '$windSpeed km/h',
        ),
      );
    } else {
      insights.add(
        buildInsightCard(
          'Low wind speed is expected. Monitor for potential issues related to still air, such as increased risk of pests and diseases.',
          'Low Wind Speed',
          'Wind Speed',
          '$windSpeed km/h',
        ),
      );
    }

// Cloud Cover Insight Levels
    if (cloudCover > 80) {
      insights.add(
        buildInsightCard(
          'Heavy cloud cover is observed. Adjust fertilization and irrigation for crops that rely on sunlight for growth. Monitor for signs of stretching.',
          'Heavy Cloud Cover',
          'Cloud Cover',
          '$cloudCover%',
        ),
      );
    } else if (cloudCover > 60) {
      insights.add(
        buildInsightCard(
          'Moderate to heavy cloud cover is observed. Monitor light levels for sunlight-sensitive crops and adjust farming practices if necessary.',
          'Moderate to Heavy Cloud Cover',
          'Cloud Cover',
          '$cloudCover%',
        ),
      );
    } else if (cloudCover > 40) {
      insights.add(
        buildInsightCard(
          'Moderate cloud cover is observed. Monitor crops sensitive to sunlight. Adjust fertilization for crops that rely on sunlight for growth.',
          'Moderate Cloud Cover',
          'Cloud Cover',
          '$cloudCover%',
        ),
      );
    } else if (cloudCover > 20) {
      insights.add(
        buildInsightCard(
          'Light to moderate cloud cover is observed. Conditions are generally favorable for most crops.',
          'Light to Moderate Cloud Cover',
          'Cloud Cover',
          '$cloudCover%',
        ),
      );
    } else {
      insights.add(
        buildInsightCard(
          'Clear skies. Conditions are generally favorable for most crops that require sunlight for growth.',
          'Clear Skies',
          'Cloud Cover',
          '$cloudCover%',
        ),
      );
    }

// Precipitation Insight Levels
    if (precipitation > 30) {
      insights.add(
        buildInsightCard(
          'Heavy precipitation is occurring. Implement measures to prevent waterlogging, and assess the risk of soil erosion.',
          'Heavy Precipitation',
          'Precipitation',
          '$precipitation mm',
        ),
      );
    } else if (precipitation > 10) {
      insights.add(
        buildInsightCard(
          'Moderate to heavy precipitation is occurring. Monitor soil moisture and adjust irrigation practices as needed.',
          'Moderate to Heavy Precipitation',
          'Precipitation',
          '$precipitation mm',
        ),
      );
    } else if (precipitation > 5) {
      insights.add(
        buildInsightCard(
          'Moderate precipitation is occurring. Monitor soil moisture and adjust irrigation practices as needed.',
          'Moderate Precipitation',
          'Precipitation',
          '$precipitation mm',
        ),
      );
    } else if (precipitation > 2) {
      insights.add(
        buildInsightCard(
          'Light to moderate precipitation is occurring. Monitor soil moisture and adjust irrigation practices as needed.',
          'Light to Moderate Precipitation',
          'Precipitation',
          '$precipitation mm',
        ),
      );
    } else if (precipitation > 0) {
      insights.add(
        buildInsightCard(
          'Light precipitation is occurring. Monitor soil moisture and consider adjusting irrigation practices if needed.',
          'Light Precipitation',
          'Precipitation',
          '$precipitation mm',
        ),
      );
    }

    // UV Index Insights
    if (uvIndex >= 11) {
      insights.add(
        buildInsightCard(
          'Extreme UV Index. Take extra precautions. Limit outdoor activities and provide maximum protection for crops and farmworkers.',
          'Extreme UV Index',
          'UV Index',
          '$uvIndex',
        ),
      );
    } else if (uvIndex >= 8) {
      insights.add(
        buildInsightCard(
          'Very High UV Index. High risk of harm. Take additional measures to protect crops and farmworkers during high UV conditions.',
          'Very High UV Index',
          'UV Index',
          '$uvIndex',
        ),
      );
    } else if (uvIndex >= 6) {
      insights.add(
        buildInsightCard(
          'High UV Index. Protect crops and farmworkers during high UV conditions. Consider shading for UV-sensitive crops.',
          'High UV Index',
          'UV Index',
          '$uvIndex',
        ),
      );
    }

    // You can add more insights based on other conditions...

    return insights;
  }

  Widget buildInsightCard(String insight, String condition,
      String conditionLabel, String conditionValue) {
    return Card(
      elevation: 4,
      shadowColor: Colors.green, // Customize the shadow color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(top: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100], // Use a light green color
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🌦️ Weather Insights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Condition: $condition',
              style: TextStyle(fontSize: 18),
            ),
            Text('$conditionLabel: $conditionValue',
                style: TextStyle(fontSize: 18)),
            Text(insight, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  bool checkNotificationConditions() {
    // Triggering conditions for showing notification
    double uvIndex = weatherData['current']['uv'];
    double precipitation = weatherData['current']['precip_mm'];
    int cloudCover = weatherData['current']['cloud'];
    double temperature = weatherData['current']['temp_c'];
    double windSpeed = weatherData['current']['wind_kph'];
    int humidity = weatherData['current']['humidity'];
    double pressure = weatherData['current']['pressure_mb'];
    double gustSpeed = weatherData['current']['gust_kph'];
    double visibility = weatherData['current']['vis_km'];

    return uvIndex > 7 ||
        precipitation > 0 ||
        cloudCover > 50 ||
        temperature > 25 ||
        windSpeed > 20 ||
        humidity > 80 ||
        pressure < 1000 ||
        gustSpeed > 30 ||
        visibility < 5;
  }

  void show4HourForecastDialog(BuildContext context, List<dynamic> hourlyData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('1-Hour Interval Forecast'),
          content: SingleChildScrollView(
            child: Column(
              children: hourlyData.map<Widget>((hourData) {
                return ListTile(
                  title: Text('Time: ${hourData['time']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperature: ${hourData['temp_c']}°C'),
                      Text(
                          'Weather Condition: ${hourData['condition']['text']}'),
                      Text(
                        'Chance of Rain: ${hourData['chance_of_rain']}%',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
}
