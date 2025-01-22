
import 'package:fantacy_game/screens/Policy/privacy_policy.dart';
import 'package:fantacy_game/screens/Policy/term_condition.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../Dashboard/common_tabbar.dart';
import '../otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isAbove18 = false; // Checkbox state
  bool isButtonEnabled = false; // Button enabled state
  bool isContentVisible = false; // For fade-in animation

  // Function to validate input and update button state
  void _validateInput() {
    final mobileNumber = _mobileNumberController.text;
    setState(() {
      isButtonEnabled = isAbove18 && mobileNumber.length == 10;
    });
  }
  // Function to launch a URL
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isContentVisible = true;
      });
    });
    _mobileNumberController.addListener(_validateInput);
  }
  void dispose() {
    // Dispose of the TextEditingController to free up resources
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Ensure the keyboard doesn't overflow content
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
      // Foreground Content with Fade-In Animation
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    Text("Login/Register", style: FTextStyle.Login_register),
                    SizedBox(height: screenHeight * 0.01),
                    Text("Let's get you started",
                        style: FTextStyle.Letgetstarted),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

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
                        // Mobile Number Field
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
                        SizedBox(height: screenHeight * 0.02),

                        // Checkbox
                        Column(
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: screenWidth * 0.004,
                                  child: Checkbox(
                                    value: isAbove18,
                                    onChanged: (value) {
                                      setState(() {
                                        isAbove18 = value ?? false;
                                        _validateInput();
                                      });
                                    },
                                    activeColor: AppColors.buttoncolor,
                                    checkColor: AppColors.login_registerr,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.01),
                                    ),
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(
                                      color:Color(0xffd0d0d0), // Set the border color
                                      width: 1.0, // Adjust the width to reduce it
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.005),
                                Expanded(
                                  child: Text(
                                    "I certify that I am above 18 years",
                                    style: FTextStyle.checkboxtext,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                             Center(
                               child: GestureDetector(
                                 onTap: (){
                                   showCircularBottomSheet(context);
                                 },
                                 child: Text(
                                  "Got Invite Code?",
                                  style: FTextStyle.terms_condition,
                                                               ),
                               ),
                             ),

                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Continue Button
                        ElevatedButton(
                          onPressed: isButtonEnabled
                              ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => OtpScreen()),
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
                          child: Text("CONTINUE",
                              style: FTextStyle.button_continue),
                        ),
                        SizedBox(height: screenHeight * 0.02),

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
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          TermCondition(),
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
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                              PrivacyPolicy(),
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
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        // Or Login with Divider
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                                  color: AppColors.dividercolor,
                                  thickness: screenHeight * 0.001,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02),
                              child: Text(
                                "Or Login with",
                                style: FTextStyle.orLoginWith,
                              ),
                            ),
                            Expanded(
                                child: Divider(
                                  color: AppColors.dividercolor,
                                  thickness: screenHeight * 0.001,
                                )),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Social Login Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _launchURL('https://www.facebook.com');
                                print("Facebook Login");
                              },
                              child: Image.asset(
                                'assets/images/facebook_icon.png',
                                height: screenHeight * 0.07,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL('https://www.google.com');
                                print("Google Login");
                              },
                              child: Image.asset(
                                'assets/images/google.png',
                                height: screenHeight * 0.07,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
void showCircularBottomSheet(BuildContext context) {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  String _errorMessage = '';

  final screenWidth = MediaQuery.of(context).size.width;

  // Function to check if the input is alphanumeric and not empty
  bool isValidInput(String input) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input) && input.isNotEmpty;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(screenWidth * 0.2),
      ),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.62, // Increase initial size for the bottom sheet
        maxChildSize: 0.8, // Increase max height of the bottom sheet
        minChildSize: 0.3, // Keep minimum size of the bottom sheet
        expand: false,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(screenWidth * 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter Invite Code",
                  style: FTextStyle.getInviteCode,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')), // Allow only letters and digits
                    LengthLimitingTextInputFormatter(15), // Limit input to 15 characters
                  ],
                  onChanged: (text) {
                    // Enable or disable the button based on input validity
                    _isButtonEnabled = isValidInput(text);
                    _errorMessage = _isButtonEnabled ? '' : 'Please enter a valid invite code';
                    // Rebuild UI to reflect changes
                    (context as Element).markNeedsBuild();
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Code",
                    hintStyle: FTextStyle.mobilenumber_textfield,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.textfieldborder,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.buttoncolor,
                        width: 1.5,
                      ),
                    ),
                    errorText: _errorMessage.isNotEmpty ? _errorMessage : null, // Show error message if present
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                      // If the input is valid, proceed
                      print('Apply button pressed with invite code: ${_controller.text}');
                      // Perform your action here, such as sending the code to the server

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              CommonTabbar(initialIndex: 0),
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
                        : null, // Disable button if the input is not valid
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled ? AppColors.buttoncolor : Colors.grey, // Button color changes based on validity
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Apply",
                      style: FTextStyle.button_continue,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}