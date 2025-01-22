import 'dart:async';

import 'package:fantacy_game/screens/Dashboard/common_tabbar.dart';
import 'package:fantacy_game/screens/Policy/privacy_policy.dart';
import 'package:fantacy_game/screens/auth_flow/Login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../Policy/term_condition.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isButtonEnabled = false;
  bool isVerifying = false; // Indicates whether "VERIFY" is clicked
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

  void _verifyOtp() {
    if (isButtonEnabled) {
      setState(() {
        isVerifying = true; // Start verifying process
      });
      _startTimer();
      // Navigate to the next screen after OTP verification
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CommonTabbar(initialIndex: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              final tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      });
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
          // Background Image
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // Dismiss keyboard when touched outside
            },
            child: Column(
              children: [
                // Logo and Titles
                SizedBox(height: screenHeight * 0.1),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: screenHeight * 0.035,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text("Verify OTP", style: FTextStyle.Login_register),
                      SizedBox(height: screenHeight * 0.01),
                      Text.rich(
                        TextSpan(
                          text: "OTP sent to +91 9718176274    ",
                          style: FTextStyle.Letgetstarted,
                          children: [
                            TextSpan(
                              text: "Change",
                              style: FTextStyle.change,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoginScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        final tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        final offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Rounded Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.login_registerr,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(screenWidth * 0.2),
                      ),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.08),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // OTP Field
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
                            child: RichText(
                              text: TextSpan(
                                style: FTextStyle.terms_condition.copyWith(
                                  color: _canResend
                                      ? AppColors.buttoncolor
                                      : Colors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: _canResend
                                        ? "Resend OTP"
                                        : "Resend OTP in ",
                                  ),
                                  TextSpan(
                                    text: _canResend
                                        ? ""
                                        : "${_timerSeconds}s", // Display timer if not ready to resend
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight
                                          .w500, // Increase the font size of the timer
                                      color: AppColors
                                          .mobilenumber, // Change the color of the timer (e.g., red)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (_canResend)
                            Center(
                              child: TextButton(
                                onPressed: _canResend ? _resendOtp : null,
                                child: Text(
                                  "Resend",
                                  style:
                                      TextStyle(color: AppColors.buttoncolor),
                                ),
                              ),
                            ),
                          SizedBox(height: screenHeight * 0.02),

                          // Verify Button
                          ElevatedButton(
                            onPressed: isButtonEnabled
                                ? _verifyOtp
                                : null, // Disable button if conditions are not met or during verification
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isVerifying
                                  ? AppColors
                                      .buttoncolor // Green during verification
                                  : (isButtonEnabled
                                      ? AppColors
                                          .buttoncolor // Green when enabled
                                      : AppColors
                                          .buttoncolor_shade), // Shade when disabled
                              minimumSize:
                                  Size(double.infinity, screenHeight * 0.07),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.02),
                              ),
                            ),
                            child: isVerifying
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("VERIFYING",
                                          style: FTextStyle.button_continue),
                                      SizedBox(
                                          width: screenWidth *
                                              0.02), // Space between text and loader
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    ],
                                  )
                                : Text("VERIFY",
                                    style: FTextStyle.button_continue),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Terms and Conditions
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "By continuing, you agree ",
                                style: FTextStyle.checkboxtext,
                                children: [
                                  TextSpan(
                                    text: "terms & condition",
                                    style: FTextStyle.terms_condition,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                TermCondition(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;
                                              final tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              final offsetAnimation =
                                                  animation.drive(tween);
                                              return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child);
                                            },
                                          ),
                                        );
                                      },
                                  ),
                                  TextSpan(
                                      text: " and ",
                                      style: FTextStyle.checkboxtext),
                                  TextSpan(
                                    text: "privacy policy",
                                    style: FTextStyle.terms_condition,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                PrivacyPolicy(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;
                                              final tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              final offsetAnimation =
                                                  animation.drive(tween);
                                              return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child);
                                            },
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Function to handle OTP resend
  void _resendOtp() {
    if (_canResend) {
      _startTimer(); // Restart the timer
      // Add your logic to resend OTP here, for example, an API call
      print("OTP Resent");
    } else {
      print("Cannot resend OTP yet.");
    }
  }
}
