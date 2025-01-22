import 'dart:io';
import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:flutter/material.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import 'package:image_picker/image_picker.dart'; // Make sure to add image_picker dependency
import 'package:palette_generator/palette_generator.dart';

import '../../widgets/custom_popup.dart';
import '../../widgets/match_utils.dart';
import '../Dashboard/common_tabbar.dart';
import '../HomeScreen/cricket/my_matches.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({Key? key}) : super(key: key);

  @override
  State<Myprofile> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<Myprofile> {
  int currentTab = 0;  // Keeps track of the selected tab index
  final List<Map<String, dynamic>> recentlyPlayedMatches = [
    {
      'league': 'Bangladesh T20',
      'date': '13/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'highestPoint': 733.5,
      'teamCreated': 8,
      'heroTeam': 781.5,
    },
    {
      'league': 'India Premier League',
      'date': '13/12/2024',
      'team1': {'name': 'Rangpur Division', 'logo': ImageAssets.team1},
      'team2': {'name': 'Dhaka Metropolis', 'logo': ImageAssets.team2},
      'highestPoint': 653.2,
      'teamCreated': 12,
      'heroTeam': 701.3,
    },
  ];
  XFile? _imageFile;
  Color _avatarBackgroundColor = AppColors.containerBorder; // Default color
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Picking image from gallery or camera
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // You can change this to ImageSource.camera for camera selection
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
  Future<void> _updateAvatarBackgroundColor(String imagePath) async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      FileImage(File(imagePath)),
    );
    setState(() {
      _avatarBackgroundColor = generator.dominantColor?.color ?? Colors.black;
    });
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: Constants.myAccountSettings),
      body: Column(
        children: [
          // Container with Image background for the tabs
          Container(
            width: double.infinity, // Ensure the tabs span the full width
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.background), // Use your local image here
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                _buildTab(0, Constants.myAccountOverview),
                _buildTab(1, Constants.profile),
              ],
            ),
          ),
          // Content based on the selected tab
          Expanded(
            child: currentTab == 0
                ? _buildAccountOverviewTab(height, width)
                : _buildProfileTab(height, width),
          ),
        ],
      ),
    );
  }

  // Custom tab button with selected state logic
  Widget _buildTab(int index, String title) {
    bool isSelected = currentTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTab = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2, // Each tab takes half width
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Text(
          title,
          style: isSelected ? FTextStyle.won : FTextStyle.tabbar,
          overflow: TextOverflow.ellipsis,

        ),
      ),
    );
  }

  Widget _buildAccountOverviewTab(double height, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.033),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeading(context, Constants.cashAccount, false),

          _buildAccountRow(Constants.depositBalance, 576, height),
          _buildAccountRow(Constants.withdrawBalance, 576, height),
          _buildAccountRow(Constants.totalCashBalance, 576, height),
          _buildAccountRow(Constants.taxDeduction, 576, height),
          sectionHeading(context, Constants.bonusAccount, false),

          _buildAccountRow(Constants.pendingBonus, 576, height),
          _buildAccountRow(Constants.releasedBonus, 576, height),
          const Spacer(),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deleteButton.withOpacity(0.1),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                side: BorderSide(
                  width: 1,
                  color: AppColors.deleteButton
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.1)
              ),
              onPressed: () {
                showCustomPopup(context);
              },
              child: Text(Constants.deleteAccount, style: FTextStyle.deleteButtonText,overflow: TextOverflow.ellipsis,),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAccountRow(String title, int value, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align items to start
        crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in the center
        children: [

          Expanded( // This ensures the value text is centered
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$title:',overflow: TextOverflow.ellipsis,
                style: FTextStyle.DescText,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded( // This ensures the value text is centered
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rs $value',
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.accountValue,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildProfileTab(double height, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.033),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.bottomRight, // To place camera icon at the bottom right
                  children: [
                    CircleAvatar(
                      radius: 60, // Radius based on height
                      backgroundColor: _avatarBackgroundColor,
                      child: Padding(
                        padding: EdgeInsets.all(4), // Padding around the image
                        child: ClipOval(
                          child: _imageFile == null
                              ? Image.asset(
                            ImageAssets.profile, // Default profile image
                            fit: BoxFit.cover,
                            width: 126,
                          )
                              : Image.file(
                            File(_imageFile!.path), // Display picked image
                            fit: BoxFit.cover,
                            width: 126,

                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Positioning the camera icon at the bottom-right
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage, // Open image picker when tapped
                        child: CircleAvatar(
                          radius: 18, // Camera icon size based on width
                          backgroundColor: AppColors.cameraBG.withOpacity(0.8), // Camera icon background color
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white, // Icon color
                            size: 19, // Icon size based on width
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'bhoopendra',overflow: TextOverflow.ellipsis,
                      style: FTextStyle.cashAccount
                    ),
                    const Text('Bhoopendra', overflow: TextOverflow.ellipsis,style: FTextStyle.sideMenuLabels,),
                    SizedBox(height: height * 0.002),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),

                      decoration: BoxDecoration(
                        color: AppColors.brand.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        '${Constants.skillScore} 533',overflow: TextOverflow.ellipsis,
                        style: FTextStyle.sideMenuScore.copyWith(
                          color: AppColors.brand
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.002),
                    Row(
                      children: [
                        Text(Constants.playingSince,overflow: TextOverflow.ellipsis, style: FTextStyle.DescText),
                        SizedBox(width: width * 0.02),
                        Text('Dec 2024',overflow: TextOverflow.ellipsis, style: FTextStyle.dailyContestprizePot),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            sectionHeading(context, Constants.careerStats, false),

            Container(
            width: width,
            height: height * 0.18,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.containerBorderWinners, width: 1),
            ),
            child: Stack(
              children: [
                // Horizontal line
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * 0.9,
                    height: 1,
                    color: AppColors.containerBorder,
                  ),
                ),
                // Vertical line
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 1,
                    color: AppColors.containerBorder,
                  ),
                ),
                // Texts in each cell using the reusable function
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.09,
                    child: buildTextCell(Constants.contests, 52),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.09,
                    child: buildTextCell(Constants.matches, 7542),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.09,
                    child: buildTextCell(Constants.series, 13),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.09,
                    child: buildTextCell(Constants.sports, 1),
                  ),
                ),
              ],
            ),
          ),

            sectionHeading(context, Constants.recentlyPlayed, true),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: recentlyPlayedMatches.map((match) {
                  return _buildMatchCard(match, context);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextCell(String firstText, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Text(
          firstText,
          style: FTextStyle.DescText,overflow: TextOverflow.ellipsis,
        ),
        Text(
          value.toString(),overflow: TextOverflow.ellipsis,
          style: FTextStyle.accountValue,
        ),
      ],
    );
  }

  void showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
          imagePath: ImageAssets.delete, // Local image path
          title: Constants.deleteAccount,
          descriptions: [
            Constants.deleteDesc,
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
              print('Confirm button tapped');
              Navigator.pop(context);  // Close the dialog on Confirm
            },
          ],
          titleStyle: FTextStyle.deleteAccountText
      ),
    );
  }
}
Widget sectionHeading(BuildContext context, String title, bool view) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * 0.0, vertical: height * 0.015),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Ensure space between title and button
      children: [
        // Title text on the left
        Text(
          title,
          style: FTextStyle.cashAccount,
          overflow: TextOverflow.ellipsis,
        ),
        // Conditionally show "View All" button if 'view' is true
        if (view)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                  MyMatchesScreen(selectedIndex: 2, viewAll: true,),
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
            child: Text(Constants.viewAll, overflow: TextOverflow.ellipsis,style: FTextStyle.DescText),  // Customize color and style
          ),
      ],
    ),
  );
}



