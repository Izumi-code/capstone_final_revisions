import 'package:capstone_project/pages/agritech_page.dart';
import 'package:capstone_project/pages/auth_page.dart';
import 'package:capstone_project/pages/crop_calendar_page.dart';
import 'package:capstone_project/pages/community.dart';
import 'package:capstone_project/pages/learn_page.dart';
import 'package:capstone_project/pages/pest_live_detect.dart';
import 'package:capstone_project/pages/market_price_page.dart';
import 'package:capstone_project/pages/pest_detection_page.dart';
import 'package:capstone_project/pages/planting_logs.dart';
import 'package:capstone_project/pages/rice_detection_page.dart';
import 'package:capstone_project/pages/settings_page.dart';
import 'package:capstone_project/pages/true_home_page.dart';
import 'package:capstone_project/pages/weather_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PagesNavigation extends StatefulWidget {
  PagesNavigation({super.key});

  @override
  State<PagesNavigation> createState() => _PagesNavigationState();
}

class _PagesNavigationState extends State<PagesNavigation> {
  final user = FirebaseAuth.instance.currentUser!;
  final PageController _pageController = PageController();
  var selectedIndex = 0;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<Widget> _pages = [
    // Import and add your pages here
    TrueHomePage(),
    RiceDetectionPage(),
    // LearnPage(),
    // AgritechInformation(),
    // CropCalendar(),
    WeatherMenu(),
    // PlantingLogFeature(),
    HomePage(),
    SettingsPage(),
    // Add other pages here
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/newimage/agrosense.png',
            width: 30,
            height: 30,
          ),
          onPressed: () {
            // Add functionality when the custom icon is pressed
          },
        ),
        title: Text('AgroSense'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: _pages,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                color: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: GNav(
                    backgroundColor: Colors.black,
                    haptic: false,
                    color: Colors.white,
                    activeColor: Colors.green,
                    tabBackgroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.all(16),
                    gap: 4,
                    selectedIndex: selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        selectedIndex = index;
                        _pageController.jumpToPage(index);
                      });
                    },
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: "Home Page",
                      ),
                      GButton(
                        icon: Icons.document_scanner_sharp,
                        text: "Detection",
                      ),
                      GButton(
                        icon: Icons.cloud,
                        text: "Weather",
                      ),
                      GButton(
                        icon: Icons.people_alt_outlined,
                        text: "Community",
                      ),
                      GButton(
                        icon: Icons.settings,
                        text: "Settings",
                      )
                    ],
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

// class PagesNavigation extends StatefulWidget {
//   PagesNavigation({super.key});

//   @override
//   State<PagesNavigation> createState() => _PagesNavigationState();
// }

// class _PagesNavigationState extends State<PagesNavigation> {
//   final user = FirebaseAuth.instance.currentUser!;
//   final PageController _pageController = PageController();
//   var selectedIndex = 0;

//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   final List<Widget> _pages = [
//     // Import and add your pages here
//     HomePage(),
//     RiceDetectionPage(),
//     LearnPage(),
//     AgritechInformation(),
//     CropCalendar(),
//     WeatherMenu(),
//     // WeatherForecastPage(),
//     // MarketPricePage(),
//     PlantingLogFeature(),
//     SettingsPage(),
//     // Add other pages here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[600],
//         title: Text('AgroSense'),
//         actions: [
//           // IconButton(
//           //   onPressed: signUserOut,
//           //   icon: Icon(Icons.logout),
//           //   color: Colors.white,
//           // ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 children: _pages,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color.fromARGB(135, 138, 138, 25),
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.white,
//         currentIndex: selectedIndex,
//         onTap: (index) {
//           setState(() {
//             selectedIndex = index;
//             _pageController.jumpToPage(index);
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/community.png',
//                 width: 40, height: 40),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/object.png',
//                 width: 40, height: 40),
//             label: 'AI Detector',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/open-book.png',
//                 width: 40, height: 40),
//             label: 'Crops Practices',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/news.png',
//                 width: 40, height: 40),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/calendar.png',
//                 width: 40, height: 40),
//             label: 'Crop Calendar',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/rain.png',
//                 width: 40, height: 40),
//             label: 'Weather Forecast',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/log.png',
//                 width: 40, height: 40),
//             label: 'Crop Entry',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset('assets/images/newimage/technology.png',
//                 width: 40, height: 40),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }
