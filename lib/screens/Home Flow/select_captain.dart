import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:fantacy_game/screens/Home%20Flow/team_screen.dart';
import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../widgets/custom_popup.dart';

class SelectTeam extends StatefulWidget {
  const SelectTeam({super.key});

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  // Define sorting state variables
  bool isSortedByPoints = false;
  bool isSortedByCaptain = false;
  bool isSortedByViceCaptain = false;

  bool isArrowVisibleForPoints = false;
  bool isArrowVisibleForCaptain = false;
  bool isArrowVisibleForViceCaptain = false;
  List<Map<String, dynamic>> players = [
    {
      'name': 'Rohit Sharma',
      'points': 50,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 23.1,
      'cPercentage': 30.0, // Captain percentage
      'vcPercentage': 15.0 // Vice-captain percentage
    },
    {
      'name': 'Virat Kohli',
      'points': 60,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 26.1,
      'cPercentage': 35.0,
      'vcPercentage': 12.0
    },
    {
      'name': 'KL Rahul',
      'points': 45,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 20.5,
      'cPercentage': 25.0,
      'vcPercentage': 18.0
    },
    {
      'name': 'Hardik Pandya',
      'points': 70,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 30.2,
      'cPercentage': 40.0,
      'vcPercentage': 20.0
    },
    {
      'name': 'Jasprit Bumrah',
      'points': 55,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 18.8,
      'cPercentage': 28.0,
      'vcPercentage': 10.0
    },
    {
      'name': 'Shikhar Dhawan',
      'points': 48,
      'isCaptain': false,
      'isViceCaptain': false,
      'percentage': 22.4,
      'cPercentage': 32.0,
      'vcPercentage': 17.0
    },
  ];
  // Check if "SAVE" button should be enabled
  bool get isSaveEnabled {
    return players.any((player) => player['isCaptain']) &&
        players.any((player) => player['isViceCaptain']);
  }
  void toggleCaptain(int index) {
    setState(() {
      if (players[index]['isCaptain']) {
        // Unselect captain if already selected
        players[index]['isCaptain'] = false;
      } else {
        // Unselect other captains and select the new one
        for (var player in players) {
          player['isCaptain'] = false;
        }
        players[index]['isCaptain'] = true;

        // Ensure the player is no longer vice-captain
        players[index]['isViceCaptain'] = false;
      }
    });
  }

