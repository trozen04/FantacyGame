import 'package:flutter/material.dart';

import '../../Utils/flutter_font_style.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
            left: screenWidth * 0.06, // Slight padding from the left
            right: screenWidth * 0.04, // Slight padding from the right
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
                    'About Us',
                    style: FTextStyle.privacy_policy_headersection
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.13,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'About Us',
                          style: FTextStyle.privacy_policy_head
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',style: FTextStyle.privacy_policy),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',style: FTextStyle.privacy_policy)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

