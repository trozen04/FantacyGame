import 'package:flutter/material.dart';
import '../../../../Utils/ImageAssets.dart';
import '../../../../Utils/flutter_font_style.dart';

class StatsTab extends StatelessWidget {
  final List<Map<String, dynamic>> playersData = [
    {
      "name": "Virat Kohli",
      "team": "MI",
      "role": "Bat",
      "image": ImageAssets.virat, // Placeholder for player image
      "points": 45,
      "sellBy": 30,
    },
    {
      "name": "Player 2",
      "team": "Del",
      "role": "Bowl",
      "image": ImageAssets.virat, // Placeholder for player image
      "points": 50,
      "sellBy": 40,
    },
    {
      "name": "Player 3",
      "team": "MI",
      "role": "All",
      "image": ImageAssets.virat, // Placeholder for player image
      "points": 30,
      "sellBy": 90, // This player will have a yellow background
    },
    // Add more players as needed
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 1, // Only one tab for Stats
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            // Stats Tab content
            Builder(
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: height * 0.01,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Player stats at match level', style: FTextStyle.enterDetail,),
                          Text('Highlight', style: FTextStyle.enterDetail)
                        ],
                      ),
                      SizedBox(height: height * 0.01,),
                      Divider(),
                      // Heading Row
                      SizedBox(height: height * 0.02 ,),

                      // Header Row (Players, Points, % Sell By)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Players",
                              style: FTextStyle.outBy,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Points",
                              style: FTextStyle.outBy,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center, // Center text under "Points"
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "% Sell By",
                              style: FTextStyle.outBy,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right, // Center text under "% Sell By"
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: playersData.length,
                          itemBuilder: (context, index) {
                            var player = playersData[index];
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: height * 0.008),
                              color: player["sellBy"] > 85
                                  ? Color(0xFFFFF9EF) // Yellow with 0.1 opacity
                                  : Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly between children
                                children: [
                                  // Player Image and Details under "Players"
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            player["image"],
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              player["name"],
                                              style: FTextStyle.notBatting,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  player["team"],
                                                  style: FTextStyle.outBy,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  player["role"],
                                                  style: FTextStyle.outBy,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Points under "Points" heading
                                  Expanded(
                                    child: Text(
                                      "${player["points"]}",
                                      style: FTextStyle.dailyContestHistoryDate,
                                      textAlign: TextAlign.center, // Center the points
                                    ),
                                  ),

                                  // % Sell By under "% Sell By" heading
                                  Expanded(
                                    child: Text(
                                      "% ${player["sellBy"]}",
                                      style: FTextStyle.bowlerRuns,
                                      textAlign: TextAlign.right, // Center text under "% Sell By"
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
