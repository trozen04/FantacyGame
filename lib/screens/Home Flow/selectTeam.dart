import 'dart:async';
import 'package:fantacy_game/screens/Home%20Flow/select_captain.dart';
import 'package:fantacy_game/screens/Home%20Flow/team_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import '../../../Utils/ImageAssets.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/match_utils.dart';
import '../../widgets/custom_popup.dart'; // Import for BackdropFilter

class FantasyTeamSelection extends StatefulWidget {
  @override
  _FantasyTeamSelectionState createState() => _FantasyTeamSelectionState();
}

class _FantasyTeamSelectionState extends State<FantasyTeamSelection> {
    final List<Map<String, dynamic>> players = [
      {'name': 'Rohit Sharma', 'points': 73, 'credits': 9.5, 'type': 'BAT', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'MS Dhoni', 'points': 85, 'credits': 8.5, 'type': 'WK', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Jadeja', 'points': 70, 'credits': 5.0, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Bumrah', 'points': 60, 'credits': 5.0, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Kohli', 'points': 80, 'credits': 5.0, 'type': 'BAT', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'KL Rahul', 'points': 75, 'credits': 9.0, 'type': 'WK', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Pandya', 'points': 72, 'credits': 8.5, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Shami', 'points': 68, 'credits': 8.0, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat},
      // Additional Players
      {'name': 'Hardik Pandya', 'points': 78, 'credits': 9.0, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Shikhar Dhawan', 'points': 85, 'credits': 8.5, 'type': 'BAT', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Rishabh Pant', 'points': 65, 'credits': 7.5, 'type': 'WK', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Kieron Pollard', 'points': 90, 'credits': 9.5, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Jofra Archer', 'points': 60, 'credits': 8.0, 'type': 'BOWL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'David Warner', 'points': 82, 'credits': 9.0, 'type': 'BAT', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Jonny Bairstow', 'points': 76, 'credits': 8.5, 'type': 'WK', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Ravichandran Ashwin', 'points': 74, 'credits': 8.0, 'type': 'ALL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Mitchell Starc', 'points': 68, 'credits': 7.5, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Shreyas Iyer', 'points': 79, 'credits': 8.5, 'type': 'BAT', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Kagiso Rabada', 'points': 80, 'credits': 8.0, 'type': 'BOWL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Suresh Raina', 'points': 75, 'credits': 7.8, 'type': 'ALL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Hardik Pandya', 'points': 85, 'credits': 9.2, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Rishabh Pant', 'points': 78, 'credits': 8.0, 'type': 'WK', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Ravindra Jadeja', 'points': 76, 'credits': 8.3, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Chris Gayle', 'points': 70, 'credits': 7.0, 'type': 'BAT', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Prithvi Shaw', 'points': 73, 'credits': 7.2, 'type': 'BAT', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Shikhar Dhawan', 'points': 77, 'credits': 8.0, 'type': 'BAT', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Jasprit Bumrah', 'points': 83, 'credits': 8.5, 'type': 'BOWL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Yuzvendra Chahal', 'points': 74, 'credits': 7.7, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Kieron Pollard', 'points': 80, 'credits': 9.0, 'type': 'ALL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Shubman Gill', 'points': 75, 'credits': 7.6, 'type': 'BAT', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Jasprit Bumrah', 'points': 83, 'credits': 8.5, 'type': 'BOWL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Yuzvendra Chahal', 'points': 74, 'credits': 7.7, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat},
      {'name': 'Kieron Pollard', 'points': 80, 'credits': 9.0, 'type': 'BOWL', 'team': 'MI', 'image': ImageAssets.virat},
      {'name': 'Shubman Gill', 'points': 75, 'credits': 7.6, 'type': 'BOWL', 'team': 'DEL', 'image': ImageAssets.virat}
    ];

    Map<String, int> selectedPlayerCount = {
      'WK': 0,
      'BAT': 0,
      'ALL': 0,
      'BOWL': 0,
    };
    Map<String, int> teamPlayerCount = {
      'MI': 0, // Mumbai Indians
      'DEL': 0, // Delhi Capitals
      // Add other teams if necessary
    };
    int selectedCount = 0;
    double remainingCredits = 100.0;
    String date = "16/01/2025";  // Manually set date
    String time = "02:45";  // Manually set time
    late Timer _timer;
    late DateTime currentTime;
    late List<bool> _selectedPlayers;
    bool _isWarning = false;
    String _snackbarMessage = '';
    bool _isSnackbarVisible = false;
    DateTime? _lastSnackbarTime;
    OverlayEntry? _overlayEntry;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTime = DateTime.now();
    _selectedPlayers = List.generate(players.length, (_) => false); // Initialize here

    // Timer to update current time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

    void _showSnackbarMessage(String message, bool isWarning) {
      final currentTime = DateTime.now();

      if (_lastSnackbarTime == null || currentTime.difference(_lastSnackbarTime!).inSeconds >= 3) {
        setState(() {
          _snackbarMessage = message;
          _isWarning = isWarning;
          _isSnackbarVisible = true;
        });

        _lastSnackbarTime = currentTime;

        // Create the SnackBar widget
        final snackBar = Material(
          color: Colors.transparent,  // Make the background transparent
          child: Container(
            padding: EdgeInsets.only(top: 50.0, bottom: 15),
            decoration: BoxDecoration(
              color: !_isWarning ? Colors.red : AppColors.brand, // Background color based on warning
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              _snackbarMessage,
              style: FTextStyle.sideMenuScore,
              textAlign: TextAlign.center, // Center the text inside the row
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );

        // Show the custom Snackbar using Overlay
        final overlay = Overlay.of(context);
        _overlayEntry = OverlayEntry(builder: (_) => Positioned(
          top: 0, // Place it at the top of the screen
          left: 0,
          right: 0,
          child: snackBar,
        ));

        overlay.insert(_overlayEntry!);

        // Remove the SnackBar after 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          _overlayEntry?.remove();
          setState(() {
            _snackbarMessage = '';
            _isSnackbarVisible = false;
          });
        });
      }
    }

    Map<String, int> playerLimit = {
      'ALL': 4,
      'WK': 4,
      'BAT': 8,
      'BOWL': 8,
    };


    void togglePlayerSelection(int index) {
      String team = players[index]['team']; // Get the team of the player being selected
      String type = players[index]['type']; // Get the type of the player

      setState(() {
        if (_selectedPlayers[index]) {
          // Deselect player
          _selectedPlayers[index] = false;
          selectedCount--;
          remainingCredits += players[index]['credits'];
          teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) - 1;
          selectedPlayerCount[type] = (selectedPlayerCount[type] ?? 0) - 1;
        } else {
          // Check for minimum and maximum conditions before selecting the player
          if (selectedCount < 11 && remainingCredits >= players[index]['credits']) {
            // If total selected players are 9 and neither 'ALL' nor 'WK' selected, force select one 'ALL' and one 'WK'
            if (selectedCount == 9 && selectedPlayerCount['ALL'] == 0 && selectedPlayerCount['WK'] == 0) {
              print("Went to  9 Total selected players are 9, and neither 'ALL' nor 'WK' selected");
              if (type == 'ALL' && selectedPlayerCount['ALL']! == 0) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['ALL'] = (selectedPlayerCount['ALL'] ?? 0) + 1;
                print("Selecting 'ALL' player, Updated selected count: $selectedCount");
              }
              else if (type == 'WK' && selectedPlayerCount['WK']! == 0) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['WK'] = (selectedPlayerCount['WK'] ?? 0) + 1;

                print("Selecting 'WK' player, Updated selected count: $selectedCount");
              } else {
                print('went to else');
                _showSnackbarMessage("Please select at least 1 WicketKeeper and 1 ALLRounder.", false);

              }
            }
            // If total selected players are 10 and neither 'ALL' nor 'WK' selected, force select either 'ALL' or 'WK'
            else if (selectedCount == 10 && (selectedPlayerCount['ALL'] == 0 || selectedPlayerCount['WK'] == 0)) {

              print("Went to 10 Total selected players are 10, and neither 'ALL' nor 'WK' selected");
              if (type == 'ALL' && selectedPlayerCount['ALL']! < 1) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['ALL'] = (selectedPlayerCount['ALL'] ?? 0) + 1;
                _showSnackbarMessage("Please select at least 1 ALLRounder", false);

                print("Selecting 'ALL' player, Updated selected count: $selectedCount");
              } else if (type == 'WK' && selectedPlayerCount['WK']! < 1) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['WK'] = (selectedPlayerCount['WK'] ?? 0) + 1;
                print("Selecting 'WK' player, Updated selected count: $selectedCount");
                _showSnackbarMessage("Please select at least 1 WicketKeeper", false);

              } else {
                print('else player 10');
                if (selectedPlayerCount['WK']! < 1) {
                  print('if player 10');

                  _showSnackbarMessage("Please select at least 1 WicketKeeper", false);
                }
                  else if (selectedPlayerCount['ALL']! < 1) {
                  print('else if player 10');

                  _showSnackbarMessage("Please select at least 1 ALLRounder", false);

                }


              }
            }
            // Allow normal selection for 'ALL', 'WK', 'BAT', 'BOWL' if conditions are met
            else {
              print('Went to all');
              if (type == 'WK' && selectedPlayerCount['WK']! < 4) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['WK'] = (selectedPlayerCount['WK'] ?? 0) + 1;
                print("Selecting 'WK' player, Updated selected count: $selectedCount");
              } else if (type == 'ALL' && selectedPlayerCount['ALL']! < 4) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['ALL'] = (selectedPlayerCount['ALL'] ?? 0) + 1;
                print("Selecting 'ALL' player, Updated selected count: $selectedCount");
              } else if (type == 'BAT' && selectedPlayerCount['BAT']! < 8) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['BAT'] = (selectedPlayerCount['BAT'] ?? 0) + 1;
                print("Selecting 'BAT' player, Updated selected count: $selectedCount");
              } else if (type == 'BOWL' && selectedPlayerCount['BOWL']! < 8) {
                _selectedPlayers[index] = true;
                selectedCount++;
                remainingCredits -= players[index]['credits'];
                teamPlayerCount[team] = (teamPlayerCount[team] ?? 0) + 1;
                selectedPlayerCount['BOWL'] = (selectedPlayerCount['BOWL'] ?? 0) + 1;
                print("Selecting 'BOWL' player, Updated selected count: $selectedCount");
              } else {
                print('else main');
                if (selectedPlayerCount['WK']! == 4) {
                  _showSnackbarMessage("Maximum 4 wicket keepers can be selected.", false);

                } else if (type == 'ALL' && selectedPlayerCount['ALL']! == 4) {
                  _showSnackbarMessage("Maximum 4 Allrounder can be selected.", false);

                } else if (type == 'BAT' && selectedPlayerCount['BAT']! == 8) {
                  _showSnackbarMessage("Maximum 8 Batsman can be selected.", false);

                } else if (type == 'BOWL' && selectedPlayerCount['BOWL']! == 8) {
                  _showSnackbarMessage("Maximum 8 Bowlers can be selected.", false);

                }
              }
            }
            print("Selected Count: $selectedCount, Remaining Credits: $remainingCredits");
            print("Selected Player Count: $selectedPlayerCount");
          }
        }
      });


    }

    @override
    Widget build(BuildContext context) {
      DateTime combinedMatchTime = parseMatchDateTime(date, time);

      double width = MediaQuery.sizeOf(context).width;
      double height = MediaQuery.sizeOf(context).height;
      if (_isSnackbarVisible)
        CustomSnackbar(message: _snackbarMessage, isWarning: _isWarning);
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Select Players',
              style: FTextStyle.buttonText,
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.background),
                  fit: BoxFit.cover,
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.035),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Credit Limit',
                      style: FTextStyle.selectteam_credit,
                    ),
                    Text(
                      '${remainingCredits.toStringAsFixed(1)}',
                      style: FTextStyle.dailyContestHeading,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.background), // Replace with your image path
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.012, horizontal: width * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                ImageAssets.team1, // Replace with your MI logo path
                                width: 40, // Adjust width as needed
                                height: 40, // Adjust height as needed
                              ),
                              SizedBox(width: 5), // Space between image and text
                              Text(
                                  'MI (${teamPlayerCount['MI']})',
                                  style: FTextStyle.homeAppbar
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.015, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Text(
                              getTimeLeft(combinedMatchTime),
                              style: FTextStyle.timeRemaining,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              // Space between image and text
                              Text(
                                  'DEL (${teamPlayerCount['DEL']})',
                                  style: FTextStyle.homeAppbar
                              ),
                              SizedBox(width: 5),
                              Image.asset(
                                ImageAssets.team2, // Replace with your DEL logo path
                                width: 40, // Adjust width as needed
                                height: 40, // Adjust height as needed
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(11, (index) {
                          return Container(
                            width: 25,
                            height: 14,
                            decoration: BoxDecoration(
                                color: index < selectedCount ? AppColors.brand : Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                          );
                        }),
                      ),
                    ),

                    Material(
                      color: Colors.transparent, // Transparent background for the Material
                      child: Container(
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: Colors.white, // White background for the selected tab
                          ),
                          labelColor: AppColors.brand,
                          unselectedLabelColor: Colors.white,
                          labelStyle: FTextStyle.sideMenuButtons,
                          tabs: [
                            Tab(text: 'WK (${selectedPlayerCount['WK']})'),
                            Tab(text: 'BAT (${selectedPlayerCount['BAT']})'),
                            Tab(text: 'ALL (${selectedPlayerCount['ALL']})'),
                            Tab(text: 'BOWL (${selectedPlayerCount['BOWL']})'),
                          ],
                          indicatorSize: TabBarIndicatorSize.tab, // Use indicator size to fit the selected tab
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.white, // Set the background color to white
                        child: TabBarView(
                          children: ['WK', 'BAT', 'ALL', 'BOWL'].map((type) {
                            final filteredPlayers = players.where((player) => player['type'] == type).toList();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    'Select 1 - ${filteredPlayers.length-1} ${_getFullTypeName(type)}',
                                    style: FTextStyle.teamScreen_heading,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sort by:",
                                        style: FTextStyle.sortBy,
                                        overflow: TextOverflow.ellipsis, // Prevent text overflow
                                        maxLines: 1, // Ensure only one line of text
                                      ),
                                      SizedBox(width: width * 0.31,),
                                      ElevatedButton(
                                        onPressed: () {
                                          players.sort((a, b) => b['points'].compareTo(a['points']));
                                          print("Sort by Points");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.brand,
                                          elevation: 0,
                                          side: BorderSide(color: AppColors.containerBorder, width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Rounded corners with 10 radius
                                          ),
                                          minimumSize: Size(width * 0.1, 30), // Explicitly set height to 40
                                        ),
                                        child: Text(
                                          "Points",
                                          style: FTextStyle.pointsCredits,
                                        ),
                                      ),
                                      SizedBox(width: width * 0.02,),
                                      ElevatedButton(
                                        onPressed: () {
                                          players.sort((a, b) => b['credits'].compareTo(a['credits']));
                                          print("Sort by Credits");
                                        },
                                        style: ElevatedButton.styleFrom(

                                          backgroundColor: AppColors.brand,
                                          elevation: 0,
                                          side: BorderSide(color: AppColors.containerBorder, width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Rounded corners with 10 radius
                                          ),
                                          minimumSize: Size(width * 0.08, 30),
                                        ),
                                        child: Text(
                                          "Credits",
                                          style: FTextStyle.pointsCredits,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),




                                Expanded(
                                  child: ListView.builder(
                                    itemCount: filteredPlayers.length,
                                    itemBuilder: (context, index) {
                                      final playerIndex = players.indexOf(filteredPlayers[index]);
                                      return PlayerTile(
                                        playerName: filteredPlayers[index]['name'],
                                        points: filteredPlayers[index]['points'],
                                        credits: filteredPlayers[index]['credits'],
                                        type: filteredPlayers[index]['type'],
                                        team: filteredPlayers[index]['team'],
                                        image: filteredPlayers[index]['image'],
                                        onTap: () => togglePlayerSelection(playerIndex),
                                        isSelected: _selectedPlayers[playerIndex],
                                        isDisabled: !_selectedPlayers[playerIndex] && (selectedCount == 11 || selectedPlayerCount[filteredPlayers[index]['type']] == playerLimit[filteredPlayers[index]['type']]), // Disable non-selected players when limits are reached
                                      );

                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Positioned(
                bottom: 20,
                left: width * 0.05,
                right: width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: selectedCount == 11 &&
                            selectedPlayerCount['WK']! > 0 &&
                            selectedPlayerCount['BAT']! > 0 &&
                            selectedPlayerCount['ALL']! > 0 &&
                            selectedPlayerCount['BOWL']! > 0
                            ? () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  TeamScreen(teamName: "AJAY007 T1"),
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
                        }
                            : () {
                          if (selectedPlayerCount['WK'] == 0) {
                            _showSnackbarMessage("Please select at least 1 WicketKeeper.", false);
                          }
                          if (selectedPlayerCount['BAT'] == 0) {
                            _showSnackbarMessage("Please select at least 1 Batsman.", false);
                          }
                          if (selectedPlayerCount['ALL'] == 0) {
                            _showSnackbarMessage("Please select at least 1 Allrounder.", false);
                          }
                          if (selectedPlayerCount['BOWL'] == 0) {
                            _showSnackbarMessage("Please select at least 1 Bowler.", false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCount == 11 ? AppColors.previewBG2 : AppColors.previewBG,
                          minimumSize: Size(double.infinity, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'PREVIEW',
                          style: selectedCount == 11 ? FTextStyle.CONTINUE : FTextStyle.preview,
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: selectedCount == 11 &&
                            selectedPlayerCount['WK']! > 0 &&
                            selectedPlayerCount['BAT']! > 0 &&
                            selectedPlayerCount['ALL']! > 0 &&
                            selectedPlayerCount['BOWL']! > 0
                            ? () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  SelectTeam(),
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
                        }
                            : () {
                          // Print messages and show Snackbar if any count is 0
                          if (selectedPlayerCount['WK'] == 0) {
                            print("WicketKeeper (WK) count is 0");
                            _showSnackbarMessage("Please select at least 1 WicketKeeper.", false);
                          }
                          if (selectedPlayerCount['BAT'] == 0) {
                            print("Batsman (BAT) count is 0");
                            _showSnackbarMessage("Please select at least 1 Batsman.", false);
                          }
                          if (selectedPlayerCount['ALL'] == 0) {
                            print("Allrounder (ALL) count is 0");
                            _showSnackbarMessage("Please select at least 1 Allrounder.", false);
                          }
                          if (selectedPlayerCount['BOWL'] == 0) {
                            print("Bowler (BOWL) count is 0");
                            _showSnackbarMessage("Please select at least 1 Bowler.", false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCount==11 ? AppColors.brand : null,
                          minimumSize: Size(double.infinity, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('CONTINUE', style: FTextStyle.CONTINUE),
                      ),
                    ),

                  ],
                ),
              ),
              // Inside Positioned Widget (Preview Button)


              SizedBox(height: height * 0.1,)

            ],
          ),
        ),

      );
    }

    String _getFullTypeName(String type) {
      switch (type) {
        case 'WK':
          return 'Wicket Keeper';
        case 'BAT':
          return 'Batsman';
        case 'ALL':
          return 'All-Rounder';
        case 'BOWL':
          return 'Bowler';
        default:
          return '';
      }
    }

}

class PlayerTile extends StatelessWidget {
  final String playerName;
  final int points;
  final double credits;
  final String type;
  final String image;
  final VoidCallback onTap;
  final bool isSelected;
  final String team;
  final bool isDisabled; // New flag to disable selection for non-selected players

  PlayerTile({
    required this.playerName,
    required this.points,
    required this.credits,
    required this.type,
    required this.image,
    required this.onTap,
    required this.isSelected,
    required this.team,
    required this.isDisabled, // New parameter to control the disable state
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,  // Disable onTap only for non-selected players
      child: Stack(
        children: [
          // The original player tile
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.0),
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.035,
            ),
            decoration: BoxDecoration(
              color: Colors.white, // Always white
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Open the bottom sheet when the player image is tapped
                          showPlayerInfoBottomSheet(context,true);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(image),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playerName,
                            style: FTextStyle.selectCaptainplayername,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: width * 0.01),
                          Row(
                            children: [
                              Image.asset(
                                ImageAssets.flag,
                                height: 14,
                                width: 14,
                              ),
                              SizedBox(width: 2),
                              Text(
                                team,
                                style: FTextStyle.selectCaptainpoints,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$points",
                    style: FTextStyle.winningAmountHeading,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$credits",
                    style: FTextStyle.winningAmountHeading,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: isDisabled ? null : onTap, // Disable the tap for non-selected players
                    child: Image.asset(
                      !isSelected
                          ? ImageAssets.add
                          : ImageAssets.remove,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // White overlay when disabled
          if (isDisabled)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.8), // White overlay with opacity
              ),
            ),
        ],
      ),
    );
  }
}



