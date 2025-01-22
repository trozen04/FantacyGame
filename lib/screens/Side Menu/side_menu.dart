import 'package:fantacy_game/screens/HomeScreen/cricket/referEarn.dart';
import 'package:fantacy_game/screens/Policy/about_us.dart';
import 'package:fantacy_game/screens/Policy/legality.dart';
import 'package:fantacy_game/screens/Policy/term_condition.dart';
import 'package:fantacy_game/screens/Side%20Menu/edit_profile.dart';
import 'package:fantacy_game/screens/Side%20Menu/how_to_play.dart';
import 'package:fantacy_game/screens/Side%20Menu/recent_activity.dart';
import 'package:fantacy_game/screens/Side%20Menu/withdraw.dart';
import 'package:fantacy_game/screens/Wallet/add_cash.dart';
import 'package:flutter/material.dart';
import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/custom_popup.dart';
import '../../widgets/widgets.dart';
import '../Profile/myProfile.dart';
import '../auth_flow/Login/login_screen.dart';

class SideMenuScreen extends StatefulWidget {
  @override
  _SideMenuScreenState createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  double offset = 0.0; // This will track the horizontal position of the menu
  bool tapped = false;
  // Example dynamic list containing user profile details
  final List<Map<String, dynamic>> userProfile = [
    {
      'username': 'Umair6274',
      'skillScore': 533,
      'totalReferrals': 3,
      'walletBalance': 302,
      'profileImage': ImageAssets.profile,
    },
    // You can add more users or details here
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Black overlay to tap and close the menu
          GestureDetector(
            onTap: () {
              setState(() {
                tapped = true;
              });
              Navigator.of(context).pop(); // Close the menu when tapping outside
            },
            child: Container(
              color: tapped ? Colors.transparent : Colors.black.withOpacity(0.2), // Apply color only if tapped is false
            ),
          ),

          // Side menu that slides in and out in real-time
          GestureDetector(
            onPanUpdate: (details) {
              // Update the offset as the user swipes left or right
              setState(() {
                // Update the offset only when the swipe is to the right
                if (details.primaryDelta != null && details.primaryDelta! > 0) {
                  offset += details.primaryDelta!;
                  if (offset > width * 0.8) {
                    offset = width * 0.8; // Prevent the menu from going beyond the screen width
                  }
                }
              });
            },
            onPanEnd: (details) {
              // If the swipe is more than 100 pixels, close the menu
              if (offset > width * 0.5) {
                Navigator.of(context).pop(); // Close the menu if swiped more than half
              } else {
                setState(() {
                  offset = 0.0; // Reset the offset if not enough swipe
                });
              }
            },
            child: Stack(
              children: [
                // Side menu that slides in and out
                Transform.translate(
                  offset: Offset(offset, 0),
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // Adjust width for responsiveness
                    child: Drawer(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildHeader(userProfile[0], height, width), // Header section
                            SizedBox(height: height * 0.05),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImageAccounts,
                              label: Constants.myAccountSettings,
                              onTap: () {
                                navigateWithSlideTransition(context, Myprofile());
                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImagePlay,
                              label: Constants.howtoplay,
                              onTap: () {
                                navigateWithSlideTransition(context, HowToPlay());
                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImagePlay,
                              label: Constants.referEarn,
                              onTap: () {
                                navigateWithSlideTransition(context, ReferAndEarnScreen(showAppBar: true));

                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImageAboutUS,
                              label: Constants.aboutUs,
                              onTap: () {
                                navigateWithSlideTransition(context, AboutUs());
                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImageLegal,
                              label: Constants.legality,
                              onTap: () {
                                navigateWithSlideTransition(context, Legality());
                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImageTermsConditions,
                              label: Constants.termsConditions,
                              onTap: () {
                                navigateWithSlideTransition(context, TermCondition());

                              },
                            ),
                            _buildMenuItem(
                              imagePath: ImageAssets.drawerImageHelpSupport,
                              label: Constants.helpSupport,
                              onTap: () {
                                navigateWithSlideTransition(context, RecentActivity());
                              },
                            ),

                            _buildMenuItem(
                              imagePath: ImageAssets.activity,
                              label: 'Activity',
                              onTap: () {
                                navigateWithSlideTransition(context, RecentActivity());
                              },
                            ),

                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0, // Adjust this value to control the distance from the bottom
                  left: 20.0,   // Adjust this value to control the distance from the left
                  right: 20.0,  // Adjust this value to control the distance from the right
                  child: TextButton(
                    onPressed: () {
                      showCustomPopup(context);
                    },
                    style: TextButton.styleFrom(
                      // backgroundColor: Colors.black, // Text color (e.g., black)
                      elevation: 0,

                    ),
                    child: Text('Logout', style: FTextStyle.deleteButtonText,),
                  ),
                )
              ],
            ),
          ),


          // Positioned content to be shown above the side menu
          Positioned(
            top: height * 0.198, // Position at the start of the header
            left: width * 0.045, // Add horizontal padding from left side
            right: width * 0.25, // Add horizontal padding from right side
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.005),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Wallet icon and balance
                  Row(
                    children: [
                      Image.asset(ImageAssets.wallet, height: 18, width: 18, color: Colors.black),
                      SizedBox(width: width * 0.03),
                      Text(
                        "₹ ${userProfile[0]['walletBalance']}", // Displaying the wallet balance
                        style: FTextStyle.sideMenuAmount,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // Action buttons (Withdraw and Add Cash)
                  Row(
                    children: [
                      _buildActionButton(
                        Constants.withdraw,
                         () {
                           navigateWithSlideTransition(context, Withdraw());
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        Constants.addCash,

                               () {
                                 navigateWithSlideTransition(context, AddCashScreen());

                              },


                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Header widget to show user profile and details
  Widget _buildHeader(Map<String, dynamic> user, double height, double width) {
    return Container(
      padding: EdgeInsets.only(
        top: height * 0.07, // Increased padding from above
        left: width * 0.04,
        right: width * 0.04,
        bottom: height * 0.06,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover, // Ensures the image fully covers the background
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40, // Dynamic size based on screen height
                backgroundImage: AssetImage(user['profileImage']), // Dynamic image
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user['username'],
                          style: FTextStyle.sideMenuName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            navigateWithSlideTransition(context, EditProfile());
                          },
                          child: Image.asset(


                              ImageAssets.editIcon, width: 20, height: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    _buildInfoText("${Constants.skillScore} ${user['skillScore']}", AppColors.brand.withOpacity(0.31)),
                    const SizedBox(height: 5),
                    Text(
                      "${Constants.totalRefer} ${user['totalReferrals']}",
                      style: FTextStyle.sideMenuScore,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Info text widget
  Widget _buildInfoText(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: FTextStyle.sideMenuScore,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Action button widget (e.g., Withdraw, Add Cash)
  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: FTextStyle.sideMenuButtons,
        overflow: TextOverflow.ellipsis,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brand,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }

  // Menu item widget for each option in the side menu
  Widget _buildMenuItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Image.asset(
              imagePath,
              height: 24,
              width: 24,
              color: AppColors.brand,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            label,
            style: FTextStyle.sideMenuLabels,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Image.asset(ImageAssets.arrowRight, width: 24,),
          onTap: onTap,
        ),
        Divider(
          color: AppColors.containerBorder,
          thickness: 1,
          indent: 0,
          endIndent: width * 0.1, // Dynamic end indent
        ),
      ],
    );
  }

  void showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
          imagePath: ImageAssets.logout,
          // title: 'LOGOUT',
          descriptions: [
            'Are you sure do you want to logout?',
          ],
          descriptionStyles: [
            FTextStyle.DescText
          ],
          buttonTexts: [
            Constants.cancel,
            Constants.confirm
          ],
          onTapCallbacks: [
                () {
              print('Cancel button tapped');
              Navigator.pop(context);  // Close the dialog on Cancel
            },
                () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false, // This removes all routes
                  );
            },
          ],
          titleStyle: FTextStyle.deleteAccountText
      ),
    );
  }
}
