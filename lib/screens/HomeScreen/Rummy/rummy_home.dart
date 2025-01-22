import 'dart:async';
import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity package

class RummyHome extends StatefulWidget {
  @override
  _RummyHomeScreenState createState() => _RummyHomeScreenState();
}

class _RummyHomeScreenState extends State<RummyHome> {
  int _selectedSubTab = 0;
  int _selectedPlayerCountTab = 0; // New variable for selecting player count
  int _currentBannerIndex = 0;
  bool _isLoading = false; // Loading state
  bool _isConnected = true; // Connectivity check
  final List<String> banners = [
    ImageAssets.rummyBanner,
    ImageAssets.rummyBanner,
    ImageAssets.rummyBanner,
  ];

  final List<String> subTabs = [
    Constants.points,
    Constants.deals,
    Constants.pool
  ];
  final List<String> subTabImages = [
    ImageAssets.points, // Image for Points sub-tab
    ImageAssets.deals, // Image for Deals sub-tab
    ImageAssets.pool, // Image for Pool sub-tab
  ];
  final List<String> playerCountTabs = ['2', '6']; // Player count tabs
  late Timer _autoScrollTimer; // Add a timer for auto-scrolling

  final List<Map<String, dynamic>> tabData = [
    {
      'title': 'Points 1',
      'price': '5',
      'slots': '1',
      'onlinePlayers': 5,
      'pointValue': 0.50,
      'subTab': 'Points',
      'playersCount': '2',
    },
    {
      'title': 'Points 1',
      'price': '5',
      'slots': '1',
      'onlinePlayers': 5,
      'pointValue': 0.250,
      'subTab': 'Points',
      'playersCount': '2',
    },
    {
      'title': 'Points 1',
      'price': '5',
      'slots': '4',
      'onlinePlayers': 5,
      'pointValue': 50,
      'subTab': 'Points',
      'playersCount': '6',
    },
    {
      'title': 'Points 1',
      'price': '5',
      'slots': '1',
      'onlinePlayers': 5,
      'pointValue': 0.10,
      'subTab': 'Points',
      'playersCount': '2',
    },
    {
      'title': 'Points 1',
      'price': '5',
      'slots': '1',
      'onlinePlayers': 5,
      'pointValue': 0.40,
      'subTab': 'Points',
      'playersCount': '6',
    },
    {
      'title': 'Deals 1',
      'price': '10',
      'slots': '2',
      'onlinePlayers': 10,
      'pointValue': 100,
      'subTab': 'Deals',
      'playersCount': '6',
    },
    {
      'title': 'Pool 1',
      'price': '20',
      'slots': '3',
      'onlinePlayers': 15,
      'pointValue': 150,
      'subTab': 'Pool',
      'playersCount': '6',
    },
  ];

  Timer? _bannerTimer;
  PageController _pageController = PageController(viewportFraction: 0.93); // PageController for controlling the PageView

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _startAutoScroll();
    // _bannerTimer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   setState(() {
    //     _currentBannerIndex = (_currentBannerIndex + 1) % banners.length;
    //     _pageController.animateToPage(
    //       _currentBannerIndex,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.easeInOut,
    //     );
    //   });
    // });
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // final nextPage = (_pageController.page!.toInt() + 1) % matchImages.length;
        final nextPage = _pageController.page!.toInt() + 1;

