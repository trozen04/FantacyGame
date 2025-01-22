import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/screens/Winners/winners_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity package
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/match_utils.dart';

class WinnersScreen extends StatefulWidget {
  @override
  _WinnersScreenState createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {
  bool isLoading = false; // Track loading state
  bool isConnected = true; // Track network connectivity status
  final List<Map<String, dynamic>> recentMatches = [
    {
      'league': 'Bangladesh T20 National League',
      'date': '14/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'points': {'batting': 93.39, 'bowling': 0, 'other': 8},
      'prize': 1000000,
      'winners': [
        {
          'rank': 4,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 1,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 2,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 3,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
      ]
    },
    {
      'league': 'Bangladesh 50 National League',
      'date': '13/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'points': {'batting': 93.39, 'bowling': 0, 'other': 8},
      'prize': 1000000,
      'winners': [
        {
          'rank': 4,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 1,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 2,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
        {
          'rank': 3,
          'name': 'Bhoopendra',
          'amount': 45000,
          'photo': ImageAssets.profile
        },
      ]
    },
  ];

  List<Map<String, dynamic>> filteredMatches = [];
  String selectedLeague = '';
  List<String> selectedLeagues =
      []; // Move this to a higher scope to persist across popups

  @override
  void initState() {
    super.initState();
    _checkNetworkConnection(); // Check network status on screen load
    filteredMatches = List.from(recentMatches);
    sortMatchesByDate();
    sortWinnersByRank();
  }

  Future<void> _checkNetworkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = (connectivityResult != ConnectivityResult.none);
    });
  }

