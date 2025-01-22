import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Utils/flutter_font_style.dart';

class TeamsView extends StatelessWidget {
  // List of team names (for demonstration purposes, this can be dynamic)
  final List<String> teams = ['AJAY007 T1', 'AJAY007 T2'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008, horizontal: screenWidth * 0.035),
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.0),
                child: Text(
                    'Mega Contests',
                    style: FTextStyle.selectcontest_megacontestent
                ),
              ),
              // Display total number of teams
              Text(
                "Teams (${teams.length})", // Display the number of teams
                style: FTextStyle.selectcontest_teamsname, // Assume a predefined header style
              ),
              // Dynamically create TeamCard for each team
              ...teams.map((team) =>GestureDetector(
                  onTap: () {
                    //
                  },

                  child:  TeamCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    teamName: team,
                    points: 211, // Example points
                    player1Name: "F Zaman",
                    player1Image: ImageAssets.Fakhar,
                    player2Name: "Virat Kohli",
                    player2Image: ImageAssets.virat,
                  )
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class TeamCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String teamName;
  final int points;
  final String player1Name;
  final String player1Image;
  final String player2Name;
  final String player2Image;

  const TeamCard({
    required this.screenWidth,
    required this.screenHeight,
    required this.teamName,
    required this.points,
    required this.player1Name,
    required this.player1Image,
    required this.player2Name,
    required this.player2Image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(

          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.0035,
          ),
          width: double.infinity,
          height: screenHeight * 0.215,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.greenBG),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            top: screenWidth * 0.03,
            bottom: screenWidth * 0.06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    teamName,
                    style: FTextStyle.selectcontest_teamsname,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Trigger share functionality when share icon is tapped
                      Share.share('Check out my team: $teamName with $points points!');
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Points",
                        style: FTextStyle.selectcontest_teamsname,
                      ),
                      Text(
                        points.toString(),
                        style: FTextStyle.selectcontest_points,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PlayerTile(
                        screenWidth: screenWidth,
                        playerName: player1Name,
                        playerImage: player1Image,
                        isCaptain: true,
                      ),
                      SizedBox(width: screenWidth * 0.09),
                      PlayerTile(
                        screenWidth: screenWidth,
                        playerName: player2Name,
                        playerImage: player2Image,
                        isViceCaptain: true,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoleTile(role: "WK", count: 2),
                  RoleTile(role: "BAT", count: 4),
                  RoleTile(role: "AR", count: 3),
                  RoleTile(role: "BOWL", count: 2),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerTile extends StatelessWidget {
  final double screenWidth;
  final String playerName;
  final String playerImage;
  final bool isCaptain;
  final bool isViceCaptain;

  const PlayerTile({
    required this.screenWidth,
    required this.playerName,
    required this.playerImage,
    this.isCaptain = false,
    this.isViceCaptain = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(playerImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
            ),
            if (isCaptain || isViceCaptain)
              Positioned(
                top: -screenWidth * 0.02,
                right: screenWidth * 0.15,
                child: Container(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  decoration: BoxDecoration(
                    color: isCaptain ? Colors.black : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCaptain ? Colors.white : Colors.black,
                      width: screenWidth * 0.005,
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
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenWidth * 0.014,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Text(
            playerName,
            style: FTextStyle.selectcontest_playername,
          ),
        ),
      ],
    );
  }
}

class RoleTile extends StatelessWidget {
  final String role;
  final int count;

  const RoleTile({
    required this.role,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          role,
          style: FTextStyle.selectcontest_role,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          count.toString(),
          style: FTextStyle.selectcontest_count,
        ),
      ],
    );
  }
  Widget cricketerCard({
    required String imageUrl,
    required String cricketerName,
    required int points,
    bool isCaptain = false, // Default is false
    bool isViceCaptain = false, // Default is false
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cricketer Image
            Container(
              width: 60, // Adjust size as needed
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imageUrl), // Use NetworkImage if online URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // White Circular Container with Cricketer Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40), // Circular shape
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  cricketerName,
                  textAlign: TextAlign.center,
                  style: FTextStyle.cricketerName,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Points Text
            Text(
              "$points Pts",
              style: FTextStyle.selectcontest_teamsname,
            ),
          ],
        ),
        // Captain or Vice-Captain Badge
        if (isCaptain || isViceCaptain)
          Positioned(
            top: -10, // Adjust based on your UI
            right: 0, // Adjust based on your UI
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
