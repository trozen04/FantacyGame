import 'package:fantacy_game/Utils/constant.dart';
import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';

class TeamScreen extends StatefulWidget {
  final String teamName;
  const TeamScreen({required this.teamName});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.06,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      screenWidth * 0.03), // Adjust the radius as needed
                  topRight: Radius.circular(screenWidth * 0.03),
                ),
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/match_screen_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context); // Pops the current screen from the navigation stack
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Text(widget.teamName,
                            style: FTextStyle.privacy_policy_headersection),
                        SizedBox(
                          width: screenWidth * 0.29,
                        ),
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Image.asset(
                          "assets/images/pts2.png",
                          width: screenWidth * 0.07,
                          height: screenHeight * 0.04,
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.06,
                    ),
                    RichText(
                        text: TextSpan(
                            text: '211  ',
                            style: FTextStyle.Teamscreen_points,
                            children: [
                          TextSpan(
                              text: 'Pts',
                              style: FTextStyle.selectcontest_teamsname)
                        ])),
                    SizedBox(
                      height: screenWidth * 0.002,
                    ),

                    Center(
                        child: Text(
                      'WICKET-KEEPERS',
                      style: FTextStyle.selectcontest_time,
                    )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.006,
                    ),

                    Column(
                      children: [
                        Center(
                            child: Text(
                              'BATTERS',
                              style: FTextStyle.selectcontest_time,
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                        cricketerCardCaptain(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                          isCaptain: true,
                        ),
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.06,
                    ),
                    Column(
                      children: [
                        Center(
                            child: Text(
                              'ALL-ROUNDERS',
                              style: FTextStyle.selectcontest_time,
                            ),
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        cricketerCardCaptain(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                          isViceCaptain: true,
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        Center(
                          child: Text(
                            'BOWLERS',
                            style: FTextStyle.selectcontest_time,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                        cricketerCard(
                          imageUrl: 'assets/images/fzaman.png', // Local image path
                          cricketerName: 'Virat Kohli',
                          points: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth * 0.046,
                    ),

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:  Container(
              padding: EdgeInsets.only(left: screenWidth*0.12),
            width: double.infinity,
            height: screenHeight*0.05,
            // Ensures it spans the entire width
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/teamscreen_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Center horizontally
              children: [
                Icon(Icons.circle, color: Colors.white, size: 15),
                SizedBox(width: screenWidth * 0.02),
                Text('MI', style: FTextStyle.privacy_policy_headersection),
                SizedBox(width: screenWidth * 0.05),
                Icon(Icons.circle, color: Colors.black, size: 15),
                SizedBox(width: screenWidth * 0.02),
                Text('DEL', style: FTextStyle.privacy_policy_headersection),
              ],
            ),
          ),)
        ],
      ),
    );
  }
  Widget cricketerCard({
    required String imageUrl,
    required String cricketerName,
    required int points,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cricketer Image
        Container(
          width: screenWidth*0.19, // Adjust size as needed
          height: screenHeight * 0.06,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                  imageUrl), // Use NetworkImage if it's an online URL
              fit: BoxFit.cover,
            ),
          ),
        ),
        // White Circular Container with Cricketer Name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40), // Circular shape
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cricketerName,
              textAlign: TextAlign.center,
              style: FTextStyle.cricketerName
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.004,
        ),
        // Points Text
        Text(
          "$points Pts",
          style: FTextStyle.selectcontest_teamsname
        ),
      ],
    );
  }
  Widget cricketerCardCaptain({
    required String imageUrl,
    required String cricketerName,
    required int points,
    bool isCaptain = false, // Default is false
    bool isViceCaptain = false, // Default is false
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      clipBehavior: Clip.none, // Allow elements to overflow
      children: [
        // Main Column for cricketer details
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cricketer Image
            Container(
              width: screenWidth*0.19, // Adjust size as needed
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imageUrl), // Use NetworkImage if online URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Name with black background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40), // Circular shape
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  cricketerName,
                  textAlign: TextAlign.center,
                  style: FTextStyle.cricketerNamewhite,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.004,
            ),
            // Points Text
            Text(
              "$points Pts",
              style: FTextStyle.selectcontest_teamsname,
            ),
          ],
        ),
        // Badge for Captain or Vice-Captain
        if (isCaptain || isViceCaptain)
          Positioned(
            top: -2, // Adjust based on the desired position
            right: 55, // Align to the top-right corner of the image
            child: Container(
              width: 24, // Adjust size as needed
              height: 24,
              decoration: BoxDecoration(
                color: isCaptain ? Colors.black : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCaptain ? Colors.white : Colors.black,
                  width: 2, // Border width
                ),
              ),
              child: Center(
                child: Text(
                  isCaptain ? "C" : "VC",
                  style: TextStyle(
                    fontFamily: 'Outfit-Regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isCaptain ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}



