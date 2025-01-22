import 'package:fantacy_game/Utils/constant.dart';
import 'package:fantacy_game/screens/Home%20Flow/select_contestent.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Utils/ImageAssets.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../Utils/shared_preference.dart';
import '../../../widgets/match_utils.dart';

class Cricket extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Cricket> {
  bool isLoading = true;
  bool isConnected = true; // to track the internet connection status
  late DateTime currentTime;
  late Timer _timer;
  late Timer _connectionCheckTimer; // Timer for periodic connection checks

  late Timer _autoScrollTimer; // Add a timer for auto-scrolling
  PageController _pageController = PageController(viewportFraction: 0.93); // PageController for controlling the PageView
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List of upcoming matches with dynamic match time
  final List<Map<String, dynamic>> upcomingMatches = [
    {
      'matchTitle': 'Match 1',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 1',
      'team2Name': 'Team 2',
      'matchTime': '19:46', // Time as string
      'matchDate': '25/01/2025', // Date as string in dd/MM/yyyy format
      'megaAmount': 1000000,
    },
    {
      'matchTitle': 'Match 1',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 1',
      'team2Name': 'Team 2',
      'matchTime': '20:31',
      'matchDate': '13/02/2025',
      'megaAmount': 100000,
    },
    {
      'matchTitle': 'Match 2',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 3',
      'team2Name': 'Team 4',
      'matchTime': '21:00',
      'matchDate': '14/04/2025',
      'megaAmount': 150000,
    },
    {
      'matchTitle': 'Match 2',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 3',
      'team2Name': 'Team 4',
      'matchTime': '22:15',
      'matchDate': '15/12/2025',
      'megaAmount': 15000,
    },
  ];

