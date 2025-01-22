import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../Utils/ImageAssets.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/bottom_share.dart';

class ReferAndEarnScreen extends StatelessWidget {
  final bool showAppBar; // To control whether the AppBar is visible or not
  const ReferAndEarnScreen({Key? key, this.showAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: showAppBar
          ? CustomAppBar(title: 'Refer & Earn')
          : null, // Only show AppBar if showAppBar is true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: height * 0.1),
                height: height * 0.25,
                width: width * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.referHome), // Add your image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // SizedBox(height: height * 0.0),
              Text(
                Constants.inviteFriendsEarn,
                style: FTextStyle.referHeading,
              ),
              // SizedBox(height: height * 0.02),
              Container(
                width: width * 0.4, // Inner width, slightly smaller than outer
                height:
                height * 0.12, // Inner height, slightly smaller than outer
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40), // Matching curvature
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.referAmountBG), // Replace with your image asset
                    fit: BoxFit.fill, // Adjust fit to cover the container
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      "50",
                      style: FTextStyle.referToEarn,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {
                  showShareBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.03),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.containerBorder, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ImageAssets.whatsapp,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: width * 0.08),
                          Text(
                            Constants.inviteWhatsapp,
                            style: FTextStyle.heading,
                          ),
                        ],
                      ),
                      Icon(Icons.more_vert_outlined)
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard(
                    Constants.inviteFriends,
                    ImageAssets.referInvite,
                    height,
                    width,
                  ),
                  _buildInfoCard(
                    Constants.inviteFriendsPlay,
                    ImageAssets.referFriends,
                    height,
                    width,
                  ),
                  _buildInfoCard(
                    Constants.earnRewards,
                    ImageAssets.referRewards,
                    height,
                    width,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String assetPath, double height, double width) {
    return FittedBox(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            height: height * 0.1,
            width: width * 0.22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assetPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: height * 0.015),
          Text(
            title,
            textAlign: TextAlign.center,
            style: FTextStyle.dailyContestHistoryDate,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
