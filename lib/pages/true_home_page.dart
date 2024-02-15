// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'OpenSans', // Specify your font family here
//       ),
//       home: TrueHomePage(),
//     );
//   }
// }

// class TrueHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Add functionality for the button
//                 // e.g., navigate to crops practices page
//               },
//               child: Text('Crops Practices'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add functionality for the button
//                 // e.g., navigate to crop management page
//               },
//               child: Text('Crop Management'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add functionality for the button
//                 // e.g., navigate to planting log page
//               },
//               child: Text('Planting Log'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Add functionality for the button
//                 // e.g., navigate to agriculture news page
//               },
//               child: Text('Agriculture News'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:capstone_project/pages/agritech_page.dart';
// import 'package:capstone_project/pages/crop_calendar_page.dart';
// import 'package:capstone_project/pages/learn_page.dart';
// import 'package:capstone_project/pages/plant_entry.dart';
// import 'package:capstone_project/pages/planting_logs.dart';
// import 'package:flutter/material.dart';

// class TrueHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           children: [
//             _buildElevatedButton(
//               context,
//               'Crops Practices',
//               Icons.agriculture,
//               () {
//                 _navigateToCropsPractices(context);
//               },
//             ),
//             _buildElevatedButton(
//               context,
//               'Crop Management',
//               Icons.dashboard,
//               () {
//                 _navigateToCropManagement(context);
//               },
//             ),
//             _buildElevatedButton(
//               context,
//               'Planting Log',
//               Icons.spa,
//               () {
//                 _navigateToPlantingLog(context);
//               },
//             ),
//             _buildElevatedButton(
//               context,
//               'Agriculture News',
//               Icons.article,
//               () {
//                 _navigateToAgricultureNews(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildElevatedButton(
//     BuildContext context,
//     String label,
//     IconData icon,
//     VoidCallback onPressed,
//   ) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         primary: Colors.blue, // Button color
//         onPrimary: Colors.white, // Text color
//         padding: EdgeInsets.all(16.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 48.0,
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToCropsPractices(BuildContext context) {
//     // Add navigation logic to the Crops Practices page
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => LearnPage()));
//   }

//   void _navigateToCropManagement(BuildContext context) {
//     // Add navigation logic to the Crop Management page
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => CropCalendar()));
//   }

//   void _navigateToPlantingLog(BuildContext context) {
//     // Add navigation logic to the Planting Log page
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => PlantingLogFeature()));
//   }

//   void _navigateToAgricultureNews(BuildContext context) {
//     // Add navigation logic to the Agriculture News page
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => AgritechInformation()));
//   }
// }

// import 'package:capstone_project/pages/agritech_page.dart';
// import 'package:capstone_project/pages/crop_calendar_page.dart';
// import 'package:capstone_project/pages/learn_page.dart';
// import 'package:capstone_project/pages/plant_entry.dart';
// import 'package:capstone_project/pages/planting_logs.dart';
// import 'package:flutter/material.dart';

// class TrueHomePage extends StatelessWidget {
//   // Define a custom animation duration
//   static const Duration _animationDuration = Duration(seconds: 1);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           children: [
//             _buildHeroCard(
//               context,
//               'Crops Practices',
//               Icons.agriculture,
//               LearnPage(),
//             ),
//             _buildHeroCard(
//               context,
//               'Crop Management',
//               Icons.dashboard,
//               CropCalendar(),
//             ),
//             _buildHeroCard(
//               context,
//               'Planting Log',
//               Icons.spa,
//               PlantingLogFeature(),
//             ),
//             _buildHeroCard(
//               context,
//               'Agriculture News',
//               Icons.article,
//               AgritechInformation(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeroCard(
//     BuildContext context,
//     String label,
//     IconData icon,
//     Widget destinationScreen,
//   ) {
//     return Hero(
//       tag: label, // Unique tag for each Hero widget
//       child: ElevatedButton(
//         onPressed: () {
//           _navigateWithHeroAnimation(context, destinationScreen);
//         },
//         style: ElevatedButton.styleFrom(
//           primary: Colors.blue, // Button color
//           onPrimary: Colors.white, // Text color
//           padding: EdgeInsets.all(16.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 48.0,
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateWithHeroAnimation(
//     BuildContext context,
//     Widget destinationScreen,
//   ) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             destinationScreen,
//         transitionsBuilder: (
//           context,
//           animation,
//           secondaryAnimation,
//           child,
//         ) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOut;

//           var tween = Tween(begin: begin, end: end).chain(
//             CurveTween(curve: curve),
//           );

//           var offsetAnimation = animation.drive(tween);
//           return SlideTransition(position: offsetAnimation, child: child);
//         },
//         // Specify the same animation duration for the route
//         transitionDuration: _animationDuration,
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/agritech_page.dart';
import 'package:capstone_project/pages/crop_calendar_page.dart';
import 'package:capstone_project/pages/learn_page.dart';
import 'package:capstone_project/pages/plant_entry.dart';
import 'package:capstone_project/pages/planting_logs.dart';
import 'package:flutter/material.dart';

class TrueHomePage extends StatelessWidget {
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
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildHeroCard(
              context,
              'Crops Practices',
              Icons.agriculture,
              LearnPage(),
            ),
            _buildHeroCard(
              context,
              'Crop Management',
              Icons.dashboard,
              CropCalendar(),
            ),
            _buildHeroCard(
              context,
              'Planting Log',
              Icons.spa,
              PlantingLogFeature(),
            ),
            _buildHeroCard(
              context,
              'Agriculture News',
              Icons.article,
              AgritechInformation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    String label,
    IconData icon,
    Widget destinationScreen,
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
                colors: [Colors.blue, Colors.green],
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
                    fontFamily: 'YourCustomFont',
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
