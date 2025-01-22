import 'dart:async';
import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity package
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/match_utils.dart';
import '../../Cricket Details/cricket_liveScore.dart';

class MyMatchesScreen extends StatefulWidget {
  final int selectedIndex;
  final bool viewAll;
  MyMatchesScreen({required this.selectedIndex, required this.viewAll});
  @override
  _MyMatchesScreenState createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  late int _selectedIndex;
  bool _isLoading = true;
  bool _isNoNetwork = false;

  // Tab titles
  final List<String> _tabTitles = [
    Constants.upcoming,
    Constants.live,
    Constants.completed
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Use the passed index here
    _checkConnectivity();

  }

  // Check for network connectivity
  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isNoNetwork = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isNoNetwork = false;
        _isLoading = false;
      });
      // Optionally: Add your network data fetch logic here
    }
  }

  // Change the selected index
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: widget.viewAll
          ? AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
              fit: BoxFit.cover,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.heading, size: 18,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0), // Right padding for space
          child: Text(
            Constants.mymatches,
            style: FTextStyle.buttonText,
          ),
        ),
        actions: [],
      )
          : null, // AppBar is shown only when viewAll is true
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loader while loading
          : _isNoNetwork
              ? _noNetworkWidget() // Show no network message
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: isPortrait ? height * 0.05 : height * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.background),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(_tabTitles.length, (index) {
                          return GestureDetector(
                            onTap: () => _onTabSelected(index),
                            child: Container(
                              width: width / 3,
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.008),
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _tabTitles[index],
                                  style: FTextStyle.myMatchesTabs.copyWith(
                                    fontWeight: _selectedIndex == index
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: _selectedIndex == index
                                        ? AppColors.brand
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: _getTabContent(_selectedIndex, width, height),
                    ),
                  ],
                ),
    );
  }

  Widget _noNetworkWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_off, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            Constants.noInternet,
            textAlign: TextAlign.center,
            style: FTextStyle.timing,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _checkConnectivity(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Retry", style: FTextStyle.headingContest),
          ),
        ],
      ),
    );
  }

  // Return the content for the selected tab
  Widget _getTabContent(int index, double width, double height) {
    switch (index) {
      case 0:
        return UpcomingTabContent(width: width, height: height);
      case 1:
        return LiveTabContent(
            width: width, height: height, onTabChanged: _onTabSelected);
      case 2:
        return CompletedTabContent(
            width: width, height: height, onTabChanged: _onTabSelected);
      default:
        return UpcomingTabContent(width: width, height: height);
    }
  }
}

class UpcomingTabContent extends StatefulWidget {
  final double width;
  final double height;

  UpcomingTabContent({required this.width, required this.height});

  @override
  _UpcomingTabContentState createState() => _UpcomingTabContentState();
}

class _UpcomingTabContentState extends State<UpcomingTabContent> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> upcomingMatches =
        MatchData.instance.upcomingMatches;

    // Filter upcoming matches where status is "Upcoming"
    List<Map<String, dynamic>> filteredMatches = upcomingMatches.where((match) {
      // Using getMatchStatus to get the status of each match
      String status = MatchCard.getMatchStatus(
          MatchCard.getMatchDateTime(match['matchDate'], match['matchTime']));
      return status == 'Upcoming';
    }).toList();

    // Sort matches by matchTime
    filteredMatches.sort((a, b) {
      DateTime dateTimeA =
          MatchCard.getMatchDateTime(a['matchDate'], a['matchTime']);
      DateTime dateTimeB =
          MatchCard.getMatchDateTime(b['matchDate'], b['matchTime']);
      return dateTimeA.compareTo(dateTimeB);
    });

    return Stack(
      children: [
        Container(color: Colors.white),
        filteredMatches.isEmpty
            ? Center(
                child: Text(
                  Constants.noMatches,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: FTextStyle.timeRemaining,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : ListView.builder(
                itemCount: filteredMatches.length,
                itemBuilder: (context, index) {
                  var match = filteredMatches[index];
                  return MatchCard(
                    width: widget.width,
                    height: widget.height,
                    match: match,
                  );
                },
              ),
      ],
    );
  }
}

class LiveTabContent extends StatefulWidget {
  final double width;
  final double height;
  final Function(int) onTabChanged;

  LiveTabContent(
      {required this.width, required this.height, required this.onTabChanged});

  @override
  _LiveTabContentState createState() => _LiveTabContentState();
}

