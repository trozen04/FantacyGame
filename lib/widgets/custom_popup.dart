import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/screens/Side%20Menu/withdraw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/flutter_color_themes.dart';
import '../Utils/flutter_font_style.dart';

void showPlayerInfoBottomSheet(BuildContext context,bool showButton) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white, // Ensures the bottom sheet is white
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    isScrollControlled: true,
    builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            // Content Section
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.close, color: AppColors.mobilenumber),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            "Player Info",
                            style: FTextStyle.selectcontest_megacontestent,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          color: AppColors.selectCaptain_containerbg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Points Section
                            Column(
                              children: [
                                Container(
                                  width: screenWidth*0.22,
                                  height: screenHeight*0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30), // Elliptical shape
                                    border: Border.all(
                                        color: Color(0xffD9D9D9).withOpacity(0.38),
                                        width: 8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 21,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('1415', style: FTextStyle.playerInfo),
                                  ),
                                ),
                                SizedBox(height: screenHeight*0.01),
                                Text('Points', style: FTextStyle.selectcontest_playername),
                              ],
                            ),
                            SizedBox(width: screenWidth*0.02),
                            // Cricket Player Section
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/virat.png',
                                  width: screenWidth*0.3,
                                  height: screenHeight*0.07,
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'INDIA',
                                    style: FTextStyle.mycontest_playername,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: screenWidth*0.02),
                            // Credits Section
                            Column(
                              children: [
                                Container(
                                  width: screenWidth*0.22,
                                  height: screenHeight*0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30), // Elliptical shape
                                    border: Border.all(
                                        color: Color(0xffD9D9D9).withOpacity(0.38),
                                        width: 8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 21,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('8', style: FTextStyle.playerInfo),
                                  ),
                                ),
                                SizedBox(height: screenHeight*0.01),
                                Text('Credits', style: FTextStyle.selectcontest_playername),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text('Virat Kohili', style: FTextStyle.selectcontest_megacontestent),
                      SizedBox(height: screenHeight * 0.002),
                      Row(
                        children: [
                          Text('WK,', style: FTextStyle.playerInfoWK),
                          SizedBox(height: screenHeight * 0.001),
                          Text(' Right handed Bat, Off Spin', style: FTextStyle.filter),
                        ],
                      ),
                      Text(
                        'Nationality, INDIA   |   Born Jul 08, 1982',
                        style: FTextStyle.filter,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        padding: const EdgeInsets.all(14), // Padding from all sides
                        decoration: BoxDecoration(
                          color: Color(0xffFAfaff),
                          borderRadius: BorderRadius.circular(10)// Background color

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tour Fantasy Stats",
                              style: FTextStyle.selectcontest_megacontestent,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                statCard("Matches Played", "5"),
                                SizedBox(width: screenWidth*0.01,),
                                statCard("Avg. Points", "43.2"),
                                SizedBox(width: screenWidth*0.01,),
                                statCard("Hero Team", "80%"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        padding: const EdgeInsets.all(14), // Padding from all sides
                        decoration: BoxDecoration(
                          color: Color(0xffFAfaff),
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("In My Team", style: FTextStyle.selectcontest_megacontestent),
                            SizedBox(height: screenHeight * 0.015),
                            Container(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF1F3FF), // Light blue background color
                              ),
                              child: Center(
                                child: Text(
                                  "You’ve not added this player in any team",
                                  style: FTextStyle.filter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      Text("Matchwise Fantasy Stats",
                          style: FTextStyle.selectcontest_megacontestent),
                      SizedBox(height: screenHeight * 0.015),
                      matchStatsCard(),
                    ],
                  ),
                ),
              ),
            ),
            // Button Section: Conditionally displayed
            if (showButton)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Less circular corners
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text(
                      'Add To Team',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}
Widget statCard(String value, String label) {
  return Container(
    padding: EdgeInsets.only(top: 8),
    width: 108,
    height: 67,
    decoration: BoxDecoration(
      color: Color(0xffF1F3FF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Column(
        children: [
          Text(
              value,
              style: FTextStyle.filternew
          ),
          SizedBox(height: 4),
          Text(label, style: FTextStyle.playerInfotext),
        ],
      ),
    ),
  );
}

Widget matchStatsCard() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          // Match Details Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("vs ", style: FTextStyle.filter),
                        Text("ENGLAND", style: FTextStyle.playerInfoteam),
                      ],
                    ),
                    Text(
                      "19 Dec 2024 | INDIA Elected to field first",
                      style: FTextStyle.filter,
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 3,
                      thickness: 1,
                      color: Color(0xffe9e9e9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // First Statistic Section (with swapped text)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Selected By", style: FTextStyle.filter),
                  Text("93.39%", style: FTextStyle.playerInfoteam),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Points", style: FTextStyle.filter),
                  Text("525", style: FTextStyle.playerInfoteam),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Credits", style: FTextStyle.filter),
                  Text("8", style: FTextStyle.playerInfoteam),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 3,
            thickness: 1,
            color: Color(0xffe9e9e9),
          ),
          const SizedBox(height: 10),

          // Second Statistic Section (with swapped text)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Batting Pts", style: FTextStyle.filter),
                  Text("93.39%", style: FTextStyle.playerInfoteam),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Points", style: FTextStyle.filter),
                  Text("525", style: FTextStyle.playerInfoteam),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Other Pts", style: FTextStyle.filter),
                  Text("8", style: FTextStyle.playerInfoteam),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


// rummy customized pop-up screen

void showRummyPopUp(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allows tapping outside to close the dialog
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
       // insetPadding: EdgeInsets.all(screenWidth * 0.1), // Adjust padding to reduce size
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Pop-up container with background image
            Container(
              width: screenWidth * 0.45,  // Adjust width of the container
              height: screenHeight * 0.5,  // Adjust height of the container
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the background
                child: Image.asset(
                  ImageAssets.popupbg, // Your image asset
                  fit: BoxFit.fill,  // Ensure the background image covers the container
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.5,
                ),
              ),
            ),
            // Overlay for text and buttons
            Positioned(
              top: screenHeight * 0.01  ,  // Adjust this value to move the text upwards
              left: 0,
              right: 0,
              child: Text(
                'Play Another Game',
                style: FTextStyle.rummypopuptext,
                textAlign: TextAlign.center,
              ),
            ),

            // Overlay for text and buttons
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight*0.12,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Your last game has ended. Do you\n want to play another Game?',
                      textAlign: TextAlign.center,
                      style: FTextStyle.rummypopuptext
                    ),
                  ),
                  SizedBox(height: screenHeight*0.04,),
                  // Two images in a row below the text
                  Row(
                    children: [
                      SizedBox(width: screenWidth*0.04,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the dialog on tap
                        },
                        child: Image.asset(
                          ImageAssets.exitbutton, // Replace with your first image asset
                          width: screenWidth * 0.2,  // Resize button width
                          height: screenHeight * 0.1, // Resize button height
                          fit: BoxFit.contain,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your logic here for the second button
                          print("Play More button tapped");
                        },
                        child: Image.asset(
                          ImageAssets.playmorebutton, // Replace with your second image asset
                          width: screenWidth * 0.2,  // Resize button width
                          height: screenHeight * 0.1, // Resize button height
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Top-right image on the pop-up (close button)
            Positioned(
              top: -screenHeight * 0.04, // Adjust for positioning
              right: -screenWidth * 0.058,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog on tap
                },
                child: Image.asset(
                  ImageAssets.cancelbutton, // Replace with your top-right image asset
                  width: screenWidth * 0.15,  // Resize close button width
                  height: screenHeight * 0.1, // Resize close button height
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void showRummyPopUpSettings(BuildContext context) {
  bool isVibrationOn = false;  // Default state for Vibration
  bool isSoundOn = false;

  showDialog(
    context: context,
    barrierDismissible: true, // Allows tapping outside to close the dialog
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Pop-up container with background image
            Container(
              width: screenWidth * 0.45,  // Adjust width of the container
              height: screenHeight * 0.5,  // Adjust height of the container
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the background
                child: Image.asset(
                  ImageAssets.popupbg, // Your image asset
                  fit: BoxFit.fill,  // Ensure the background image covers the container
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.5,
                ),
              ),
            ),
            // Overlay for text and buttons
            Positioned(
              top: screenHeight * 0.01,  // Adjust this value to move the text upwards
              left: 0,
              right: 0,
              child: Text(
                'Settings',
                style: FTextStyle.rummypopuptext,
                textAlign: TextAlign.center,
              ),
            ),
            // Overlay for text and buttons
            Positioned.fill(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.12),
                      // Vibration Row with Switch
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.13),
                          Text('Vibration', style: FTextStyle.rummypopuptext),  // Label for Vibration
                          SizedBox(width: screenWidth * 0.05),  // Space between text and switch
                          Switch(
                            value: isVibrationOn,
                            onChanged: (bool value) {
                              setState(() {
                                isVibrationOn = value;
                              });
                            },
                            activeColor: Colors.green,  // Green when ON
                          ),
                        ],
                      ),
                      // Sound Row with Switch
                      Row(

                        children: [
                          SizedBox(width: screenWidth * 0.13),
                          Text('Sound', style: FTextStyle.rummypopuptext),  // Label for Sound
                          SizedBox(width: screenWidth * 0.08),  // Space between text and switch
                          Switch(
                            value: isSoundOn,
                            onChanged: (bool value) {
                              setState(() {
                                isSoundOn = value;
                              });
                            },
                            activeColor: Colors.green,  // Green when ON
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Image with GestureDetector
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          ImageAssets.okaybutton, // Image for the pop-up background
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Top-right image on the pop-up (close button)
            Positioned(
              top: -screenHeight * 0.04, // Adjust for positioning
              right: -screenWidth * 0.058,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog on tap
                },
                child: Image.asset(
                  ImageAssets.cancelbutton, // Replace with your top-right image asset
                  width: screenWidth * 0.15,  // Resize close button width
                  height: screenHeight * 0.1, // Resize close button height
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void showRummyInfo(BuildContext context) {
  bool isVibrationOn = false;  // Default state for Vibration
  bool isSoundOn = false;

  showDialog(
    context: context,
    barrierDismissible: true, // Allows tapping outside to close the dialog
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Pop-up container with background image
            Container(
              width: screenWidth * 0.45,  // Adjust width of the container
              height: screenHeight * 0.5,  // Adjust height of the container
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the background
                child: Image.asset(
                  ImageAssets.popupbg, // Your image asset
                  fit: BoxFit.fill,  // Ensure the background image covers the container
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.5,
                ),
              ),
            ),
            // Overlay for text and buttons
            Positioned(
              top: screenHeight * 0.01,  // Adjust this value to move the text upwards
              left: 0,
              right: 0,
              child: Text(
                'Table Info',
                style: FTextStyle.rummypopuptext,
                textAlign: TextAlign.center,
              ),
            ),
            // Overlay for text and buttons
            Positioned.fill(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.08),
                      // Vibration Row with Switch
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.13),
                          Text('Number Of Deals', style: FTextStyle.rummypopuptext),  // Label for Vibration
                          SizedBox(width: screenWidth * 0.05),
                          Text('2', style: FTextStyle.rummypopuptext),  // Space between text and switch
                        ],
                      ),
                      SizedBox(width: screenWidth*0.02,),
                      // Sound Row with Switch
                      Row(

                        children: [
                          SizedBox(width: screenWidth * 0.13),
                          Text('Number Of Decks', style: FTextStyle.rummypopuptext),  // Label for Sound
                          SizedBox(width: screenWidth * 0.05),
                          Text('1', style: FTextStyle.rummypopuptext),  // Space between text and switch

                        ],
                      ),
                      SizedBox(width: screenWidth*0.02,),
                      Row(

                        children: [
                          SizedBox(width: screenWidth * 0.13),
                          Text('Minimum Players', style: FTextStyle.rummypopuptext),  // Label for Sound
                          SizedBox(width: screenWidth * 0.05),
                          Text('2', style: FTextStyle.rummypopuptext),  // Space between text and switch

                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text('Note: 0% Rake will be applied on the winning amount of the each hand.',style: FTextStyle.cricketerNamewhite,),
                      SizedBox(height: screenHeight * 0.02),
                      // Image with GestureDetector
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          ImageAssets.okaybutton, // Image for the pop-up background
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Top-right image on the pop-up (close button)
            Positioned(
              top: -screenHeight * 0.04, // Adjust for positioning
              right: -screenWidth * 0.058,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog on tap
                },
                child: Image.asset(
                  ImageAssets.cancelbutton, // Replace with your top-right image asset
                  width: screenWidth * 0.15,  // Resize close button width
                  height: screenHeight * 0.1, // Resize close button height
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void showRummyGameEnd(BuildContext context) {
  bool isVibrationOn = false;  // Default state for Vibration
  bool isSoundOn = false;

  showDialog(
    context: context,
    barrierDismissible: true, // Allows tapping outside to close the dialog
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Pop-up container with background image
            Container(
              width: screenWidth * 0.45,  // Adjust width of the container
              height: screenHeight * 0.5,  // Adjust height of the container
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the background
                child: Image.asset(
                  ImageAssets.popupbg, // Your image asset
                  fit: BoxFit.fill,  // Ensure the background image covers the container
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.5,
                ),
              ),
            ),
            // Overlay for text and buttons
            Positioned(
              top: screenHeight * 0.01,  // Adjust this value to move the text upwards
              left: 0,
              right: 0,
              child: Text(
                'Game Ended',
                style: FTextStyle.rummypopuptext,
                textAlign: TextAlign.center,
              ),
            ),
            // Overlay for text and buttons
            Positioned.fill(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.2),
                      Text(
                        'Your last game has ended.',
                        style: FTextStyle.rummypopuptext,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      // Image with GestureDetector
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          ImageAssets.gotolobby, // Image for the pop-up background
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Top-right image on the pop-up (close button)
            Positioned(
              top: -screenHeight * 0.04, // Adjust for positioning
              right: -screenWidth * 0.058,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog on tap
                },
                child: Image.asset(
                  ImageAssets.cancelbutton, // Replace with your top-right image asset
                  width: screenWidth * 0.15,  // Resize close button width
                  height: screenHeight * 0.1, // Resize close button height
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


// Function to show the dialog
void showCustomDialogBank(BuildContext context, String imageUrl, String message) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    barrierDismissible: false, // The dialog won't close if tapping outside
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white, // Dialog background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the dialog box compact
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image at the top center
              Image.asset(
                imageUrl,
                width: screenWidth * 0.37,  // Use a percentage of the screen width for responsive sizing
                height: screenWidth * 0.17,
              ),
              SizedBox(height: screenHeight*0.02), // Space between image and text
              // Text below the image
              Text(
                message,
                textAlign: TextAlign.center,
                style: FTextStyle.privacy_policy
              ),
              SizedBox(height: screenHeight*0.03), // Space between text and button
              // Okay Button
              SizedBox(
                width: screenWidth * 0.6,  // Set your desired width here
                height: screenHeight * 0.06,  // Set your desired height here
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Withdraw(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttoncolor, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Okay",
                    style: FTextStyle.howToPlayStepHeading
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CustomPopup extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final List<String> descriptions;
  final List<TextStyle> descriptionStyles;
  final List<String> buttonTexts;
  final List<void Function()> onTapCallbacks;
  final TextStyle? titleStyle;

  CustomPopup({
    Key? key,
    this.imagePath,
    this.title,
    required this.descriptions,
    required this.descriptionStyles,
    required this.buttonTexts,
    required this.onTapCallbacks,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double imagePaddingVertical = height * 0.01;
    double titlePaddingVertical = height * 0.008;
    double titlePaddingHorizontal = width * 0.1;
    double descriptionPaddingVertical = height * 0.02;
    double descriptionPaddingHorizontal = width * 0.05;
    double buttonPaddingVertical = height * 0.015;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the dialog when tapping outside
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () {},  // Prevent closing when tapping inside the popup
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width  *0.01, vertical: height  *0.02),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imagePath != null)
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.symmetric(vertical: imagePaddingVertical),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (title != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: titlePaddingVertical, horizontal: titlePaddingHorizontal),
                    child: Text(
                      title!,
                      style: titleStyle ?? TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  for (int i = 0; i < descriptions.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: descriptionPaddingVertical, horizontal: descriptionPaddingHorizontal),
                      child: Text(
                        descriptions[i],
                        style: descriptionStyles.length > i
                            ? descriptionStyles[i]
                            : TextStyle(fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (onTapCallbacks.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: buttonPaddingVertical),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(onTapCallbacks.length, (index) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                              child: ElevatedButton(
                                onPressed: onTapCallbacks[index],
                                child: Text(buttonTexts[index], style: FTextStyle.buttonText),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: height * 0.015),
                                  backgroundColor:
                                  (onTapCallbacks.length == 1) // Check if there's only 1 button
                                      ? AppColors.brand  // If only 1 button, use brand color
                                      : (index == 0)
                                      ? AppColors.buttonBG1  // First button in 2-button case, use red
                                      : AppColors.brand,  // Second button in 2-button case, use brand color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


void showCustomBottomSheetTicketNum(BuildContext context, int ticketNumber, int ticketQuantity) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image at the top center
            Center(
              child: Image.asset(
                'assets/images/congratulations_image.png', // Replace with your image asset path
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),

            // Congratulations Text
            Text(
              'Congratulations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // You've got this ticket no text
            Text(
              "You've got this ticket no: $ticketNumber",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Quantity Text
            Text(
              "Ticket Quantity: $ticketQuantity",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Okay Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet on button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: Text(
                'Okay',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
