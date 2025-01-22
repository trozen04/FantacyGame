
import 'package:flutter/material.dart';

import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import 'cricket_view.dart';
class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  String selectedTab = "Cricket"; // Default selected tab

  // Function to handle tab selection and update view
  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  // Function to return the content view based on the selected tab
  Widget getContentView() {
    switch (selectedTab) {
      case "Cricket":
        return  CricketView();
      case "Rummy":
        return const Center(
          child: Text(
            "Rummy View",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      case "Daily Contest":
        return const Center(
          child: Text(
            "Daily Contest View",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return const Center(
          child: Text(
            "Unknown View",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
    }
  }
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
            ),
          ),
          Positioned(
            top: screenHeight * 0.06, // Position below the status bar
            left: screenWidth * 0.0, // Slight padding from the left
            right: screenWidth * 0.0, // Slight padding from the right
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Action for the back button
                        },
                        child: Image.asset(
                          'assets/images/back.png', // Replace with your back button image
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03), // Space between the button and text
                      Text(
                          'How To Play',
                          style: FTextStyle.privacy_policy_headersection
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
            SizedBox(
                height: 55, // Fixed height for CustomAppBarPlay
                child: CustomAppBarPlay(
                  selectedTab: selectedTab,
                  onTabSelected: onTabSelected,
                ),
            )
    ]
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.21,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      screenWidth * 0.09), // Adjust the radius as needed
                  topRight: Radius.circular(screenWidth * 0.09),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: getContentView(), // Display the selected tab content
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CustomAppBarPlay extends StatelessWidget implements PreferredSizeWidget {
  final String selectedTab;
  final Function(String) onTabSelected; // Callback for tab selection

  CustomAppBarPlay({
    Key? key,
    required this.selectedTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06,),
      width: double.infinity,
      // This is the white transparent background outside the AppBar
      color: Colors.white.withOpacity(0.2),  // Adjust opacity to match your design
      child: Column(
        children: [
          // AppBar container with height and background
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.tabBG,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton(Constants.cricket, ImageAssets.cricket, context),
                _buildTabButton(Constants.rummy, ImageAssets.rummy, context),
                _buildTabButton(
                    Constants.dailyContest, ImageAssets.dailyContest, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String icon, BuildContext context) {
    bool isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => onTabSelected(label), // Trigger the callback
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.buttoncolor : Colors.transparent, // Background color change
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 15,
              color: isSelected ? Colors.white : AppColors.tabNotSelected,
            ),
            const SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.tabNotSelected,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Outfit-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