class _LiveTabContentState extends State<LiveTabContent> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> upcomingMatches =
        MatchData.instance.upcomingMatches;

    // Filter live matches
    List<Map<String, dynamic>> liveMatches = upcomingMatches.where((match) {
      String status = MatchCard.getMatchStatus(
          MatchCard.getMatchDateTime(match['matchDate'], match['matchTime']));
      return status == 'Live';
    }).toList();

    // Sort matches by matchTime (most recent first)
    liveMatches.sort((a, b) {
      DateTime dateTimeA =
          MatchCard.getMatchDateTime(a['matchDate'], a['matchTime']);
      DateTime dateTimeB =
          MatchCard.getMatchDateTime(b['matchDate'], b['matchTime']);
      return dateTimeB.compareTo(dateTimeA); // Most recent first
    });

    return Stack(
      children: [
        Container(color: Colors.white),
        liveMatches.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(
                    vertical: widget.height * 0.06,
                    horizontal: widget.width * 0.08),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(ImageAssets.noLiveMatches,
                          width: widget.width * 0.3, height: widget.height * 0.2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.height * 0.02,
                            horizontal: widget.width * 0.01),
                        child: Text(
                          Constants.noLiveMatchesDesc,
                          style: FTextStyle.noLiveMatchesDesc,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: widget.height * 0.02),
                      ElevatedButton(
                        onPressed: () => widget.onTabChanged(0),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brand,
                          minimumSize: Size(widget.width, widget.height * 0.055),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          Constants.viewUpcomingMatches,
                          style: FTextStyle.headingContest,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: liveMatches.length,
                itemBuilder: (context, index) {
                  var match = liveMatches[index];
                  return MatchCard(
                    width: widget.width,
                    height: widget.height,
                    match: match,
                  );
                },
              ),
      ],
    );
  }
}

class CompletedTabContent extends StatelessWidget {
  final double width;
  final double height;
  final Function(int) onTabChanged;