Widget _buildMatchCard(Map<String, dynamic> match, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    width: width * 0.91, // Fixed width (90% of screen width, or any preferred value)
    margin: EdgeInsets.only(
        right: width * 0.02),
    padding: EdgeInsets.symmetric(
        horizontal: width * 0.020, vertical: height * 0.004),
    decoration: BoxDecoration(
      color: AppColors.containerWinners,
      border: Border.all(
        color: AppColors.containerBorderWinners,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              match['league'],
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.leagueWinners,
            ),
            Text(
              formatDate(match['date']),
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.dateWinners,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTeamInfo(
                match['team1'], height, width, true), // Left-aligned
            Text(Constants.vs,
                overflow: TextOverflow.ellipsis,
                style: FTextStyle.dateWinners),
            _buildTeamInfo(
                match['team2'], height, width, false), // Right-aligned
          ],
        ),
        Divider(color: AppColors.containerBorderWinners),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPointsInfo(Constants.highestPoint,
                match['highestPoint'].toString(), height, true),
            _buildPointsInfo(Constants.teamCreated,
                match['teamCreated'].toString(), height, false),
          ],
        ),
        Divider(color: AppColors.containerBorderWinners),

        Text('${Constants.heroTeam} ${match['heroTeam']} ${Constants.pts}', style: FTextStyle.live,),
      ],
    ),
  );
}


Widget _buildPointsInfo(String title, String points, double height, bool left,) {

  return Column(
    children: [
      Text(title, overflow: TextOverflow.ellipsis, style: FTextStyle.filter),
      SizedBox(height: height * 0.001),
      Text(points,
          overflow: TextOverflow.ellipsis, style: FTextStyle.dateWinners),
    ],
  );
}

Widget _buildTeamInfo(
    Map<String, dynamic> team, double height, double width, bool isLeftAligned) {
  // Extract initials from the team name based on spaces
  String initials = team['name']
      .split(' ') // Split the name into words
      .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '') // Get the first letter
      .join(); // Combine into a single string

  return Column(
    crossAxisAlignment:
    isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
    children: [
      // Team name at the top
      Text(
        team['name'],
        overflow: TextOverflow.ellipsis,
        style: FTextStyle.dateWinners,
      ),
      SizedBox(height: height * 0.004),
      // Row containing the image and trimmed initials
      Row(
        mainAxisAlignment:
        isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          // Image comes first for left alignment
          if (isLeftAligned) ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(team['logo']),
            ),
            SizedBox(width: width * 0.02),
            Text(
              initials,
              style: FTextStyle.dateWinners.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
          // Trimmed initials come first for right alignment
          if (!isLeftAligned) ...[
            Text(
              initials,
              style: FTextStyle.dateWinners.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: width * 0.02),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(team['logo']),
            ),
          ],
        ],
      ),
    ],
  );
}







