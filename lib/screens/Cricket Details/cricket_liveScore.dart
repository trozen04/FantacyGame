
import 'package:fantacy_game/screens/Cricket%20Details/scoreCard.dart';
import 'package:fantacy_game/screens/Cricket%20Details/stats.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../Utils/ImageAssets.dart';
import '../../../../Utils/flutter_color_themes.dart';
import '../../../../Utils/flutter_font_style.dart';
import '../Home Flow/select_contestent.dart';
import 'my_contests.dart';

class LiveScoreScreen extends StatefulWidget {
  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  late Timer _timer;
  Map<String, dynamic> matchData = {
    "score": "131/2",
    "overs": "4.3",
    "projectedScore": "145",
    "batsmen": [
      {
        "name": "F Zaman",
        "runs": 28,
        "balls": 24,
        "4s": 3,
        "6s": 1,
        "sr": 116.67,
        "image": ImageAssets.player,
        "status": "batting",
      },
      {
        "name": "I Ahmad",
        "runs": 8,
        "balls": 17,
        "4s": 0,
        "6s": 0,
        "sr": 47.06,
        "image": ImageAssets.player,
        "status": "out",
      },
    ],
    "bowlers": [
      {
        "name": "M Musa",
        "overs": 2.3,
        "runs": 22,
        "wickets": 0,
        "economy": 8.8,
        "image": ImageAssets.player,
      },
      {
        "name": "M Musa",
        "overs": 1,
        "runs": 22,
        "wickets": 0,
        "economy": 8.8,
        "image": ImageAssets.player,
      },
      {
        "name": "M Musa",
        "overs": 3,
        "runs": 22,
        "wickets": 0,
        "economy": 8.8,
        "image": ImageAssets.player,
      },
      {
        "name": "M Musa",
        "overs": 4,
        "runs": 22,
        "wickets": 0,
        "economy": 8.8,
        "image": ImageAssets.player,
      },
    ],
    "fallOfWickets": [
      {"score": "2/1", "over": "1.4"},
      {"score": "23/2", "over": "1.6"},
    ],
    "yetToBat": [
      {
        "name": "B Azam",
        "image": ImageAssets.player,
        "status": "batting",
      },
      {
        "name": "M Rizwan",
        "image": ImageAssets.player,
        "status": "batting",
      },
      {
        "name": "S Khan",
        "image": ImageAssets.player,
        "status": "out",
      },
      {
        "name": "H Ali",
        "image": ImageAssets.player,
        "status": "batting",
      },
    ],
  };




  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(Duration(seconds:65), (timer) {
    //   _updateScore();
    // });
  }

  void _updateScore() {
    setState(() {
      matchData["score"] = "${int.parse(matchData["score"].split('/')[0]) + 1}/2";
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.background),
                fit: BoxFit.cover, // Ensure image covers the full area without stretching
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05, // Dynamic left padding
              top: MediaQuery.of(context).size.width * 0.03, // Optional dynamic top padding
              bottom: MediaQuery.of(context).size.width * 0.03, // Optional dynamic bottom padding
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Action for the back button
              },
              child: Image.asset(
                'assets/images/back.png', // Replace with your back button image path
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.04                   ,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 16.0), // Right padding for space
            child: Text(
              'MI vs DEL',
              style: FTextStyle.buttonText,
            ),
          ),
          actions: [
            // Add two images in the actions section
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add the action for the FAQ icon
                      print("FAQ tapped");
                    },
                    child: Image.asset(ImageAssets.faq, height: 30),
                  ),
                  // SizedBox(width: 8),
                  // InkWell(
                  //   onTap: () {
                  //     // Add the action for the Points icon
                  //     print("Points tapped");
                  //   },
                  //   child: Image.asset(ImageAssets.pts, height: 30),
                  // ),
                ],
              ),
            ),

          ],
        ),
        body: Column(
          children: [
            // Live score card with background image
            Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),

              width: double.infinity, // Ensure the container spans the full width
              // height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.background), // Background image
                  fit: BoxFit.cover, // Ensure image covers full area without distortion
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.026, // Adjust the vertical position of the line
                    left: width * 0.1, // Ensure the line spans the full width
                    right: width * 0.1, // Make the line stretch across the container width
                    child: Container(
                      height: height * 0.001, // Start with a small height, this will gradually decrease
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.0, 0.5, 1.0],
                          colors: [
                            Colors.white.withOpacity(0.0), // Transparent at the left
                            Colors.white, // Full opacity at the center
                            Colors.white.withOpacity(0.0), // Transparent at the right
                          ],
                        ),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Score at the top-center
                      Container(
                        width: width * 0.3,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text(
                            "Scores",
                            style: FTextStyle.scores,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      // Team 1 and Team 2 Images and Text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(ImageAssets.team1, width: 40, height: 40),
                                  SizedBox(width: width * 0.01,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${matchData["score"]} ", style: FTextStyle.howToPlayStepHeading),
                                      Text("(${matchData["overs"]})", style: FTextStyle.homeAppbar),
                                    ],
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text('Yet to bat',style: FTextStyle.homeAppbar.copyWith(color: Colors.white.withOpacity(0.6))),
                                  SizedBox(width: width * 0.01,),
                                  Image.asset(ImageAssets.team2, width: 40, height: 40),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4,),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("MI", style: FTextStyle.homeAppbar),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                              // Background color for live text
                                decoration: BoxDecoration(
                                    color: AppColors.liveBG.withOpacity(0.29),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text(
                                  "• LIVE",
                                  style: FTextStyle.live,
                                ),
                              ),

                              // Team 2
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text("DEL", style: FTextStyle.homeAppbar),
                              ),
                            ],
                          )


                        ],
                      ),
                      SizedBox(height: height * 0.01),


                      Text(
                        "Projected Score: ${matchData["projectedScore"]} | @5.0 RPO",
                        style: FTextStyle.tabbar,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Divider(color: Colors.white.withOpacity(0.25),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure space between left and right sides
                        children: [
                          // Left side (Batsman 1 & Batsman 2)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${matchData["batsmen"][0]["name"]}*",
                                    style: FTextStyle.homeAppbar,
                                  ),
                                  SizedBox(width: width * 0.1),
                                  Text(
                                    "${matchData["batsmen"][0]["runs"]} (${matchData["batsmen"][0]["balls"]})",
                                    style: FTextStyle.homeAppbar,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "${matchData["batsmen"][1]["name"]}",
                                    style: FTextStyle.homeAppbar.copyWith(
                                        color: Colors.white.withOpacity(0.6)
                                    ),
                                  ),
                                  SizedBox(width: width * 0.1),
                                  Text(
                                    "${matchData["batsmen"][1]["runs"]} (${matchData["batsmen"][1]["balls"]})",
                                    style: FTextStyle.homeAppbar.copyWith(
                                      color: Colors.white.withOpacity(0.6)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Right side (Bowler Info and 6 Circles for Balls Played)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Bowler info
                              Row(
                                children: [
                                  Text(
                                    "${matchData["bowlers"][0]["name"]}",
                                    style: FTextStyle.homeAppbar,
                                  ),
                                  SizedBox(width: width * 0.12),
                                  Text(
                                    "${matchData["bowlers"][0]["wickets"]} / 22 (${matchData["bowlers"][0]["overs"]})",
                                    style: FTextStyle.homeAppbar,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.005,),

                              // 6 Circles for Balls Played with Runs inside each circle
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(6, (index) {
                                  int ballsPlayed = 4;  // Only 4 balls are played

                                  // Hardcoded runs for the first 4 balls (replace with actual data)
                                  int runs = 0;
                                  if (index == 0) runs = 4;  // 4 runs on the first ball
                                  else if (index == 1) runs = 6;  // 6 runs on the second ball
                                  else if (index == 2) runs = 1;  // 1 run on the third ball
                                  else if (index == 3) runs = 3;  // 3 runs on the fourth ball

                                  // Check if the ball has been played
                                  bool ballPlayed = index < ballsPlayed;

                                  // Determine the background color based on the runs for each ball
                                  Color circleColor;
                                  if (!ballPlayed) {
                                    // Transparent background for unplayed balls
                                    circleColor = Colors.transparent;
                                  } else if (runs == 4 || runs == 6) {
                                    // Green background for 4 or 6
                                    circleColor = AppColors.brand;
                                  } else {
                                    // White background for other runs
                                    circleColor = Colors.white;
                                  }

                                  // Text style logic based on the runs
                                  TextStyle textStyle;
                                  if (runs == 4 || runs == 6) {
                                    textStyle = FTextStyle.homeAppbar;
                                  } else {
                                    textStyle = FTextStyle.runs;
                                  }

                                  // Border style logic: dotted for unplayed balls, solid for played balls
                                  BorderSide borderSide;
                                  if (ballPlayed) {
                                    borderSide = BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    );
                                  } else {
                                    borderSide = BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    );
                                  }

                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: circleColor,
                                      border: Border.all(
                                        color: borderSide.color,
                                        width: borderSide.width,
                                        style: borderSide.style,
                                      ),
                                    ),
                                    child: ballPlayed
                                        ? Center(
                                      child: Text(
                                        runs.toString(),  // Show the runs for played balls
                                        style: textStyle,  // Text style based on the run value
                                      ),
                                    )
                                        : Container(), // Empty if the ball hasn't been played
                                  );
                                }),
                              ),



                            ],
                          )

                        ],
                      )


                    ],
                  ),
                ],
              ),
            ),

            // TabBar below the live score card
            Container(
              color: Colors.white, // Set the background color to white
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.035),
                child: TabBar(
                  tabs: [
                    Tab(text: "My Contests(1)"),
                    Tab(text: "Team(1)"),
                    Tab(text: "Scorecard"),
                    Tab(text: "Stats"),
                  ],
                  labelStyle: FTextStyle.lineupsOut,
                  unselectedLabelStyle: FTextStyle.unselectedLabel,
                  indicatorColor: AppColors.brand,
                  indicatorPadding: EdgeInsets.zero, // Remove or adjust the indicator padding
                  labelPadding: EdgeInsets.symmetric(horizontal: 0), // Adjust label padding
                ),
              )
            ),

            // TabBarView below TabBar
            Expanded(
              child: TabBarView(
                children: [
                  ContestsScreen(),
                  TeamsView(),
                  ScorecardTab(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    matchData: matchData,
                  ),
                  StatsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