  void toggleViceCaptain(int index) {
    setState(() {
      if (players[index]['isViceCaptain']) {
        // Unselect vice-captain if already selected
        players[index]['isViceCaptain'] = false;
      } else {
        // Unselect other vice-captains and select the new one
        for (var player in players) {
          player['isViceCaptain'] = false;
        }
        players[index]['isViceCaptain'] = true;

        // Ensure the player is no longer captain
        players[index]['isCaptain'] = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
            children: [
      Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.06,
          right: screenHeight * 0.03,
          left: screenHeight * 0.03,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back.png',
                    width: screenWidth * 0.07,
                    height: screenHeight * 0.04,
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Edit Team', style: FTextStyle.selectteam_name),
                    Text('1h 17m left', style: FTextStyle.selectcontest_time),
                  ],
                ),
                SizedBox(width: screenWidth * 0.49),
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
            SizedBox(height: screenHeight * 0.02),
            Text('Choose your Captain and Vice Captain',
                style: FTextStyle.selectcaptain_text),
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage('assets/images/captain.png'),
                  ),
                  SizedBox(
                    width: screenWidth * 0.026,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rohit Sharma',
                        style: FTextStyle.selectcaptain_captainName,
                      ),
                      Text(
                        '2X (double) points',
                        style: FTextStyle.selectcontest_count,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth * 0.17,
                  ),
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage('assets/images/viceCaptain.png'),
                  ),
                  SizedBox(
                    width: screenWidth * 0.026,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rohit Sharma',
                        style: FTextStyle.selectcaptain_captainName,
                      ),
                      Text(
                        '1.5X points',
                        style: FTextStyle.selectcontest_count,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: screenHeight * 0.25,
          child: Container(
            height: screenHeight * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.04),
                topRight: Radius.circular(screenWidth * 0.04),
              ),
            ),
            child: Column(

              children: [
                // Sorting Header Row
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Type", style: FTextStyle.selectCaptainType),

                      // Points Sorting Section
                      GestureDetector(
                        onTap: () => setState(() {
                          // Reset other arrows
                          isArrowVisibleForCaptain = false;
                          isArrowVisibleForViceCaptain = false;
                          // Toggle visibility and sorting for Points
                          isArrowVisibleForPoints = true;
                          isSortedByPoints = !isSortedByPoints;
                          if (isSortedByPoints) {
                            players.sort((a, b) {
                              var aPoints = a['points'] ?? 0;
                              var bPoints = b['points'] ?? 0;
                              return aPoints.compareTo(bPoints);
                            });
                          } else {
                            players.sort((a, b) {
                              var aPoints = a['points'] ?? 0;
                              var bPoints = b['points'] ?? 0;
                              return bPoints.compareTo(aPoints);
                            });
                          }
                        }),
                        child: Row(
                          children: [
                            Text("Points", style: FTextStyle.checkboxtext),
                            isArrowVisibleForPoints
                                ? Icon(
                              isSortedByPoints
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 16,
                            )
                                : Container(),
                          ],
                        ),
                      ),

                      // Captain Percentage Sorting Section
                      GestureDetector(
                        onTap: () => setState(() {
                          // Reset other arrows
                          isArrowVisibleForPoints = false;
                          isArrowVisibleForViceCaptain = false;
                          // Toggle visibility and sorting for Captain
                          isArrowVisibleForCaptain = true;
                          isSortedByCaptain = !isSortedByCaptain;
                          if (isSortedByCaptain) {
                            players.sort((a, b) {
                              var aCaptainPercentage = a['cPercentage'] ?? 0;
                              var bCaptainPercentage = b['cPercentage'] ?? 0;
                              return aCaptainPercentage.compareTo(bCaptainPercentage);
                            });
                          } else {
                            players.sort((a, b) {
                              var aCaptainPercentage = a['cPercentage'] ?? 0;
                              var bCaptainPercentage = b['cPercentage'] ?? 0;
                              return bCaptainPercentage.compareTo(aCaptainPercentage);
                            });
                          }
                        }),
                        child: Row(
                          children: [
                            Text("% C By", style: FTextStyle.selectCaptainPerce),
                            isArrowVisibleForCaptain
                                ? Icon(
                              isSortedByCaptain
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 16,
                            )
                                : Container(),
                          ],
                        ),
                      ),

                      // Vice-Captain Percentage Sorting Section
                      GestureDetector(
                        onTap: () => setState(() {
                          // Reset other arrows
                          isArrowVisibleForPoints = false;
                          isArrowVisibleForCaptain = false;
                          // Toggle visibility and sorting for Vice-Captain
                          isArrowVisibleForViceCaptain = true;
                          isSortedByViceCaptain = !isSortedByViceCaptain;
                          if (isSortedByViceCaptain) {
                            players.sort((a, b) {
                              var aVcPercentage = a['vcPercentage'] ?? 0;
                              var bVcPercentage = b['vcPercentage'] ?? 0;
                              return aVcPercentage.compareTo(bVcPercentage);
                            });
                          } else {
                            players.sort((a, b) {
                              var aVcPercentage = a['vcPercentage'] ?? 0;
                              var bVcPercentage = b['vcPercentage'] ?? 0;
                              return bVcPercentage.compareTo(aVcPercentage);
                            });
                          }
                        }),
                        child: Row(
                          children: [
                            Text("% VC By", style: FTextStyle.selectCaptainPerce),
                            isArrowVisibleForViceCaptain
                                ? Icon(
                              isSortedByViceCaptain
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 16,
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight*0.014,),
                // Player List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: players.map((player) {
                        int index = players.indexOf(player);
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                // Open the bottom sheet when the player image is tapped
                                showPlayerInfoBottomSheet(context,false);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 22,
                                backgroundImage:
                                    AssetImage('assets/images/rohit.png'),
                              ),
                            ),
                            title: Text(player['name'],style: FTextStyle.selectCaptainplayername,),
                            subtitle: Text('${player['points']} pts',style: FTextStyle.selectCaptainpoints,),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => toggleCaptain(index),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: player['isCaptain']
                                              ? AppColors.brand
                                              : AppColors.login_registerr,
                                          border: Border.all(
                                            color: AppColors.selectCaptain_circle,
                                            width: 1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "C",
                                          style: TextStyle(
                                            color: player['isCaptain']
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Outfit-Regular',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text('${player['percentage']}%',
                                        style: FTextStyle.selectcaptain_perc),
                                  ],
                                ),
                                const SizedBox(width: 40),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => toggleViceCaptain(index),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: player['isViceCaptain']
                                              ? AppColors.brand
                                              : AppColors.login_registerr,
                                          border: Border.all(
                                            color: AppColors.selectCaptain_circle,
                                            width: 1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "VC",
                                          style: TextStyle
                                            (color: player['isViceCaptain']
                                              ? Colors.white
                                              : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Outfit-Regular',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text('${player['percentage']}%',
                                        style: FTextStyle.selectcaptain_perc),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      TeamScreen(teamName: "AJAY007(T1)"),
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
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff312f2f),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(100, 50),
                          ),
                          child: const Text('PREVIEW',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isSaveEnabled
                              ? () => _saveData(context) // Call _saveData function here
                              : null, // Disable button if not enabled
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(100, 50),
                          ),
                          child: const Text(
                            'SAVE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ]
      ),
    ]
        )
    );
  }
  void _saveData(BuildContext rootContext) {
    ScaffoldMessenger.of(rootContext).showSnackBar(
      SnackBar(
        content: const Text(
          'Team created successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.buttoncolor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(rootContext).size.height * 0.9,
          left: 16,
          right: 16,
        ),
      ),
    );

    // Perform additional actions
  }

}
