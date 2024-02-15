// import 'package:capstone_project/pages/air_quality_page.dart';
// import 'package:capstone_project/pages/weather_history_page.dart';
// import 'package:capstone_project/pages/weather_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class WeatherMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: GridView.count(
//           crossAxisCount: 2, // 2 items per row
//           childAspectRatio: 1.0, // Square tiles
//           padding: EdgeInsets.all(16),
//           children: <Widget>[
//             OptionBox(
//               title: 'Weather Forecast',
//               icon: Icons.cloud,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => WeatherForecastPage()),
//                 );
//               },
//             ),
//             OptionBox(
//               title: 'Weather History',
//               icon: Icons.history,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => HistoricalWeatherPage()),
//                 );
//               },
//             ),
//             OptionBox(
//               title: 'Air Quality',
//               icon: Icons.history,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AirQualityPage()),
//                 );
//               },
//             ),
//             // Add more options here
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OptionBox extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Function onPressed;

//   OptionBox({
//     required this.title,
//     required this.icon,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onPressed();
//       },
//       child: Card(
//         elevation: 4,
//         shadowColor: Colors.green,
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(icon, size: 48, color: Colors.green),
//               SizedBox(height: 16),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:capstone_project/pages/air_quality_page.dart';
// import 'package:capstone_project/pages/weather_history_page.dart';
// import 'package:capstone_project/pages/weather_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class WeatherMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Weather App'),
//       //   backgroundColor: Colors.green,
//       // ),
//       body: Center(
//         child: GridView.count(
//           crossAxisCount: 2, // 2 items per row
//           childAspectRatio: 1.0, // Square tiles
//           padding: EdgeInsets.all(16),
//           children: <Widget>[
//             OptionBox(
//               title: 'Weather Forecast',
//               icon: Icons.cloud,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => WeatherForecastPage()),
//                 );
//               },
//             ),
//             OptionBox(
//               title: 'Weather History',
//               icon: Icons.history,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => HistoricalWeatherPage()),
//                 );
//               },
//             ),
//             OptionBox(
//               title: 'Air Quality',
//               icon: Icons.history,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AirQualityPage()),
//                 );
//               },
//             ),
//             // OptionBox(
//             //   title: 'Weather Motification',
//             //   icon: Icons.history,
//             //   onPressed: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (context) => WeatherNotificationPage()),
//             //     );
//             //   },
//             // ),
//             // Add more options here
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OptionBox extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Function onPressed;

//   OptionBox({
//     required this.title,
//     required this.icon,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onPressed();
//       },
//       child: Card(
//         elevation: 4,
//         shadowColor: Colors.green,
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(icon, size: 48, color: Colors.green),
//               SizedBox(height: 16),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/air_quality_page.dart';
import 'package:capstone_project/pages/weather_history_page.dart';
import 'package:capstone_project/pages/weather_page.dart';
import 'package:flutter/material.dart';

class WeatherMenu extends StatelessWidget {
  static const Duration _animationDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            padding: EdgeInsets.all(16),
            children: [
              _buildHeroCard(
                context,
                'Weather Forecast',
                Icons.cloud,
                WeatherForecastPage(),
                Colors.blue.shade200,
              ),
              _buildHeroCard(
                context,
                'Weather History',
                Icons.history,
                HistoricalWeatherPage(),
                Colors.green.shade200,
              ),
              _buildHeroCard(
                context,
                'Air Quality',
                Icons.history,
                AirQualityPage(),
                Colors.blue.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    String label,
    IconData icon,
    Widget destinationScreen,
    Color cardColor,
  ) {
    return Hero(
      tag: label,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            _navigateWithHeroAnimation(context, destinationScreen);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cardColor.withOpacity(0.8), cardColor.withOpacity(1)],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Icon(
                    icon,
                    size: 48.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateWithHeroAnimation(
    BuildContext context,
    Widget destinationScreen,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            destinationScreen,
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: _animationDuration,
      ),
    );
  }
}
