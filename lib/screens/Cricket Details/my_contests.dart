import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Utils/ImageAssets.dart';
import '../../../../Utils/constant.dart';
import '../../../../Utils/flutter_color_themes.dart';
import '../../../../Utils/flutter_font_style.dart';
import '../../../../widgets/match_utils.dart'; // Add this for date formatting


class ContestsScreen extends StatelessWidget {
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
      'matchTitle': 'Match 21',
      'team1Image': ImageAssets.team1,
      'team2Image': ImageAssets.team2,
      'team1Name': 'Team 3',
      'team2Name': 'Team 4',
      'matchTime': '22:15',
      'matchDate': '15/12/2025',
      'megaAmount': 15000,
    },
    {
      'matchTitle': 'Match 3',
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

  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: upcomingMatches.length,
          itemBuilder: (context, index) {
            // Sort upcoming matches based on matchTime in ascending order (earliest first)
            // upcomingMatches.sort((a, b) => a['matchTime'].compareTo(b['matchTime']));
        
            var match = upcomingMatches[index];
        
            String team1Name = match['team1Name'] ?? 'Team 1';
            String team2Name = match['team2Name'] ?? 'Team 2';
            String team1Image = match['team1Image'] ?? ImageAssets.team1;
            String team2Image = match['team2Image'] ?? ImageAssets.team2;
        
            // Parse matchTime and matchDate
            String matchTime = match['matchTime'] ?? '00:00:00';
            String matchDate = match['matchDate'] ?? '01/01/2022';
        
            // Combine matchDate and matchTime to form a single DateTime object
            DateTime combinedMatchTime = parseMatchDateTime(matchDate, matchTime);
        
            // Skip past matches by checking if the match has passed
            if (combinedMatchTime.isBefore(DateTime.now())) {
              return SizedBox.shrink(); // Skip this item if the match has passed
            }
        
            int megaAmount = match['megaAmount'] ?? 0;
        
            return GestureDetector(
              onTap: () {
                // Navigate to match details screen (uncomment to use)
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MatchDetailScreen(match: match),
                //   ),
                // );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: AppColors.containerBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Match Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            match['matchTitle'] ?? 'Match',
                            style: FTextStyle.matchTitle,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    // Teams and Time
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(team1Image),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                team1Name,
                                style: FTextStyle.teamName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                formatMatchTimeAndDate(combinedMatchTime, matchDate),
                                style: FTextStyle.timing,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.red, size: 16),
                                  SizedBox(width: 4.0),
                                  Text(
                                    getTimeLeft(combinedMatchTime),
                                    style: FTextStyle.timeRemaining,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(team2Image),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                team2Name,
                                overflow: TextOverflow.ellipsis,
                                style: FTextStyle.teamName,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Mega Amount and Lineups Out
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.brand),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  Constants.mega,
                                  style: FTextStyle.mega,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                formatAmount(megaAmount),
                                style: FTextStyle.amount,
                              ),
                            ],
                          ),
                          Text(
                            Constants.lineupsOut,
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
    );
  }
}
