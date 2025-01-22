import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:fantacy_game/screens/Home%20Flow/selectTeam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';

class ContestsView extends StatefulWidget {
  @override
  State<ContestsView> createState() => _ContestsViewState();
}

class _ContestsViewState extends State<ContestsView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mega Contests Title
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02,),
                  child: Text(
                    'Mega Contests',
                    style: FTextStyle.selectcontest_megacontestent,
                  ),
                ),
                SizedBox(height: height*0.02,),
                // Mega Contests List
                ListView.builder(
                  itemCount: 2, // Example number of items for Mega Contests
                  shrinkWrap: true, // Ensure the ListView takes only necessary space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for nested ListView
                  itemBuilder: (context, index) {
                    return _buildContestCard(width, height, "Mega Contest");
                  },
                ),


                // Mini Contests Title
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02,),
                  child: Text(
                    'Mini Contests',
                    style: FTextStyle.selectcontest_megacontestent,
                  ),
                ),
                SizedBox(height: height*0.02,),
                // Mini Contests List
                ListView.builder(
                  itemCount: 2, // Example number of items for Mini Contests
                  shrinkWrap: true, // Ensure the ListView takes only necessary space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for nested ListView
                  itemBuilder: (context, index) {
                    return _buildContestCard(width, height, "Mini Contest");
                  },
                ),
                SizedBox(height: height*0.07,)
              ],

            ),
          ),
          // Fixed Button at the Bottom (not scrollable)
          Positioned(
            bottom: 15,
            left: width*0.3,
            right: width*0.3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FantasyTeamSelection(),
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
                print("Create Team clicked");
              },
              child: Container(
                width: width * 0.4, // Set the button width to 60% of screen width
                height: height * 0.05, // Smaller height for the button
                decoration: BoxDecoration(
                  color: AppColors.buttoncolor,
                  borderRadius: BorderRadius.circular(12), // Slightly smaller rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.white,
                      size: width * 0.05, // Smaller icon size
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Create Team",
                      style: FTextStyle.selectcontest_teamsname,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
    // Method to build each contest card for Mega or Mini contests
  Widget _buildContestCard(double width, double height, String contestType) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FantasyTeamSelection(),
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
      child: Padding(
        padding: EdgeInsets.only(bottom: height * 0.01), // Responsive bottom padding
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.03), // Responsive border radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content with padding
              Padding(
                padding: EdgeInsets.all(width * 0.04), // Responsive padding for inner content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: AppColors.buttoncolor,
                                  size: width * 0.04, // Responsive icon size
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  "$contestType Guaranteed",
                                  style: FTextStyle.selectcontest_guaranted,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.010),
                            Text(
                              "₹ 10 Lakhs",
                              style: FTextStyle.selectcontest_amount,
                            ),
                          ],
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.buttoncolor,
                            borderRadius: BorderRadius.circular(width * 0.02), // Responsive radius
                          ),
                          child: Center(
                            child: Text(
                              "₹49",
                              style: FTextStyle.selectcontest_amount2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    LinearProgressIndicator(
                      value: 0.63, // Example percentage
                      color: AppColors.linearprogressindicatorcolor,
                      backgroundColor: Color(0xffd9d9d9),
                    ),
                    SizedBox(height: height * 0.003),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "15,731 Left",
                          style: FTextStyle.selectcontest_timeleft,
                        ),
                        Text(
                          "34,188 Sports",
                          style: FTextStyle.selectcontest_guaranted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Bottom container with full width and background color
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.selectcontestent_containercolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.03), // Adjust the radius as needed
                    bottomRight: Radius.circular(width * 0.03), // Adjust the radius as needed
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.015,
                  horizontal: width * 0.03,
                ), // Responsive padding
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "1st",
                          style: FTextStyle.selectcontest_guaranted,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "₹45,000",
                          style: FTextStyle.selectcontest_price,
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.1),
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: width * 0.04, // Responsive icon size
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          "63%",
                          style: FTextStyle.selectcontest_guaranted,
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
    );
  }
}


class MyContestsView extends StatefulWidget {
  @override
  State<MyContestsView> createState() => _MyContestsViewState();
}