  CompletedTabContent(
      {required this.width, required this.height, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> upcomingMatches =
        MatchData.instance.upcomingMatches;

    // Filter completed matches
    List<Map<String, dynamic>> completedMatches =
        upcomingMatches.where((match) {
      String status = MatchCard.getMatchStatus(
          MatchCard.getMatchDateTime(match['matchDate'], match['matchTime']));
      return status == 'Completed';
    }).toList();

    // Sort matches by matchTime (most recent first)
    completedMatches.sort((a, b) {
      DateTime dateTimeA =
          MatchCard.getMatchDateTime(a['matchDate'], a['matchTime']);
      DateTime dateTimeB =
          MatchCard.getMatchDateTime(b['matchDate'], b['matchTime']);
      return dateTimeB.compareTo(dateTimeA); // Most recent first
    });

    return Stack(
      children: [
        Container(color: Colors.white),
        completedMatches.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.06, horizontal: width * 0.08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImageAssets.noLiveMatches,
                        width: width * 0.3, height: height * 0.2),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.01),
                      child: Text(
                        Constants.noCompletedMatchesDesc,
                        style: FTextStyle.noLiveMatchesDesc,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      onPressed: () => onTabChanged(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand,
                        minimumSize: Size(width, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        Constants.viewUpcomingMatches,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyle.headingContest,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: completedMatches.length,
                itemBuilder: (context, index) {
                  var match = completedMatches[index];
                  return MatchCard(
                    width: width,
                    height: height,
                    match: match,
                  );
                },
              ),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final double width;
  final double height;
  final Map<String, dynamic> match;

  MatchCard({required this.width, required this.height, required this.match});

  // Helper function to convert string date and time to DateTime
  static DateTime getMatchDateTime(String matchDate, String matchTime) {
    // Parse the date using the correct format
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime date = dateFormat.parse(matchDate);

    // Parse the time (matchTime) into hours and minutes
    List<String> timeParts = matchTime.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Return DateTime object for the match date and time
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  // Function to get the status of the match
  static String getMatchStatus(DateTime matchDateTime) {
    final now = DateTime.now();

    if (matchDateTime.isAfter(now)) {
      return Constants.upcoming;
    } else if (matchDateTime.isBefore(now) &&
        matchDateTime.isAfter(now.subtract(Duration(hours: 4)))) {
      return Constants.live;
    } else {
      return Constants.completed;
    }
  }

  // Helper function to format time
  // String formatTime(DateTime matchDateTime) {
  //   return "${matchDateTime.hour.toString().padLeft(2, '0')}:${matchDateTime.minute.toString().padLeft(2, '0')}";
  // }

  @override
  Widget build(BuildContext context) {
    String team1Name = getShortTeamName(match['team1Name']) ?? 'Team 1';
    String team2Name = getShortTeamName(match['team2Name']) ?? 'Team 2';
    String team1Image = match['team1Image'] ?? ImageAssets.team1;
    String team2Image = match['team2Image'] ?? ImageAssets.team2;

    // Convert the string matchDate and matchTime to DateTime for sorting and status calculation
    DateTime matchDateTime =
        getMatchDateTime(match['matchDate'], match['matchTime']);

    int totalTeams = match['totalTeams'] ?? 0;
    int totalContests = match['totalContests'] ?? 0;

    String matchStatus = getMatchStatus(matchDateTime); // Get match status

    return GestureDetector(
      onTap: () {
        print("Match card clicked: ${match['matchTitle']}");
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            LiveScoreScreen(),
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
          border: Border.all(color: AppColors.containerBorder),
        ),
        margin: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerBG,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Text(
                    match['matchTitle']!,
                    overflow: TextOverflow.ellipsis,
                    style: FTextStyle.matchTitle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            // Teams and Time
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.020, vertical: height * 0.008),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(team1Image),
                      ),
                      SizedBox(height: height * 0.001),
                      Text(team1Name,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.teamName),
                    ],
                  ),
                  Column(
                    children: [
                      matchStatus == Constants.live
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  color: Colors.green,
                                  size: 6,
                                ),
                                SizedBox(width: width * 0.01),
                                Text(
                                  Constants.live,
                                  overflow: TextOverflow.ellipsis,
                                  style: FTextStyle.live,
                                ),
                              ],
                            )
                          : Text(
                              matchStatus == Constants.upcoming
                                  ? formatTime(matchDateTime)
                                  : Constants.completed,
                              style: matchStatus == Constants.upcoming
                                  ? FTextStyle.timing
                                  : (matchStatus == Constants.live
                                      ? FTextStyle.live
                                      : FTextStyle.teamsContests),
                              overflow: TextOverflow.ellipsis,
                            ),
                      SizedBox(height: height * 0.001),
                      matchStatus == Constants.upcoming
                          ? GestureDetector(
                              onTap: () {
                                print(
                                    "Time left clicked for match: ${match['matchTitle']}");
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: width * 0.003),
                                  Text(
                                    getTimeLeft(matchDateTime),
                                    overflow: TextOverflow.ellipsis,
                                    style: FTextStyle.timeRemaining,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(team2Image),
                      ),
                      SizedBox(height: height * 0.001),
                      Text(team2Name,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.teamName),
                    ],
                  ),
                ],
              ),
            ),
            // Mega and Amount
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.020, vertical: height * 0.004),
              decoration: BoxDecoration(
                color: AppColors.containerBG,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$totalTeams Teams',
                    overflow: TextOverflow.ellipsis,
                    style: FTextStyle.teamsContests,
                  ),
                 // SizedBox(width: width * 0.03),
                  Text(
                    '20 Dec, 1:45 pm',
                    overflow: TextOverflow.ellipsis,
                    style: FTextStyle.teamsContests,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchData {
  // Private constructor for singleton pattern
  MatchData._privateConstructor();

  // Static instance of the class
  static final MatchData _instance = MatchData._privateConstructor();

  // Getter for the instance
  static MatchData get instance => _instance;

  // List of matches (you can add/update matches here)
  final List<Map<String, dynamic>> upcomingMatches = [
    {
      'matchTitle': 'Match 1',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 1',
      'team2Name': 'Team 2',
      'matchTime': '11:46', // Time as string
      'matchDate': '08/01/2025', // Date as string in dd/MM/yyyy format
      'totalTeams': 1,
      'totalContests': 1,
    },
    {
      'matchTitle': 'Match 46',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '18:00',
      'matchDate': '08/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 16',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '20:15',
      'matchDate': '08/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },


    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '17:20',
      'matchDate': '15/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '17:20',
      'matchDate': '15/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '17:20',
      'matchDate': '15/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'MI vs DEL',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Mumbai Indians',
      'team2Name': 'Delhi',
      'matchTime': '07:20',
      'matchDate': '08/02/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '20:20',
      'matchDate': '08/02/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '20:20',
      'matchDate': '08/02/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
    {
      'matchTitle': 'Match 17',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 11',
      'team2Name': 'Team 12',
      'matchTime': '20:20',
      'matchDate': '15/01/2025',
      'totalTeams': 6,
      'totalContests': 6,
    },
  ];
}