  void sortMatchesByDate() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy'); // Correct format
    recentMatches.sort((a, b) {
      DateTime dateA = dateFormat.parse(a['date']);
      DateTime dateB = dateFormat.parse(b['date']);
      return dateB.compareTo(dateA); // Most recent date first
    });
  }

  void sortWinnersByRank() {
    for (var match in filteredMatches) {
      match['winners'].sort((a, b) {
        return (a['rank'] as int).compareTo(b['rank'] as int); // Ascending rank
      });
    }
  }

  void _filterMatchesByLeagues(List<String> leagues) {
    setState(() {
      if (leagues.isEmpty) {
        // If no leagues are selected, show all matches
        filteredMatches = List.from(recentMatches);
      } else {
        // Filter matches for all selected leagues
        filteredMatches = recentMatches
            .where((match) => leagues.contains(match['league']))
            .toList();
      }
      sortWinnersByRank();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(), // Loader while checking network
        ),
      );
    }

    // Show no internet connection message if no connection is detected
    if (!isConnected) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            Constants.noInternet,
            textAlign: TextAlign.center,
            style: FTextStyle.timeRemaining,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.008, horizontal: width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Constants.megaContestWinners,
                    style: FTextStyle.heading,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () => _showSortOptions(context, height, width),
                    child: Row(
                      children: [
                        Text(
                          Constants.filterBySeries,
                          style: FTextStyle.filter,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: width * 0.01),
                        Icon(Icons.filter_list,
                            color: AppColors.filter, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.005),
              Text(
                selectedLeague.isEmpty
                    ? Constants.recentMatches
                    : selectedLeague,
                style: FTextStyle.dailyContestHistoryDate,
                overflow: TextOverflow.ellipsis,
              ),
              Column(
                children: filteredMatches
                    .map((match) => _buildMatchCard(match, height, width))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(
      Map<String, dynamic> match, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height * 0.008, horizontal: width * 0.0),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.020, vertical: height * 0.004),
      decoration: BoxDecoration(
        color: AppColors.containerWinners,
        border: Border.all(
          color: AppColors.containerBorderWinners,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match['league'],
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.leagueWinners,
              ),
              Text(
                formatDate(match['date']),
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.dateWinners,
              ),
            ],
          ),
          Divider(color: AppColors.containerBorderWinners),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamInfo(
                  match['team1'], height, width, true), // Left-aligned
              Text(Constants.vs,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyle.dateWinners),
              _buildTeamInfo(
                  match['team2'], height, width, false), // Right-aligned
            ],
          ),
          Divider(color: AppColors.containerBorderWinners),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPointsInfo(Constants.battingPoints,
                  match['points']['batting'].toString(), height,
                  isPercentage: true),
              _buildPointsInfo(Constants.bowlingPoints,
                  match['points']['bowling'].toString(), height),
              _buildPointsInfo(Constants.otherPoints,
                  match['points']['other'].toString(), height),
            ],
          ),
          Divider(color: AppColors.containerBorderWinners),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                ImageAssets.trophyPNG,
                width: 24,
              ),
              SizedBox(width: width * 0.015),
              Text(
                formatAmount(match['prize']),
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.winnersAmount,
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: match['winners']
                  .map<Widget>(
                      (winner) => _buildWinnerCard(winner, height, width))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(
      Map<String, dynamic> team, double height, double width, bool isLeftAligned) {
    // Extract initials from the team name based on spaces
    String initials = getShortTeamName(team['name']); // Combine into a single string

    return Column(
      crossAxisAlignment:
      isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        // Team name at the top
        Text(
          team['name'],
          overflow: TextOverflow.ellipsis,
          style: FTextStyle.dateWinners,
        ),
        SizedBox(height: height * 0.004),
        // Row containing the image and trimmed initials
        Row(
          mainAxisAlignment:
          isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            // Image comes first for left alignment
            if (isLeftAligned) ...[
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(team['logo']),
              ),
              SizedBox(width: width * 0.02),
              Text(
                initials,
                style: FTextStyle.sortForm
              ),
            ],
            // Trimmed initials come first for right alignment
            if (!isLeftAligned) ...[
              Text(
                initials,
                style: FTextStyle.sortForm
              ),
              SizedBox(width: width * 0.02),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(team['logo']),
              ),
            ],
          ],
        ),
      ],
    );
  }


  Widget _buildPointsInfo(String title, String points, double height,
      {bool isPercentage = false}) {
    // If it's the first point (percentage), append '%' to the points
    if (isPercentage) {
      points = "$points%";
    }

    return Column(
      children: [
        Text(title, overflow: TextOverflow.ellipsis, style: FTextStyle.filter),
        SizedBox(height: height * 0.001),
        Text(points,
            overflow: TextOverflow.ellipsis, style: FTextStyle.dateWinners),
      ],
    );
  }

  Widget _buildWinnerCard(
      Map<String, dynamic> winner, double height, double width) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                WinnersInfo(),
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
        margin: EdgeInsets.only(right: width * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.015, vertical: height * 0.004),
        decoration: BoxDecoration(
          color: AppColors.containerBGWinnersList,
          border: Border.all(color: AppColors.containerBorderWinnersList),
          borderRadius: BorderRadius.circular(width * 0.02),
        ),
        child: Column(
          children: [
            Align(
              alignment:
                  Alignment.centerLeft, // Aligning the rank text to the left
              child: Text(
                '${Constants.rank} #${winner['rank']}',
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.dateWinners,
              ),
            ),
            Align(
              alignment: Alignment.center, // Centering the name text
              child: Text(
                winner['name'],
                style: FTextStyle.filter,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: height * 0.002),
            CircleAvatar(
              backgroundImage: AssetImage(winner['photo']),
              radius: 20,
            ),
            SizedBox(height: height * 0.002),
            Align(
              alignment: Alignment.center, // Centering the amount text
              child: Row(
                children: [
                  Text(
                    '${Constants.won} ',
                    style: FTextStyle.won,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₹${winner['amount']}',
                    overflow: TextOverflow.ellipsis,
                    style: FTextStyle.amountWon,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context, double height, double width) {
    // Extract unique leagues and their respective years
    final leaguesWithYears = recentMatches
        .map((match) {
      final date = _parseCustomDate(match['date']);
      final year = date != null ? date.year.toString() : '';
      return {'league': match['league'], 'year': year};
    })
        .toSet()
        .toList();

    final List<String> originalSelectedLeagues = List.from(selectedLeagues);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow scrolling to take full height
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool hasChanges = selectedLeagues
                .toSet()
                .difference(originalSelectedLeagues.toSet())
                .isNotEmpty ||
                originalSelectedLeagues
                    .toSet()
                    .difference(selectedLeagues.toSet())
                    .isNotEmpty;
            return Container(
              height: MediaQuery.of(context).size.height * 0.9, // Set height to full screen
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.016,
                  vertical: height * 0.01), // Equal symmetric padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Close and Clear options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        Constants.filterBySeries,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyle.filterPopUp,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedLeagues.clear(); // Clear selections
                            filteredMatches =
                                List.from(recentMatches); // Show all matches
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: width * 0.03),
                          child: Text(
                            Constants.clear,
                            overflow: TextOverflow.ellipsis,
                            style: FTextStyle.filterPopUp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  // Search Bar
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.026,
                        right: width * 0.05,
                        bottom: height * 0.0), // Equal symmetric padding
                    child: Container(
                      height: height * 0.05,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: Constants.search,
                          prefixIcon: Icon(Icons.search, color: AppColors.filter),
                          hintStyle: FTextStyle.leagueWinners,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.greyText,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            leaguesWithYears.retainWhere((leagueWithYear) =>
                                leagueWithYear['league']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()));
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(height: height * 0.03,),
                  // League List with Checkboxes
                  Expanded(
                    child: ListView.builder(
                      itemCount: leaguesWithYears.length,
                      itemBuilder: (context, index) {
                        final league = leaguesWithYears[index]['league'];
                        final year = leaguesWithYears[index]['year'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedLeagues.contains(league)) {
                                selectedLeagues.remove(league);
                              } else {
                                selectedLeagues.add(league);
                              }
                            });
                          },
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  league,
                                  overflow: TextOverflow.ellipsis,
                                  style: FTextStyle.dateWinners,
                                ),
                                Text(
                                  year,
                                  overflow: TextOverflow.ellipsis,
                                  style: FTextStyle.filter,
                                ),
                              ],
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedLeagues.contains(league)
                                      ? AppColors.brand
                                      : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: selectedLeagues.contains(league)
                                  ? Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppColors.brand,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              )
                                  : SizedBox(
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Apply Button
                  Center(
                    child: ElevatedButton(
                      onPressed: hasChanges
                          ? () {
                        _filterMatchesByLeagues(selectedLeagues);
                        Navigator.pop(context);
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand,
                        minimumSize: Size(width, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        Constants.apply,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyle.headingContest,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


// Custom method to parse 'MM/dd/yyyy' date format
  DateTime? _parseCustomDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final month = int.parse(parts[0]);
        final day = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
      return null;
    } catch (e) {
      return null; // Return null if parsing fails
    }
  }
}
