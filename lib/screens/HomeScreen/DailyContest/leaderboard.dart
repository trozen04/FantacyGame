import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/match_utils.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  int selectedTabIndex = 1; // Default: "All Time"
  // Sample data for each tab
  final Map<int, List<Map<String, dynamic>>> tabData = {
    0: [
      {
        'rank': 1,
        'name': 'WeeklyTop1',
        'amount': 30000,
        'tickets': 400,
        'image': ImageAssets.profile
      },
      {
        'rank': 2,
        'name': 'WeeklyTop2',
        'amount': 27000,
        'tickets': 400,
        'image': ImageAssets.profile
      },
      {
        'rank': 3,
        'name': 'WeeklyTop3',
        'amount': 24000,
        'tickets': 400,
        'image': ImageAssets.profile
      },
      {
        'rank': 8,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 5,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'WeeklyUser45',
        'tickets': 400,
        'amount': 100000000000,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 5,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 5,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'WeeklyUser4',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
    ],
    1: [
      {
        'rank': 1,
        'name': 'AllTimeTop1AllTimeTop1AllTimeTop1',
        'amount': 30000,
        'tickets': 400,
        'image': ''
      },
      {
        'rank': 2,
        'name': 'AllTimeTop2',
        'amount': 27000,
        'tickets': 452,
        'image': ImageAssets.profile
      },
      {
        'rank': 3,
        'name': 'AllTimeTop3',
        'amount': 24000,
        'tickets': 452,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'Umair6241',
        'tickets': 452,
        'amount': 14500,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 5,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 5,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
      {
        'rank': 6,
        'name': 'AllTime',
        'tickets': 400,
        'amount': 10000,
        'image': ImageAssets.profile
      },
    ],
    2: [
      {
        'rank': 1,
        'name': 'MonthlyTop1',
        'amount': 30000,
        'tickets': 400,
        'image': ImageAssets.profile
      },
      {
        'rank': 2,
        'name': 'MonthlyTop2',
        'amount': 27000,
        'tickets': 452,
        'image': ImageAssets.profile
      },
      {
        'rank': 3,
        'name': 'MonthlyTop3',
        'amount': 24000,
        'tickets': 452,
        'image': ImageAssets.profile
      },
      {
        'rank': 4,
        'name': 'MonthlyUser4',
        'tickets': 600,
        'amount': 20000,
        'image': ImageAssets.profile
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final leaderboard = tabData[selectedTabIndex]!;

    return Scaffold(
      body: Stack(
        children: [
          // Background design for the top section
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    ImageAssets.background), // Replace with your image path
                fit: BoxFit
                    .cover, // Ensures the image covers the entire container
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.00),
            child: Column(
              children: [
                // Top section with the image background
                _buildAppBar(size),
                _buildPodium(size, leaderboard),
                _buildTabs(size),
                // Bottom section with a white background
                Expanded(
                  child: Container(
                    color: Colors
                        .white, // White background for the leaderboard list
                    child: _buildLeaderboardList(size, leaderboard),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Image
        Image.asset(
          ImageAssets.trophy, // Replace with your left image asset
          height: 25,
          fit: BoxFit.cover,
        ),

        // Centered Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                Constants.leaderboardCaps,
                style: FTextStyle.leaderBoardText.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // Solid text as fill.
              Text(
                Constants.leaderboardCaps,
                style: FTextStyle.leaderBoardText,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Right Image
        Image.asset(
          ImageAssets.trophy, // Replace with your right image asset
          // width: size.width * 0.1, // Adjust the size of the image
          height: 25,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildPodium(Size size, List<Map<String, dynamic>> leaderboard) {
    // Sort the leaderboard by rank (ascending order)
    leaderboard.sort((a, b) => a['rank'].compareTo(b['rank']));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display podium users in sorted order
          _buildPodiumUser(size, leaderboard[1], AppColors.winningAmount, 2,
              size.height * 0.14),
          _buildPodiumUser(size, leaderboard[0], AppColors.brand, 1,
              size.height * 0.18), // First position
          _buildPodiumUser(
              size, leaderboard[2], AppColors.podium3, 3, size.height * 0.14),
        ],
      ),
    );
  }

  Widget _buildPodiumUser(Size size, Map<String, dynamic> user, Color color,
      int position, double height) {

    final formattedAmount = formatCash(user['amount']);



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Container(
        width: size.width * 0.23,
        height: height * 1.1,
        padding: position == 1
            ? EdgeInsets.only(
                bottom: height *
                    0.25) // Add extra padding at the bottom for #1 rank
            : null, // No additional padding for other ranks
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Background Image
            Container(
              margin: EdgeInsets.only(bottom: size.width * 0.015),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.podiumBG),
                  fit: BoxFit
                      .fill, // Ensures the image fully covers the background
                ),
                // border: Border.all(color: Colors.red), // Optional border for debugging
              ),
            ),
            // Content Overlay
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.width * 0.015),
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: AppColors
                        .borderRadiusImage, // Circular background color
                    borderRadius: BorderRadius.circular(
                        height * 0.2), // Circular background shape
                  ),
                  child: ClipOval(
                    child: user['image'] != null &&
                            user['image'].isNotEmpty // Check if image exists
                        ? Padding(
                            padding: EdgeInsets.all(
                                size.width * 0.005), // Padding around the image
                            child: ClipOval(
                              // Apply circular clipping to the image
                              child: Image.asset(
                                user['image'],
                                fit: BoxFit
                                    .cover, // Image should cover the circular area
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(
                                size.width * 0.005), // Padding around the image
                            child: Center(
                              child: Text(
                                user['name'] != null && user['name'].isNotEmpty
                                    ? user['name'][0]
                                        .toUpperCase() // First letter of the name
                                    : '', // Fallback for empty name
                                style: FTextStyle.imageText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                // User Name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: Text(
                    user['name'],
                    textAlign: TextAlign.center,
                    style: FTextStyle.podiumName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // User Amount
    Text('${user.containsKey('amount') ? formattedAmount : ''}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: FTextStyle.podiumAmount.copyWith(color: color)),
              ],
            ),
            // Position Ranking under Podium
            Positioned(
              bottom:
                  0, // Adjust the positioning if needed to prevent cutting off
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      position == 1
                          ? ImageAssets.podium1 // Image for #1 rank
                          : position == 2
                              ? ImageAssets.podium2 // Image for #2 rank
                              : ImageAssets.podium3, // Image for #3 rank
                    ),
                    fit: BoxFit
                        .fill, // Ensures the image covers the entire background
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$position',
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyle.podiumBG,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(Size size) {
    double tabWidth = size.width * 0.25; // Each tab takes 1/4 of the width

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.LeaderBoardTabBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the tabs
        children: [
          _buildTab(size, 'Weekly', 0, tabWidth),
          _buildTab(size, 'All Time', 1, tabWidth),
          _buildTab(size, 'Monthly', 2, tabWidth),
        ],
      ),
    );
  }

  Widget _buildTab(Size size, String title, int index, double tabWidth) {
    bool isActive = selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        width: tabWidth,
        alignment: Alignment.center, // Center the text inside the tab
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Ensures the column doesn't take up unnecessary height
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.leaderBoardtabbar.copyWith(
                color: isActive ? AppColors.brand : Colors.white,
              ),
            ),
            // Container under the text that changes color based on selection
            Container(
              height: 4.5, // Adjust the height of the container under the text
              width: tabWidth /
                  1.5, // Set the width to a fraction of the tab width
              color: isActive
                  ? AppColors.brand
                  : Colors.transparent, // Change color based on selection
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardList(
      Size size, List<Map<String, dynamic>> leaderboard) {
    // Filter users with rank >= 4 and sort by rank
    var filteredLeaderboard =
        leaderboard.where((user) => user['rank'] >= 4).toList();
    filteredLeaderboard.sort((a, b) => a['rank'].compareTo(b['rank']));

    return Column(
      children: [
        // Header row
        Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.005, horizontal: size.width * 0.018),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.005),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                Constants.srNo,
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.leaderBoardtabbarHeadings,
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Constants.users,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyle.leaderBoardtabbarHeadings,
                ),
              ),
              SizedBox(
                width: size.width * 0.14,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Constants.ticketBought,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyle.leaderBoardtabbarHeadings,
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Constants.win,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyle.leaderBoardtabbarHeadings,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Leaderboard list
        Expanded(
          child: ListView.builder(
            itemCount:
                filteredLeaderboard.length, // Use filtered and sorted list
            itemBuilder: (context, index) {

              final user = filteredLeaderboard[index];
              final formattedAmount = formatCash(user['amount']);

              return Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.002,
                    horizontal: size.width * 0.033),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.01),
                decoration: BoxDecoration(
                    color: AppColors.leaderBoardRanking,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${user['rank']}',
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyle.tabbar,
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.borderRadiusImage,
                            backgroundImage: user.containsKey('image') &&
                                    user['image'] != null
                                ? AssetImage(user['image'])
                                : null, // Use image if available
                            child: user.containsKey('image') &&
                                    user['image'] != null
                                ? null
                                : Text(
                                    user['name'][0],
                                    style: FTextStyle.tabbar,
                                  ), // Use initial if no image
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: Text(
                              user['name'],
                              overflow: TextOverflow.ellipsis,
                              style: FTextStyle.tabbar,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        user.containsKey('tickets') ? '${user['tickets']}' : '',
                        style: FTextStyle.tabbar,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.containsKey('amount') ? formattedAmount : '',
                        style: FTextStyle.tabbar.copyWith(color: AppColors.brand),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
