//
// import 'package:flutter/material.dart';
//
// class CommonTabBar extends StatefulWidget {
//   const CommonTabBar({Key? key}) : super(key: key);
//
//   @override
//   _CommonTabBarState createState() => _CommonTabBarState();
// }
//
// class _CommonTabBarState extends State<CommonTabBar> {
//   int _currentIndex = 0; // Tracks the selected tab index
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   //
//   // // Sample screens (replace these with actual widgets)
//   // final List<Widget> _screens = [
//   //   SearchScreen(),
//   //   SearchScreen(),
//   //   SearchScreen(),
//   //   SearchScreen(),
//   // ];
//
//   // Tab titles and icons
//   final List<String> _tabTitles = [
//     'Home',
//     'Appointment',
//     'Events',
//     'Marketplace'
//   ];
//   final List<String> _tabIcons = [
//     'assets/images/tabbar_home.png',
//     'assets/images/tabbar_appoinment.png',
//     'assets/images/tabbar_events.png',
//     'assets/images/tabbar_marketplace.png',
//   ];
//   final Color _selectedColor = Color(0xFF2A73E0);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isTablet = screenWidth > 600; // Determines if the device is a tablet
//
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Column(
//         children: [
//           // Top App Bar Section
//           Container(
//             height: isTablet ? 120 : 95,
//             decoration: BoxDecoration(color: Colors.blueAccent
//             ),
//
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Row(
//                     children: [
//                       // Menu Icon
//                       IconButton(
//                         icon: Image.asset(
//                           'assets/images/menu-02.png',
//                           width: isTablet ? 40 : 24,
//                           height: isTablet ? 40 : 24,
//                         ),
//                         onPressed: () {
//                           _scaffoldKey.currentState?.openDrawer();
//                         },
//                       ),
//                       SizedBox(width: isTablet ? 20 : 10),
//
//                       // App Logo
//                       Image.asset(
//                         'assets/images/Group mailto:1261154271@2x.png',
//                         width: isTablet ? 80 : 40,
//                         height: isTablet ? 80 : 40,
//                       ),
//                       Spacer(),
//
//                       // Notification Icon
//                       GestureDetector(
//                         onTap: () {
//                           // Add Notification Navigation
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 16.0),
//                           child: Image.asset(
//                             'assets/images/bell-01.png',
//                             width: isTablet ? 40 : 24,
//                             height: isTablet ? 40 : 24,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       //
//       //     // Screen Content Area
//       //     Expanded(
//       //       child: _screens.isNotEmpty
//       //           ? _screens[_currentIndex]
//       //           : Center(
//       //         child: CircularProgressIndicator(
//       //           strokeWidth: isTablet ? 3 : 1.5,
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//       // Bottom Navigation Bar
//       // Bottom Navigation Bar
// //      bottomNavigationBar: Container(
// //         margin: EdgeInsets.only(
// //           bottom: MediaQuery.of(context).size.height * 0.02, // Dynamic bottom margin
// //           left: MediaQuery.of(context).size.width * 0.05,   // Dynamic side margin
// //           right: MediaQuery.of(context).size.width * 0.05,
// //         ),
// //         decoration: BoxDecoration(
// //           color: Colors.white, // Background color of the BottomNavigationBar
// //           borderRadius: BorderRadius.circular(20), // Rounded corners
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.2), // Shadow color
// //               spreadRadius: 2,
// //               blurRadius: 5,
// //               offset: Offset(0, -1), // Slight upward shadow
// //             ),
// //           ],
// //         ),
// //         child: BottomNavigationBar(
// //           backgroundColor: Colors.transparent, // Transparent for container styling
// //           currentIndex: _currentIndex,
// //           onTap: (index) {
// //             setState(() {
// //               _currentIndex = index; // Update the selected index
// //             });
// //           },
// //           selectedItemColor: _selectedColor,
// //           unselectedItemColor: Colors.grey,
// //           items: List.generate(_tabTitles.length, (index) {
// //             return BottomNavigationBarItem(
// //               icon: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Image.asset(
// //                   _tabIcons[index],
// //                   width: isTablet ? 36 : 24,
// //                   height: isTablet ? 36 : 24,
// //                   color: _currentIndex == index ? _selectedColor : Colors.grey,
// //                 ),
// //               ),
// //               label: _tabTitles[index],
// //             );
// //           }),
// //         ),
// //       ),
// //
// //     );
// //   }
// // }
