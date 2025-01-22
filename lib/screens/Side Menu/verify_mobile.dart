import 'package:fantacy_game/screens/Side%20Menu/verify_mobile_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
class VerifyMobile extends StatefulWidget {
  final String title;
  const VerifyMobile({super.key, required this.title});

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileNumberController.addListener(_validateInput);
  }
  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }
  void _validateInput() {
    // Enable the button if the input is exactly 10 digits
    setState(() {
      isButtonEnabled = _mobileNumberController.text.length == 10;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    'Verify Mobile Number',
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
                      Text("Mobile Number", style: FTextStyle.mobilenumber),
                      SizedBox(height: screenHeight * 0.01),
                      TextField(
                        controller: _mobileNumberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          hintStyle: FTextStyle.mobilenumber_textfield,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: AppColors.textfieldborder,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: AppColors.buttoncolor,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text('Send One Time Password (OTP) to this mobile number.',maxLines: 1,style: FTextStyle.mobilenumber,),
                      SizedBox(height: screenHeight * 0.03),
                      // Continue Button
                      ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  VerifyMobileOtp(),
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
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? AppColors.buttoncolor
                              : AppColors.buttoncolor_shade,
                          minimumSize:
                          Size(double.infinity, screenHeight * 0.07),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                        ),
                        child: Text("GET OTP",
                            style: FTextStyle.button_continue),
                      ),
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

