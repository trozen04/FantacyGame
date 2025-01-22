import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../widgets/match_utils.dart';

class WinnersInfo extends StatefulWidget {
  const WinnersInfo({super.key});

  @override
  State<WinnersInfo> createState() => _WinnersInfoState();
}

class _WinnersInfoState extends State<WinnersInfo> {
  final List<Map<String, dynamic>> recentlyPlayedMatches = [
    {
      'league': 'Bangladesh T20',
      'date': '13/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'highestPoint': 733.5,
      'teamCreated': 8,
      'heroTeam': 781.5,
    },
    {
      'league': 'India Premier League',
      'date': '13/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'highestPoint': 653.2,
      'teamCreated': 12,
      'heroTeam': 701.3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Top bar with back and share icons
          Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.06,
            right: screenWidth * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Action for the back button
                  },
                  child: Image.asset(
                    'assets/images/back.png',
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/share.png',
                    width: screenWidth * 0.07,
                    height: screenWidth * 0.07,
                  ),
                ),
              ],
            ),
          ),
          // White container with rounded corners
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.13,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.09),
                  topRight: Radius.circular(screenWidth * 0.09),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center ,
                          children: [
                            SizedBox(height: screenHeight * 0.05), // Dynamic distance at the top
                               Text('Parthad Heartbrekar',style:FTextStyle.selectcontest_megacontestent,),
                               SizedBox(height: screenHeight * 0.01), // Space between the texts
                               Container(
                                 padding: EdgeInsets.symmetric(
                                   vertical: screenHeight * 0.01, // Dynamic vertical padding
                                   horizontal: screenWidth * 0.03, // Dynamic horizontal padding
                                 ),
                                 decoration: BoxDecoration(
                                   color: Color.fromRGBO(22, 152, 87, 0.1), // Corrected color usage
                                   borderRadius: BorderRadius.circular(screenWidth * 0.04), // Dynamic rounded corners
                                 ),
                                 child: Text(
                                   'Skill Score: 533',
                                   style: FTextStyle.Score, // Text color for contrast
                                 ),
                               ),
                            ]
                            ),
                      ),





                          SizedBox(height: screenHeight*0.01,),
                          Divider(height: 3, thickness: 1,color: Color(0xffe9e9e9),),
                          SizedBox(height: screenHeight*0.01,),
                          Text('Career Stats',style:FTextStyle.selectcontest_megacontestent,),
                          SizedBox(height: screenHeight*0.01,),
                          Container(
                            width: screenWidth * 0.9,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // First Row with Circle Avatars
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/images/profile.png'), // Replace with your asset
                                        ),
                                        SizedBox(height: 5,),
                                        Text('Parthad',style: FTextStyle.Name,),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/images/profile.png'), // Replace with your asset
                                        ),
                                        SizedBox(height: 5,),
                                        Text('You',style: FTextStyle.Score,),
                                      ],
                                    )
                                  ],
                                ),
                                // Second Row with Centered Text
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Skill Score',
                                      style: FTextStyle.Name
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight*0.01),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // First Container
                                    Container(
                                      width: screenWidth*0.23, // Adjust width as needed
                                      height: screenHeight*0.05,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Color(0xffF1F1F1), width: 5),
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.25), // Shadow color with opacity
                                            blurRadius: 4, // Blur effect
                                            offset: Offset(0, 4), // Position of the shadow (x, y)
                                          ),
                                        ],
                                        // Rounded corners
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '5 3 3',
                                        style: FTextStyle.digitalnum,
                                      ),
                                    ),
                                    // Second Container
                                    Container(
                                      width: screenWidth*0.23, // Adjust width as needed
                                      height: screenHeight*0.05, // Adjust height as needed
                                      decoration: BoxDecoration(
                                        color:  Colors.white,
                                        border: Border.all(color: Color(0xffF1F1F1), width: 5),
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.25), // Shadow color with opacity
                                            blurRadius: 4, // Blur effect
                                            offset: Offset(0, 4), // Position of the shadow (x, y)
                                          ),
                                        ],// Rounded corners
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '7 3 3',
                                        style: FTextStyle.digitalnum,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight*0.015,),
                                Divider(height: 3, thickness: 1,color: Color(0xffe9e9e9),),
                                SizedBox(height: screenHeight*0.015,),

                                // Custom Row Function
                                customRow('1,000+', 'Contest', '2'),
                                SizedBox(height: screenHeight*0.01,),
                                Divider(height: 3, thickness: 1,color: Color(0xffe9e9e9),),
                                SizedBox(height: screenHeight*0.01,),
                                customRow('1,000+', 'Matches', '2'),
                                SizedBox(height: screenHeight*0.01,),
                                Divider(height: 3, thickness: 1,color: Color(0xffe9e9e9),),
                                SizedBox(height: screenHeight*0.01,),
                                customRow('1,000+', 'Series', '2'),
                                SizedBox(height: screenHeight*0.01,),
                                Divider(height: 3, thickness: 1,color: Color(0xffe9e9e9),),
                                SizedBox(height: screenHeight*0.01,),
                                customRow('Sep 2020', 'Playing Since', 'Dec 2024'),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight*0.01,),
                          Text('Recently Played',style:FTextStyle.selectcontest_megacontestent,),
                          SizedBox(height: screenHeight*0.01,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: recentlyPlayedMatches.map((match) {
                                return _buildMatchCard(match, context);
                              }).toList(),
                            ),
                          )



                          // Content inside the white container
                        ],
                      ),


                ),
              ),
            ),
          ),
          // CircleAvatar overlapping the white container
          Positioned(
            top: screenHeight * 0.09, // Slightly above the white container
            left: screenWidth * 0.5 - 40, // Center align
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/profile.png'), // Replace with your asset
              backgroundColor: Colors.transparent, // Optional if using backgroundImage
            ),
          ),
        ],
      ),
    );
  }
  // Function to create a row with three arguments spaced evenly
  Widget customRow(String arg1, String arg2, String arg3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(arg1, style: FTextStyle.Name),
        Text(arg2, style: FTextStyle.filter),
        Text(arg3, style: FTextStyle.Name),
      ],
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.91, // Fixed width (90% of screen width, or any preferred value)
      margin: EdgeInsets.only(
          right: width * 0.02),
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
              _buildPointsInfo(Constants.highestPoint,
                  match['highestPoint'].toString(), height, true),
              _buildPointsInfo(Constants.teamCreated,
                  match['teamCreated'].toString(), height, false),
            ],
          ),
          Divider(color: AppColors.containerBorderWinners),

          Text('${Constants.heroTeam} ${match['heroTeam']} ${Constants.pts}', style: FTextStyle.live,),
        ],
      ),
    );
  }


  Widget _buildPointsInfo(String title, String points, double height, bool left,) {

    return Column(
      children: [
        Text(title, overflow: TextOverflow.ellipsis, style: FTextStyle.filter),
        SizedBox(height: height * 0.001),
        Text(points,
            overflow: TextOverflow.ellipsis, style: FTextStyle.dateWinners),
      ],
    );
  }

  Widget _buildTeamInfo(
      Map<String, dynamic> team, double height, double width, bool isLeftAligned) {
    // Extract initials from the team name based on spaces
    String initials = team['name']
        .split(' ') // Split the name into words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '') // Get the first letter
        .join(); // Combine into a single string

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
                style: FTextStyle.dateWinners.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
            // Trimmed initials come first for right alignment
            if (!isLeftAligned) ...[
              Text(
                initials,
                style: FTextStyle.dateWinners.copyWith(fontWeight: FontWeight.bold),
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


}
