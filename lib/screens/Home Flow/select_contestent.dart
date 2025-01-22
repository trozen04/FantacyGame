import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:fantacy_game/screens/Home%20Flow/selectTeam.dart';
import 'package:fantacy_game/screens/Home%20Flow/team_screen.dart';
import 'package:flutter/material.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../widgets/bottom_share.dart';
import 'class_of_selectcontenst.dart';

class SelectContestsScreen extends StatefulWidget {
  const SelectContestsScreen({Key? key}) : super(key: key);

  @override
  State<SelectContestsScreen> createState() => _SelectContestsScreenState();
}

class _SelectContestsScreenState extends State<SelectContestsScreen> {
  int _selectedSegmentIndex = 0; // Tracks the selected segment index
  final List<String> segmentTitles = ['Contests', 'My Contests', 'Teams'];
  bool isExpanded =
  false; // Tracks if the sort options are expanded or collapsed

  int myContestsCount = 0; // Tracks the count of My Contests
  List<String> myContests = []; // Example list of contests
  final List<String> teams = ['AJAY007 T1', 'AJAY007 T2'];
  int? selectedOptionIndex; // Initially, no option is selected
  bool isAscending = true; // Sort order (true = ascending, false = descending)

  final List<String> options = ['Entry', 'Sport', 'Prize Pool', '% Winners'];

  @override
  void initState() {
    super.initState();
    myContests = ['Contest 1', 'Contest 2']; // Sample contests
    myContestsCount = myContests.length;
  }

  void addContest(String contest) {
    setState(() {
      myContests.add(contest);
      myContestsCount = myContests.length;
    });
  }

  void removeContest(String contest) {
    setState(() {
      myContests.remove(contest);
      myContestsCount = myContests.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Update Teams segment title with count
    final updatedSegmentTitles = [
      'Contests',
      myContestsCount == 0 ? 'My Contests' : 'My Contests ($myContestsCount)',
      'Teams (${teams.length})',
    ];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_background.png'),  // Path to your background image
              fit: BoxFit.cover,  // Adjust the image to cover the entire space
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MI vs DEL',
                  style: FTextStyle.selectcontest_teamname,
                ),
                Text(
                  '1h 17m left',
                  style: FTextStyle.selectcontest_time,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/pts.png',
                width: screenWidth * 0.07,
                height: screenHeight * 0.035,
              ),
            ),
          ],
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
      ),

      body: Stack(
        children: [
          SizedBox(height: screenHeight,),
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.png'), // Path to your image
                fit: BoxFit.cover, // Ensures the image covers the entire container
              ),
            ),
          ),
          // Top Bar with Back Button and Right Icon

          // Segment Control


          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: updatedSegmentTitles.map((title) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSegmentIndex = updatedSegmentTitles.indexOf(title);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.065,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(screenWidth * 0.01),
                            topRight: Radius.circular(screenWidth * 0.01),
                          ),
                          color: _selectedSegmentIndex == updatedSegmentTitles.indexOf(title)
                              ? AppColors.login_registerr
                              : Colors.transparent,
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: _selectedSegmentIndex == updatedSegmentTitles.indexOf(title)
                                ? AppColors.buttoncolor
                                : AppColors.login_registerr,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Content Container
          Positioned(
            top: screenHeight * 0.06,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(color: AppColors.login_registerr),
              child: Column(
                children: [
                  if (_selectedSegmentIndex == 0) // Only show for Contests
                  // Sort By Row
                  Container(
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sort By:',
                            style: TextStyle(
                              color: Color(0xff7a7a7a),
                              fontSize: 14,
                              fontFamily: 'Outfit-Regular',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: options.asMap().entries.map((entry) {
                              int currentIndex = entry.key;
                              String option = entry.value;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedOptionIndex == currentIndex) {
                                      // Toggle sort order if the same option is clicked
                                      isAscending = !isAscending;
                                    } else {
                                      // Select a new option and default to ascending
                                      selectedOptionIndex = currentIndex;
                                      isAscending = true;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(left: screenWidth * 0.04),
                                  child: Row(
                                    children: [
                                      Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Outfit-Regular',
                                          fontWeight: FontWeight.w400,
                                          color: selectedOptionIndex ==
                                              currentIndex
                                              ? Colors.black
                                              : Color(0xff7a7a7a),
                                        ),
                                      ),
                                      if (selectedOptionIndex == currentIndex)
                                        Icon(
                                          isAscending
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          size: screenWidth * 0.04,
                                          color: Colors.black,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedSegmentIndex,
                      children: [
                        ContestsView(), // This is your ContestsView class
                        MyContestsView(), // This is your MyContestsView class
                        TeamsView(), // This is your TeamsView class
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// this is a teams view section to show the teams.
class TeamsView extends StatelessWidget {
  // List of team names (for demonstration purposes, this can be dynamic)
  final List<String> teams = [
    'AJAY007 T1',
    'AJAY007 T2',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.login_registerr,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight*0.004,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Mega Contests',
                    style: FTextStyle.selectcontest_megacontestent),
              ),
              // Display total number of teams
              Text(
                "Teams (${teams.length})", // Display the number of teams
                style: FTextStyle
                    .selectcontest_teamsname, // Assume a predefined header style
              ),
              // Dynamically create TeamCard for each team
              ...teams.map(
                    (team) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              TeamScreen(teamName: team),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            final tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            final offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: TeamCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      teamName: team,
                      points: 211, // Example points
                      player1Name: "F Zaman",
                      player1Image: 'assets/images/fzaman.png',
                      player2Name: "Virat Kohli",
                      player2Image: 'assets/images/fzaman.png',
                    )),
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
            //vertical: screenHeight * 0.00,
            horizontal: screenWidth * 0.02,
          ),
          width: double.infinity,
          height: screenHeight * 0.215,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/green_background.png'),
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
              bottom: screenWidth * 0.06),
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
                  Row(
                    children: [
                      // Edit Icon with GestureDetector
                      GestureDetector(
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
                          print('Edit icon tapped');
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),

                      // Swap Vert Icon with GestureDetector
                      GestureDetector(
                        onTap: () {
                          // Add the action you want to perform when the Swap Vert icon is tapped
                          print('Swap Vert icon tapped');
                        },
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),

                      // Copy Icon with GestureDetector
                      GestureDetector(
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


                          print('Copy icon tapped');
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),

                      // Share Icon with GestureDetector
                      GestureDetector(
                        onTap: () {
                          showShareBottomSheet(context);
                          print('Share icon tapped');
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                          size: screenWidth * 0.05,
                        ),
                      ),
                    ],
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
                top: -screenWidth * 0.01,
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
          child: FittedBox(
            child: Text(
              playerName,
              style: FTextStyle.selectcontest_playername,
            ),
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