        // Scroll to the next page
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentBannerIndex = nextPage; // Update the indicator
        });
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _autoScrollTimer.cancel();

    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isConnected
          ? Column(
              children: [
                // Banner Section with Scroll Animation
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.008,
                      horizontal: screenWidth * 0.0),
                  height: screenHeight * 0.15,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentBannerIndex = index % banners.length; // Update the indicator
                      });
                    },
                    itemBuilder: (context, index) {
                      final actualIndex = index % banners.length; // Loop logic
                      return Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.02, left: screenWidth * 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            banners[actualIndex],
                            width: screenWidth,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Image Indicators (with Animation)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: _currentBannerIndex == index ? 6 : 6,
                        decoration: BoxDecoration(
                          color: _currentBannerIndex == index
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ),

                // Sub-tab Section
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.008,
                      horizontal: screenWidth * 0.035),
                  decoration: BoxDecoration(
                    color: AppColors.bgContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      subTabs.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSubTab = index;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.055,
                              decoration: BoxDecoration(
                                color: _selectedSubTab == index
                                    ? AppColors.brand
                                    : AppColors.tabBG,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Add image icon with text for each sub-tab
                                  Image.asset(
                                    subTabImages[
                                        index], // Dynamic image based on the selected tab
                                    // color: _selectedSubTab == index ? Colors.green : Colors.black,
                                    width: 31, // Adjust size as needed
                                    height: 26, // Adjust size as needed
                                  ),
                                  SizedBox(
                                      width: screenWidth *
                                          0.008), // Space between icon and text
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Border text (larger, offset, and darker color)
                                      Text(
                                        subTabs[index],
                                        style: FTextStyle.rummyTabs,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Actual text
                                      Text(
                                        subTabs[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: FTextStyle.rummyTabs.copyWith(
                                          color: _selectedSubTab == index
                                              ? Colors.white
                                              : AppColors
                                                  .tabNotSelectedText, // Change color dynamically
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Player Count Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    playerCountTabs.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPlayerCountTab = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedPlayerCountTab == index
                              ? AppColors.brand
                              : Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors
                                .playerTabBorder, // Set the border color to #27245D66
                            width:
                                1, // You can adjust the width of the border as needed
                          ),
                        ),
                        margin: EdgeInsets.only(
                            top: screenHeight * 0.004,
                            left: screenWidth * 0.035,
                            bottom: screenHeight * 0.004),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.045,
                            vertical: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Align to the left
                          children: [
                            // Use Image.asset instead of Icon
                            Image.asset(
                              ImageAssets.user,
                              width: 16, // Adjust the size as needed
                              height: 16, // Adjust the size as needed
                              color: _selectedPlayerCountTab == index
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                            SizedBox(
                                width: screenWidth *
                                    0.008), // Space between image and text
                            Text('${playerCountTabs[index]}P',
                                overflow: TextOverflow.ellipsis,
                                style: FTextStyle.players.copyWith(
                                  color: _selectedPlayerCountTab == index
                                      ? Colors.white
                                      : AppColors.primary,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Data List
                Expanded(
                  child: ListView.builder(
                    itemCount: tabData
                        .where((data) =>
                            data['subTab'] == subTabs[_selectedSubTab] &&
                            data['playersCount'] ==
                                playerCountTabs[_selectedPlayerCountTab])
                        .length,
                    itemBuilder: (context, index) {
                      final item = tabData
                          .where((data) =>
                              data['subTab'] == subTabs[_selectedSubTab] &&
                              data['playersCount'] ==
                                  playerCountTabs[_selectedPlayerCountTab])
                          .toList()[index];

                      final title = item['title'] ?? 'No Title';
                      final price = int.tryParse(item['price'].toString()) ?? 0;
                      final slots = int.tryParse(item['slots'].toString()) ?? 0;
                      final onlinePlayers = item['onlinePlayers'] ?? 0;
                      final pointValue = item['pointValue'] ?? 0;
                      final playersCount =
                          int.tryParse(item['playersCount'].toString()) ?? 0;

                      return GestureDetector(
                        onTap: () {
                          // Navigate or perform action when the card is clicked
                          print(
                              'Clicked on $title'); // Replace with desired action
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.004,
                              horizontal: screenWidth * 0.035),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: AppColors.containerBorder),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(
                                    0.2), // Use AppColors.shadow for the shadow color
                                offset: Offset(0, 1), // Shadow offset (y = 1)
                                blurRadius: 3, // Blur radius for softness
                              ),
                            ],
                          ),
                          child: ListTile(
                            // contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.002, horizontal: 15),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Column (Player Count, Online Players, Slots)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Player Count with Icon
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors
                                                      .playerTabBorder),
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: AppColors.playerTabBorder
                                                  .withOpacity(0.1)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.008,
                                              horizontal: screenWidth * 0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                ImageAssets.user,
                                                width: 14,
                                                height: 14,
                                                color: AppColors
                                                    .primary, // Icon color
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.008),
                                              Text(
                                                '${playersCount}P',
                                                overflow: TextOverflow.ellipsis,
                                                style: FTextStyle.players
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text(
                                          title,
                                          style: FTextStyle.heading,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.004),

                                    // Online Players
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          ImageAssets.statusOnline,
                                          width: 10,
                                          height: 10,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          '${onlinePlayers} ${Constants.online}',
                                          overflow: TextOverflow.ellipsis,
                                          style: FTextStyle.playersOnline,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.004),
                                    // Slots (with color change based on the remaining slots)
                                    Text('${slots} ${Constants.slotsLeft}',
                                        overflow: TextOverflow.ellipsis,
                                        style: FTextStyle.slotsLeft),
                                    SizedBox(height: screenHeight * 0.004),
                                    Row(
                                      children: [
                                        for (int i = 0; i < playersCount; i++)
                                          Container(
                                            width: screenWidth * 0.07,
                                            height: 6,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: i < slots
                                                  ? AppColors.brand
                                                  : AppColors.primary.withOpacity(
                                                      0.15), // Green for available slots
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Right Column (Price and Points Value)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Price with Brand Background and Elevation
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008,horizontal: screenWidth * 0.06),
                                      decoration: BoxDecoration(
                                        color: AppColors.brand, // Brand color
                                        borderRadius: BorderRadius.circular(19),
                                        border: Border.all(
                                            color: Colors.white, width: 1),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.currency_rupee, // Rupee icon
                                            size: 16,
                                            color: AppColors.bgContainer,
                                          ),
                                          SizedBox(width: screenWidth * 0.00),
                                          Text('$price',
                                              overflow: TextOverflow.ellipsis,
                                              style: FTextStyle.amountRummy),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.016),

                                    // Points Value
                                    Row(
                                      children: [
                                        Text(
                                          Constants.pointValue,
                                          overflow: TextOverflow.ellipsis,
                                          style: FTextStyle.pointsVal,
                                        ),
                                        SizedBox(
                                            width:
                                                2), // Add spacing between the text and the icon
                                        Icon(
                                          Icons.currency_rupee, // Rupee icon
                                          size: 16, // Adjust size as needed
                                        ),
                                        SizedBox(
                                            width:
                                                0), // Add spacing between the icon and the value
                                        Text(
                                          '$pointValue',
                                          overflow: TextOverflow.ellipsis,
                                          style: FTextStyle.points,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          : Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      Constants.noInternet,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: FTextStyle.timeRemaining,
                    ),
            ),
    );
  }
}
