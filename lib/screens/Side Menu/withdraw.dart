import 'package:fantacy_game/screens/Side%20Menu/side_menu.dart';
import 'package:fantacy_game/screens/Side%20Menu/verify_bankaccount.dart';
import 'package:fantacy_game/screens/Side%20Menu/verify_email.dart';
import 'package:fantacy_game/screens/Side%20Menu/verify_mobile.dart';
import 'package:fantacy_game/screens/Side%20Menu/verify_pancard.dart';
import 'package:flutter/material.dart';

import '../../Utils/flutter_font_style.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  Map<String, bool> verificationStatuses = {
    'Mobile Number': true,
    'Email Address': true,
    'PAN Card': false,
    'Bank Account': false,
  };
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
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/back.png', // Replace with your back button image
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
              ),
              SizedBox(
                  width:
                      screenWidth * 0.03), // Space between the button and text
              Text('Verify Account',
                  style: FTextStyle.privacy_policy_headersection),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Verified',
                      style: FTextStyle.dailyContestAmount,
                    ),
                    SizedBox(
                      height: screenHeight * 0.0002,
                    ),
                    Text(
                      'Withdraw winning to your bank account instantly!',
                      style: FTextStyle.VerifyAccount,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    buildMobileVerificationCard(
                      imageUrl: 'assets/images/phone.png',
                      title: 'Mobile Number',
                      subtitle: '9876543210',

                    ),
                    SizedBox(
                      height: screenHeight * 0.002,
                    ),
                    buildMobileVerificationCard(
                      imageUrl: 'assets/images/mail.png',
                      title: 'Email Address',
                      subtitle: 'For more relevant fantasy sports experience',

                    ),
                    SizedBox(
                      height: screenHeight * 0.002,
                    ),
                    buildMobileVerificationCard(
                      imageUrl: 'assets/images/Id.png',
                      title: 'PAN Card',
                      subtitle: 'We will need this to verify KYC',

                    ),
                    SizedBox(
                      height: screenHeight * 0.002,
                    ),
                    buildMobileVerificationCard(
                      imageUrl: 'assets/images/banknew.png',
                      title: 'Bank Account',
                      subtitle: 'Enter bank account details for instant transfer',

                    ),
                  ]
              ),
            ),
          ),
        ),
      ],
    ));
  }

  /// Function to create a Mobile Verification Card
  Widget buildMobileVerificationCard({
    required String imageUrl,
    required String title,
    required String subtitle,

  }) {
    final isVerified = verificationStatuses[title] ?? false;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      color: isVerified ? Color(0xffF3FFF6) : Color(0xffE9E9E9),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Small image
           Image.asset(imageUrl,width: 20,height: 28,),
            SizedBox(width: 16), // Gap between image and column
            // Column for text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FTextStyle.checkboxtext
                  ),
                  SizedBox(height: 2), // Small gap
                  Text(
                    subtitle,
                    maxLines: 1,
                    style: FTextStyle.VerifyAccounttext
                  ),
                ],
              ),
            ),
            // Button
            SizedBox(
              width: 55,
              height: 23,
              child: ElevatedButton(
                onPressed: () async {
                  /// Call a different function based on the title
                  switch (title) {
                    case 'Mobile Number':
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              VerifyMobile(title: title),
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
                      break;
                    case 'Email Address':
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              VerifyEmail(title: title),
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
                      break;
                    case 'PAN Card':
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              VerifyPanCard(title: title),
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
                      break;
                    case 'Bank Account':
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              VerifyBankAccount(title: title),
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
                      break;
                    default:
                      break;
                  }

                  // Update the verification status after completion
                  setState(() {
                    verificationStatuses[title] = true; // Assuming verification is successful
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isVerified ? Color(0xff4BBF73).withOpacity(0.2) : Color(0xff818884).withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      isVerified ? 'Verified' : 'Verify',
                      style: isVerified? FTextStyle.VerifyAccountbuttontext:FTextStyle.mytcontest_t1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
