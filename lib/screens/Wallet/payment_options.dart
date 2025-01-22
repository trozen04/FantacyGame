import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/Utils/constant.dart';
import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/flutter_color_themes.dart';

class PaymentOptionScreen extends StatelessWidget {
  // Function to generate a dynamic deep link
  String generateDeepLink(String app, String payeeUPI, String payeeName, double amount, String note) {
    String baseUrl;

    if (app == 'PhonePe') {
      baseUrl = 'phonepe://pay';
    } else if (app == 'Paytm') {
      baseUrl = 'paytmmp://pay';
    } else if (app == 'GPay') {
      baseUrl = 'upi://pay'; // Google Pay deep link format
    } else {
      return ''; // Return empty for unsupported apps
    }

    String encodedNote = Uri.encodeComponent(note);
    return '$baseUrl?pa=$payeeUPI&pn=$payeeName&am=$amount&cu=INR&tn=$encodedNote';
  }

  // Function to open the app using deep links
  Future<void> _openPaymentApp(String appUrl) async {
    print('Opening deep link: $appUrl');
    final Uri uri = Uri.parse(appUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $appUrl';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: Constants.paymentOptions),
      body: ListView(
        children: [
          _buildPaymentRow(
            Constants.phonePe,
            ImageAssets.phonepe,context
          ),
          _buildPaymentRow(
            Constants.paytm,
            ImageAssets.paytm,
            context
          ),
          _buildPaymentRow(
            Constants.googlePay,
            ImageAssets.gPay,context
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String appName, String imagePath, BuildContext context, ) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.020,
          vertical: height * 0.008),
      margin: EdgeInsets.symmetric(vertical: height * 0.004,horizontal: width * 0.035),
      decoration: BoxDecoration(
        border: Border.all( color: AppColors.textfieldborder,
            width: 1), // Border color and width
        borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(Constants.preferredPayment, style: FTextStyle.preferredPayment,),
              Row(
                children: [
                  Image.asset(
                    imagePath,
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: width * 0.02,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Constants.upi, style: FTextStyle.dailyContestHistoryDate),
                      Text(appName, style: FTextStyle.sideMenuAmount),
                    ],
                  ),
                ],
              )
            ],
          ),
          ElevatedButton(
            onPressed: (){},
            child: Text('${Constants.add} ${Constants.rupee}100', style: FTextStyle.sideMenuScore,),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
        ],
      ),
    );

  }
}