  final List<String> matchImages = [
    ImageAssets.rummyBanner,
    ImageAssets.rummyBanner,
    ImageAssets.rummyBanner,
  ];

  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkConnectivity(); // Initial connectivity check
    currentTime = DateTime.now();
    _initializeDashboardSettings();
    // Timer to update current time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
    _startAutoScroll();
    // Timer for auto-scrolling the PageView every 3 seconds
    // _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   setState(() {
    //     // Increment the current image index or reset to 0 if it's the last image
    //     // _currentImageIndex = (_currentImageIndex + 1) % matchImages.length;
    //     _currentImageIndex = (_currentImageIndex + 1) % matchImages.length;
    //   });
    //   if (_currentImageIndex < matchImages.length - 1) {
    //     _currentImageIndex++;
    //   } else {
    //     _currentImageIndex = 0;
    //   }
    //   // Animate to the next page
    //   _pageController.animateToPage(
    //     _currentImageIndex,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
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
          _currentImageIndex = nextPage; // Update the indicator
        });
      }
    });
  }

  Future<void> _initializeDashboardSettings() async {
    await Prefs.setDashboardLoaded(true);  // Set it to true when the dashboard is loaded.
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
        isLoading = false; // Stop loading indicator
      });
      // If no connection, start checking periodically
      _startConnectionCheckTimer();
    } else {
      setState(() {
        isConnected = true;
        isLoading = false;
      });
    }
  }

  void _startConnectionCheckTimer() {
    _connectionCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        // If connection is available, stop the timer
        _connectionCheckTimer.cancel();
        setState(() {
          isConnected = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _autoScrollTimer.cancel();
    _connectionCheckTimer.cancel(); // Cancel the connection check timer
    _pageController.dispose();
    super.dispose();
  }

  // void _onPageChanged(int index) {
  //   setState(() {
  //     _currentImageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loader while loading
          : isConnected
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PageView with images
                      Container(
                        padding: EdgeInsets.only(
                          top: height * 0.008,
                          bottom: height * 0.008,
                        ),
                        height: height * 0.15,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index % matchImages.length; // Update the indicator
                            });
                          },
                          itemBuilder: (context, index) {
                            final actualIndex = index % matchImages.length; // Loop logic
                            return Padding(
                              padding: EdgeInsets.only(right: width * 0.02, left: width * 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  matchImages[actualIndex],
                                  width: width,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                      // Image indicators
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.005, horizontal: width * 0.035),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            matchImages.length,
                                (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 6,
                              width: _currentImageIndex == index ? 6 : 6,
                              decoration: BoxDecoration(
                                color: _currentImageIndex == index
                                    ? AppColors.brand
                                    : AppColors.greyText,
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Upcoming Matches Section
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.035),
                        child: Text(
                          Constants.upcomingmatches,
                          style: FTextStyle.heading,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: upcomingMatches.length,
                          itemBuilder: (context, index) {
                            // Sort upcoming matches based on matchTime in ascending order (earliest first)
                            upcomingMatches.sort((a, b) =>
                                a['matchTime'].compareTo(b['matchTime']));

                            var match = upcomingMatches[index];

                            String team1Name = getShortTeamName(match['team1Name']) ?? 'Team 1';
                            String team2Name = getShortTeamName(match['team2Name']) ?? 'Team 2';
                            String team1Image =
                                match['team1Image'] ?? ImageAssets.team1;
                            String team2Image =
                                match['team2Image'] ?? ImageAssets.team2;

                            // Parse matchTime and matchDate
                            String matchTime = match['matchTime'] ?? '00:00:00';
                            String matchDate =
                                match['matchDate'] ?? '01/01/2022';

                            // Combine matchDate and matchTime to form a single DateTime object
                            DateTime combinedMatchTime =
                                parseMatchDateTime(matchDate, matchTime);

                            // Skip past matches by checking if the match has passed
                            if (combinedMatchTime.isBefore(DateTime.now())) {
                              return SizedBox
                                  .shrink(); // Skip this item if the match has passed
                            }

                            int megaAmount = match['megaAmount'] ?? 0;

                            return GestureDetector(
                              onTap: () {
                                // Navigate to match details screen (uncomment to use)
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        SelectContestsScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      final offsetAnimation = animation.drive(tween);
                                      return SlideTransition(position: offsetAnimation, child: child);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: AppColors.containerBorder),
                                ),
                                margin: EdgeInsets.symmetric(vertical: height * 0.004,horizontal: width * 0.035),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Match Title
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.containerBG,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(7),
                                              bottomRight: Radius.circular(7),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.07),
                                          child: Text(
                                            match['matchTitle']!,
                                            style: FTextStyle.matchTitle,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Teams and Time
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.020,
                                          vertical: height * 0.008),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                    AssetImage(team1Image),
                                              ),
                                              SizedBox(height: height * 0.001),
                                              Text(
                                                team1Name,
                                                style: FTextStyle.teamName,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                formatMatchTimeAndDate(
                                                    combinedMatchTime,
                                                    matchDate), // Use the custom function here
                                                style: FTextStyle.timing,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: height * 0.001),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time,
                                                      color: Colors.red,
                                                      size: 16),
                                                  SizedBox(
                                                      width: width * 0.003),
                                                  Text(
                                                    getTimeLeft(
                                                        combinedMatchTime), // Pass the combined match time here
                                                    style: FTextStyle
                                                        .timeRemaining,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                    AssetImage(team2Image),
                                              ),
                                              SizedBox(height: height * 0.001),
                                              Text(team2Name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: FTextStyle.teamName),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Mega and Amount
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.020,
                                          vertical: height * 0.004),
                                      decoration: BoxDecoration(
                                        color: AppColors.containerBG,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors.brand),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.01,
                                                    vertical: height * 0.004),
                                                child: Text(
                                                  Constants.mega,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: FTextStyle.mega,
                                                ),
                                              ),
                                              SizedBox(width: width * 0.008),
                                              Text(
                                                formatAmount(megaAmount),
                                                overflow: TextOverflow.ellipsis,
                                                style: FTextStyle.amount,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            Constants.lineupsOut,
                                            overflow: TextOverflow.ellipsis,
                                            style: FTextStyle.lineupsOut,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 50, color: Colors.red),
                        SizedBox(height: 20),
                        Text(
                          Constants.noInternet,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: FTextStyle.timeRemaining,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
