import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import 'verify_email_otp.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyEmail extends StatefulWidget {
  final String title;
  const VerifyEmail({super.key, required this.title});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final TextEditingController _emailController = TextEditingController();
  bool isButtonEnabled = false;
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
    _emailController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateInput() {
    // Regular expression to validate email format
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Enable the button if the email matches the regex
    setState(() {
      isButtonEnabled = emailRegex.hasMatch(_emailController.text.trim());
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
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Back Button and Header
          Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.06,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    'assets/images/back.png',
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Verify Email Address',
                  style: FTextStyle.privacy_policy_headersection,
                ),
              ],
            ),
          ),

          // Content
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.13,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.09),
                  topRight: Radius.circular(screenWidth * 0.09),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: FTextStyle.mobilenumber),
                      SizedBox(height: screenHeight * 0.01),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')), // Prevent spaces
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter your email address",
                          hintStyle: FTextStyle.mobilenumber_textfield,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            borderSide: BorderSide(
                              color: AppColors.textfieldborder,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
                      Text(
                        'Send One Time Password (OTP) to this email.',
                        maxLines: 1,
                        style: FTextStyle.mobilenumber,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  VerifyEmailOtp(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                final tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? AppColors.buttoncolor
                              : AppColors.buttoncolor_shade,
                          minimumSize: Size(double.infinity, screenHeight * 0.07),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                        ),
                        child: Text("GET OTP", style: FTextStyle.button_continue),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.dividercolor,
                              thickness: screenHeight * 0.001,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                            child: Text("Or Login with", style: FTextStyle.orLoginWith),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.dividercolor,
                              thickness: screenHeight * 0.001,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
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
          ),
        ],
      ),
    );
  }
}
