import 'package:fantacy_game/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Utils/ImageAssets.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';

class RummyGameScreen extends StatefulWidget {
  const RummyGameScreen({Key? key}) : super(key: key);

  @override
  _RummyGameScreenState createState() => _RummyGameScreenState();
}

class _RummyGameScreenState extends State<RummyGameScreen> {
  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void dispose() {
    // Reset orientation to allow all modes when leaving this screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImageAssets
                  .rummybgscreen, // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Header Section
          Positioned(
            top: screenHeight * 0.022,
            left: screenWidth * 0.02,
            right: screenWidth * 0.02,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(ImageAssets.profile),
                ),
                SizedBox(width: screenWidth * 0.02),
                Image.asset(
                  ImageAssets.appIcon,
                  width: screenWidth * 0.1,
                ),
                Spacer(),
                IconButton(
                  icon: Image.asset(
                    ImageAssets.bell,
                    height: 22,
                    width: 22,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: screenWidth * 0.01),
                SizedBox(
                  width: screenWidth *
                      0.12, // Adjust the width as per your requirement
                  height: screenHeight *
                      0.08, // Adjust the height as per your requirement
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.buttonBG),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.white)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {},
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.008,
                        ),
                        Image.asset(ImageAssets.wallet, height: 15, width: 15),
                        SizedBox(width: screenWidth * 0.01),
                        Icon(Icons.currency_rupee,
                            color: Colors.white, size: 13),
                        Text('302', style: FTextStyle.homeAppbar),
                        SizedBox(width: screenWidth * 0.01),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: AppColors.brand,
                          child: Icon(Icons.add, color: Colors.white, size: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Middle section with players and central image
          Positioned(
            top: screenHeight * 0.17,
            left: screenWidth * 0.2,
            right: screenWidth * 0.05,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Center image (rummy table)
                Image.asset(
                  ImageAssets.rummytable, // Replace with your central image
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.75,
                ),
                Positioned(
                  bottom: screenHeight * 0.11,
                  left: screenWidth * 0.2,
                  child: buildCardSection(
                    context,
                    imagePath: ImageAssets.card, // Replace with card image path
                    hasSequence: true, // Change based on functionality
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.11,
                  left: screenWidth * 0.28,
                  child: buildCardSection(
                    context,
                    imagePath: ImageAssets.card, // Replace with card image path
                    hasSequence: false, // Change based on functionality
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.11,
                  left: screenWidth * 0.36,
                  child: buildCardSection(
                    context,
                    imagePath: ImageAssets.card, // Replace with card image path
                    hasSequence: true, // Change based on functionality
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.11,
                  left: screenWidth * 0.44,
                  child: buildCardSection(
                    context,
                    imagePath: ImageAssets.card, // Replace with card image path
                    hasSequence: false, // Change based on functionality
                  ),
                ),
                // Player 1 overlapping the left side of the center image
                Positioned(
                  top: screenHeight * 0.2, // Slightly above the center image
                  left: screenWidth *
                      0.01, // Slightly to the left of the center image
                  child: buildPlayerProfile(
                    context,
                    imagePath:
                        ImageAssets.rummyplayer, // Replace with Player 1 image
                    playerName: 'Player 1',
                  ),
                ),
                // Player 2 overlapping the right side of the center image
                Positioned(
                  top: screenHeight * 0.2, // Slightly above the center image
                  right: screenWidth *
                      0.06, // Slightly to the right of the center image
                  child: buildPlayerProfile(
                    context,
                    imagePath:
                        ImageAssets.rummyplayer, // Replace with Player 2 image
                    playerName: 'Player 2',
                  ),
                ),
                Positioned(
                  top: screenHeight * -0.14, // Slightly above the center image
                  right: screenWidth *
                      0.36, // Slightly to the right of the center image
                  child: buildPlayerPoints(
                    context,
                    imagePath:
                        ImageAssets.rummygirl, // Replace with Player 2 image
                    playerpoints: '2',
                  ),
                ),

              ],
            ),
          ),
          // Right-center section
          Positioned(
            right: 0,
            top: screenHeight * 0.2,
            child: Container(
              width: screenWidth * 0.06,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                color: Color(0xff333741).withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.25), // Shadow color with opacity
                    offset: Offset(-50,
                        50), // Horizontal and vertical offset (x and y axes)
                    blurRadius:
                        70, // Blur effect (larger value means more blur)
                    spreadRadius:
                        0, // Spread effect (larger value makes shadow bigger)
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Add your logic for the "Settings" icon tap here
                      showRummyPopUpSettings(context);
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: screenHeight * 0.05,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GestureDetector(
                    onTap: () {
                      // Add your logic for the "Settings" text tap here
                      print('Settings text tapped');
                    },
                    child: Text(
                      'Settings',
                      style: FTextStyle.rummySetting,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  GestureDetector(
                    onTap: () {
                      // Add your logic for the "Info" icon tap here
                      showRummyInfo(context);
                    },
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: screenHeight * 0.05,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GestureDetector(
                    onTap: () {
                      // Add your logic for the "Info" text tap here
                      print('Info text tapped');
                    },
                    child: Text(
                      'Info',
                      style: FTextStyle.rummySetting,
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

  Widget buildPlayerProfile(BuildContext context,
      {required String imagePath, required String playerName}) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CircleAvatar(
          radius: screenHeight * 0.06,
          backgroundImage: AssetImage(imagePath),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffEAA607), // Blue border color
              width: 1.0, // Border width
            ),
            gradient: LinearGradient(
              colors: [Color(0xff2A303C), Color(0xff4C5155)], // Gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(playerName, style: FTextStyle.rummyplayer),
        ),
      ],
    );
  }

  Widget buildPlayerPoints(BuildContext context,
      {required String imagePath, required String playerpoints}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: screenHeight * 0.2,
          width: screenWidth * 0.1,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffEAA607), // Blue border color
              width: 1.0, // Border width
            ),
            gradient: LinearGradient(
              colors: [Color(0xff2A303C), Color(0xff4C5155)], // Gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageAssets.rummycoin,
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Text(playerpoints, style: FTextStyle.rummyplayer),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Image.asset(
                ImageAssets.rummyreload,
                height: 13,
                width: 13,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCardSection(BuildContext context,
      {required String imagePath, required bool hasSequence}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.08;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          child: Image.asset(
            imagePath,
            height: screenHeight * 0.15,
            width: cardWidth,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          width: cardWidth, // Matches the image width
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: hasSequence
                  ? [Color(0xff016326), Color(0xff189552)]
                  : [Color(0xffd14f2c), Color(0xffff7c59)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                hasSequence ? 'Pure Sequence' : 'Invalid',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: FTextStyle.rummycardtext,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
