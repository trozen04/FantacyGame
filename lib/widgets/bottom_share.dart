import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/ImageAssets.dart';
import '../Utils/flutter_color_themes.dart';
import '../Utils/flutter_font_style.dart'; // For Clipboard functionality

void showShareBottomSheet(BuildContext context) {
  final TextEditingController controller = TextEditingController(); // Controller for TextField

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow resizing with the keyboard
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), // Radius for bottom-left corner
            topLeft: Radius.circular(30), // Radius for bottom-right corner
          ),
          color: Colors.white,
        ),

          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Avoid overlap with keyboard
          child: SingleChildScrollView( // Wrap in a scroll view for smooth scrolling
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Share Title Section with Border Radius
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.containerBG,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30), // Radius for bottom-left corner
                      topLeft: Radius.circular(30), // Radius for bottom-right corner
                    ),
                  ),

                  child: Text(
                    "Share",
                    textAlign: TextAlign.center,
                    style: FTextStyle.bottomShare,
                  ),
                ),

                SizedBox(height: height * 0.03), // Space between the title and icons

                // Social Media Icons Section with Border Radius
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center align icons
                  children: [
                    _buildShareIcon(ImageAssets.twitter, 'twitter', controller, context),
                    _buildShareIcon(ImageAssets.facebook, 'facebook', controller, context),
                    _buildShareIcon(ImageAssets.telegram, 'telegram', controller, context),
                    _buildShareIcon(ImageAssets.whatsapp, 'whatsapp', controller, context),
                  ],
                ),

                // SizedBox(height: height * 0.03), // Space between icons and text field

                // TextField for Message with Border Radius
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.05), // Padding around TextField
                  child: TextField(
                    controller: controller, // Use the controller here
                    enableInteractiveSelection: true,
                    maxLines: 1, // Allow multi-line input
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding inside the text field
                      hintText: "Write a message...",
                      hintStyle: FTextStyle.sideMenuLabels,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // TextField border radius
                        borderSide: BorderSide(color: AppColors.containerBorder, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // TextField focused border radius
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.copy, color: AppColors.heading),
                        onPressed: () {
                          final text = controller.text; // Get text from the controller
                          Clipboard.setData(ClipboardData(text: text)); // Copy it
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Text copied to clipboard')),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      );

    },
  );
}

Widget _buildShareIcon(String imagePath, String platform, TextEditingController controller, BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          print("Tapped on $platform"); // Debugging log
          _shareLink(platform, controller.text, context); // Share when icon is tapped
        },
        child: CircleAvatar(
          child: Image.asset(imagePath, height: 80, width: 80,),
        ),
      ),
    ],
  );
}


void _shareLink(String platform, String message, BuildContext context) async {
  final String appLink = "https://yourapp.com"; // Your app link to share
  print('Sharing on $platform with message: $message');

  // Construct the URL based on the platform
  String url = '';
  print('Constructing the URL...');

  switch (platform) {
    case 'twitter':
      url = 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}&url=$appLink';
      break;
    case 'facebook':
      url = 'https://www.facebook.com/sharer/sharer.php?u=$appLink&quote=${Uri.encodeComponent(message)}';
      break;
    case 'telegram':
      url = 'https://t.me/share/url?url=$appLink&text=${Uri.encodeComponent(message)}';
      break;
    case 'whatsapp':
      String encodedMessage = Uri.encodeComponent('$message $appLink');
      url = 'https://wa.me/?text=$encodedMessage';
      break;
    default:
      url = appLink;
  }

  print('Launching URL: $url'); // Log the constructed URL

  try {
    // Attempt to launch the URL
    await launch(url, forceSafariVC: false, forceWebView: false);
  } catch (e) {
    // If the app is not installed, try to open the App Store or Play Store
    print('Error launching the URL: $e');
    String appStoreLink = '';
    String playStoreLink = ''; // Link for Android (Play Store)

    switch (platform) {
      case 'twitter':
        appStoreLink = 'https://apps.apple.com/us/app/twitter/id333903271'; // iOS Twitter app link
        playStoreLink = 'https://play.google.com/store/apps/details?id=com.twitter.android'; // Android Twitter link
        break;
      case 'facebook':
        appStoreLink = 'https://apps.apple.com/us/app/facebook/id284882215'; // iOS Facebook app link
        playStoreLink = 'https://play.google.com/store/apps/details?id=com.facebook.katana'; // Android Facebook link
        break;
      case 'telegram':
        appStoreLink = 'https://apps.apple.com/us/app/telegram/id686449807'; // iOS Telegram app link
        playStoreLink = 'https://play.google.com/store/apps/details?id=org.telegram.messenger'; // Android Telegram link
        break;
      case 'whatsapp':
        appStoreLink = 'https://apps.apple.com/us/app/whatsapp/id310633997'; // iOS WhatsApp app link
        playStoreLink = 'https://play.google.com/store/apps/details?id=com.whatsapp'; // Android WhatsApp link
        break;
    }

    print('Attempting to open store...'); // Debugging store link attempt

    try {
      // Try launching the App Store URL
      print('Opening App Store link: $appStoreLink');
      await launch(appStoreLink, forceSafariVC: false, forceWebView: false);
    } catch (e) {
      print('App Store link failed: $e');
      try {
        // Try launching the Play Store URL for Android
        print('Opening Play Store link: $playStoreLink');
        await launch(playStoreLink, forceSafariVC: false, forceWebView: false);
      } catch (e) {
        // Show error if neither store link can be opened
        print('Play Store link failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('App not installed and unable to open the store')),
        );
      }
    }
  }
}
