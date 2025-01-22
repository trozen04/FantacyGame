import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  final List<Map<String, dynamic>> paymentData = [
    {
      "rupees": "40",
      "dateTime": "24 Dec 2024 - 12:00 PM",
      "platformImage": "assets/images/phonepay.png",
      "isSuccess": true,
    },
    {
      "rupees": "50",
      "dateTime": "25 Dec 2024 - 03:00 PM",
      "platformImage": "assets/images/phonepay.png",
      "isSuccess": false,
    },
    {
      "rupees": "75",
      "dateTime": "26 Dec 2024 - 06:30 PM",
      "platformImage": "assets/images/phonepay.png",
      "isSuccess": true,
    },
  ];

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
                    'Activity',
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
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,),
                      child: Text(
                          'Recent Activity',
                          style: FTextStyle.privacy_policy_head
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: paymentData.length,
                        itemBuilder: (context, index) {
                          final item = paymentData[index];
                          return buildPaymentCard(
                            rupees: item["rupees"],
                            dateTime: item["dateTime"],
                            platformImage: item["platformImage"],
                            isSuccess: item["isSuccess"],
                          );
                        },
                      ),
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
  Widget buildPaymentCard({
    required String rupees,
    required String dateTime,
    required String platformImage,
    required bool isSuccess,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Image.asset(
                'assets/images/activitywallet.png', // Replace with your image path
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(width: screenWidth*0.05),
            // Column for Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with Rupee Symbol, Amount, and Deposit Text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        size: 18,
                        color: Color(0xff727272),
                      ),
                      SizedBox(width: screenWidth*0.002),
                      Text(
                        rupees,
                        style: FTextStyle.mobilenumber
                      ),
                      SizedBox(width: screenWidth*0.01),
                      Text(
                        "Deposit",
                        style: FTextStyle.mobilenumber
                      ),
                      SizedBox(width: screenWidth*0.01),
                      // Small Platform Image
                      Image.asset(
                        platformImage,
                        width: screenWidth*0.04,
                        height: screenHeight*0.04,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.00001),
                  // Row with Date and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        dateTime,
                        style: FTextStyle.privacy_policy
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Rounded Status Button
            Container(
              decoration: BoxDecoration(
                color: isSuccess ? Color(0xff169857).withOpacity(0.1) : Color(0xffFF4F4F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                isSuccess ? "Success" : "Failed",
                style: TextStyle(
                  color: isSuccess ? AppColors.buttoncolor:Color(0xffFF4F4F),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Outfit-Regular'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

