import 'dart:async';

import 'package:fantacy_game/screens/Side%20Menu/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
class VerifyMobileOtp extends StatefulWidget {
  const VerifyMobileOtp({super.key});

  @override
  State<VerifyMobileOtp> createState() => _VerifyMobileOtpState();
}

class _VerifyMobileOtpState extends State<VerifyMobileOtp> {
  final TextEditingController _otpController = TextEditingController();
  bool isButtonEnabled = false;
  Timer? _timer;
  int _timerSeconds = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(_validateOtpInput);

  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // Function to validate OTP input
  void _validateOtpInput() {
    final otp = _otpController.text;
    setState(() {
      isButtonEnabled = otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);
    });
  }

  // Function to start the timer
  void _startTimer() {
    setState(() {
      _timerSeconds = 30;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }
  void _submitOtp() {
    if (isButtonEnabled) {
      _startTimer(); // Start timer on button click
      print("OTP Submitted: ${_otpController.text}");

      // Pop until the first route, then push the Withdraw class
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Withdraw(),
        ),
      );
    }
  }

  void _resendOtp() {
    if (_canResend) {
      _startTimer(); // Restart timer
      print("OTP Resent");
    }

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

                      Text("OTP", style: FTextStyle.mobilenumber),
                      SizedBox(height: screenHeight * 0.01),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          hintStyle: FTextStyle.mobilenumber_textfield,
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: AppColors.textfieldborder,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.03),
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
                      SizedBox(height: screenHeight * 0.02),

                      // Timer
                      Center(
                        child: GestureDetector(
                          onTap: _canResend ? _resendOtp : null,
                          child: Text(
                            _canResend
                                ? "Resend OTP"
                                : "Resend OTP in $_timerSeconds seconds",
                            style: FTextStyle.terms_condition.copyWith(
                              color: _canResend
                                  ? AppColors.buttoncolor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: isButtonEnabled ? _submitOtp : null,// Disable during verification
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? AppColors.buttoncolor
                              : Colors.grey, // Change color based on state
                          minimumSize: Size(double.infinity, screenHeight * 0.07),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                        ),
                        child: Text("SUBMIT OTP", style: FTextStyle.button_continue),

                      ),

                   ]
                                ),
                ),
            ),
          ),
          )
        ],
      ),
    );
  }
}