class _MyContestsViewState extends State<MyContestsView> {
  final List<Map<String, dynamic>> teams = [
    {
      "teamName": "T1",
      "players": [
        {"name": "F Zaman", "image": "assets/images/fzaman.png", "isCaptain": true},
        {"name": "Virat Kohli", "image": "assets/images/fzaman.png", "isViceCaptain": true},
      ],
      "roles": {"WK": 2, "BAT": 4, "AR": 3, "BOWL": 2},
    },
    {
      "teamName": "T2",
      "players": [
        {"name": "MS Dhoni", "image": "assets/images/fzaman.png", "isCaptain": true},
        {"name": "Rohit Sharma", "image": "assets/images/fzaman.png", "isViceCaptain": true},
      ],
      "roles": {"WK": 1, "BAT": 5, "AR": 2, "BOWL": 3},
    },
  ];

  bool isTeamsVisible = false;

  late double width;
  late double height;

  Widget _buildCircle(String text) {
    return Container(
      width: width * 0.1,
      height: height * 0.04,
      decoration: BoxDecoration(
        color: AppColors.mycontenstcontestent_containercolor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: FTextStyle.mytcontest_t1,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.02,),
              child: Text(
                'Mega Contests',
                style: FTextStyle.selectcontest_megacontestent,
              ),
            ),
            SizedBox(height: height*0.02,),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.verified,
                                              color: AppColors.buttoncolor,
                                              size: width * 0.05,
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Text(
                                              "Guaranteed",
                                              style: FTextStyle.selectcontest_guaranted,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.016),
                                        Text(
                                          "₹ 10 Lakhs",
                                          style: FTextStyle.selectcontest_amount,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: width * 0.15,
                                      decoration: BoxDecoration(
                                        color: AppColors.buttoncolor,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "₹49",
                                          style: FTextStyle.selectcontest_amount2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.01),
                                LinearProgressIndicator(
                                  value: 0.63,
                                  color: AppColors.linearprogressindicatorcolor,
                                  backgroundColor: Color(0xffd9d9d9),
                                ),
                                SizedBox(height: height * 0.003),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "15,731 Left",
                                      style: FTextStyle.selectcontest_timeleft,
                                    ),
                                    Text(
                                      "34,188 Spots",
                                      style: FTextStyle.selectcontest_guaranted,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: const Color(0xfff6f6f6),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.03,
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "1st",
                                      style: FTextStyle.selectcontest_guaranted,
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                      "₹45,000",
                                      style: FTextStyle.selectcontest_price,
                                    ),
                                  ],
                                ),
                                SizedBox(width: width * 0.1),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events_outlined,
                                      size: width * 0.04,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      "63%",
                                      style: FTextStyle.selectcontest_guaranted,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.016),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTeamsVisible = !isTeamsVisible;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Joined with ${teams.length} teams',
                                        style: FTextStyle.mytcontest_text,
                                      ),
                                      Icon(
                                        isTeamsVisible
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: width * 0.07,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    children: [
                                      for (int i = 0; i < teams.length; i++)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: i < teams.length - 1 ? width * 0.04 : 0),
                                          child: _buildCircle("T${i + 1}"),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  if (isTeamsVisible)
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.02),
                                      child: Column(
                                        children: [
                                          ...teams
                                              .map((team) => TeamCard(
                                              team: team,
                                              width: width,
                                              height: height))
                                              .toList(),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TeamCard extends StatelessWidget {
  final Map<String, dynamic> team;
  final double width;
  final double height;

  const TeamCard({required this.team, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          image: DecorationImage(
            image: AssetImage('assets/images/green_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "(${team['teamName']})",
                    style: FTextStyle.selectcontest_teamsname,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              FantasyTeamSelection(),
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
                      print("Create Team clicked");

                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: team['players'].map<Widget>((player) {
                  bool isCaptain = player['isCaptain'] ?? false;
                  bool isViceCaptain = player['isViceCaptain'] ?? false;

                  return Row(
                    children: [
                      Image.asset(
                        player['image'],
                        width: width * 0.15,
                        height: height * 0.1,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isCaptain || isViceCaptain)
                            Container(
                              width: width * 0.08,
                              height: height * 0.024,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCaptain ? Colors.black : Colors.white,
                                border: Border.all(
                                  color: isCaptain ? Colors.white : Colors.black,
                                  width: width * 0.005,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  isCaptain ? "C" : "VC",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Outfit-Regular',
                                    color: isCaptain ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: height * 0.02),
                          Text(
                            player['name'],
                            style: FTextStyle.mycontest_playername,
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: team['roles'].entries.map<Widget>((role) {
                  return Row(
                    children: [
                      Text(
                        role.key,
                        style: FTextStyle.selectcontest_role,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        "${role.value}",
                        style: FTextStyle.selectcontest_count,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
