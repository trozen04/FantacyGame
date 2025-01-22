import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Utils/flutter_color_themes.dart';

class CricketView extends StatefulWidget {
  const CricketView({Key? key}) : super(key: key);

  @override
  _CricketViewState createState() => _CricketViewState();
}

class _CricketViewState extends State<CricketView> {
  String selectedTab = "T20"; // Default selected tab

  // Youtube Player controller
  late YoutubePlayerController _controller;
  List<bool> _expanded = [];

  // Function to handle tab selection and update view
  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  // Function to return content based on the selected tab
  Widget getTabContent() {
    switch (selectedTab) {
      case "T20":
        return buildT20Section();
      case "OD":
        return buildT20Section();
      case "Test":
        return buildT20Section();
      case "T10":
        return buildT20Section();
      default:
        return buildT20Section();
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize YouTube Player
    _controller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ', // Replace with your desired video ID
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YouTube Video Player Container
            SizedBox(
              height: screenHeight * 0.23,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                 width: double.infinity,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tab Bar (T20, OD, Test, T10)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton("T20"),
                _buildTabButton("OD"),
                _buildTabButton("Test"),
                _buildTabButton("T10"),
              ],
            ),
            // Displaying the content of the selected tab
            getTabContent(),
          ],
        ),
      ),
    );
  }

  // Tab button widget
  Widget _buildTabButton(String label) {
    bool isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => onTabSelected(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brand : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: AppColors.transactionContainerBorder, width: 1.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.mobilenumber,
            fontWeight: FontWeight.w400,
            fontFamily: 'Outfit-Regular',
            fontSize: 16,
          ),
        ),
      ),
    );
  }

// this is a t20 section

  Widget buildT20Section() {
    final dummyData = [
      {
        "title": "Fantasy Points",
        "image": "assets/images/points1.png",
        "details": [
          {
            "title": "Wickets",
            "subtitle": "(Excluding Run Out)",
            "points": "+25 points"
          },
          {"title": "Runs", "subtitle": "", "points": "+1 point"},
          {"title": "Catch", "subtitle": "", "points": "+2 points"},
        ],
      },
      {
        "title": "Batting",
        "image": "assets/images/points1.png",
        "details": [
          {"title": "Runs", "subtitle": "", "points": "+1 point"},
          {"title": "Fifty", "subtitle": "", "points": "+10 points"},
          {"title": "Century", "subtitle": "", "points": "+20 points"},
        ],
      },
      {
        "title": "Bowling",
        "image": "assets/images/points1.png",
        "details": [
          {
            "title": "Wickets",
            "subtitle": "(Excluding Run Out)",
            "points": "+25 points"
          },
          {"title": "Maiden Over", "subtitle": "", "points": "+12 points"},
        ],
      },
      {
        "title": "Fielding",
        "image": "assets/images/points1.png",
        "details": [
          {"title": "Catch", "subtitle": "", "points": "+8 points"},
          {"title": "Run Out", "subtitle": "(Direct)", "points": "+10 points"},
        ],
      },
      {
        "title": "Additional Points",
        "image": "assets/images/points1.png",
        "details": [
          {"title": "Captain", "subtitle": "Double Points", "points": ""},
          {"title": "Vice-Captain", "subtitle": "1.5x Points", "points": ""},
        ],
      },
      {
        "title": "Other Important Points",
        "image": "assets/images/points1.png",
        "details": [
          {
            "title": "Super Over",
            "subtitle": "Points scored are not counted",
            "points": ""
          },
          {
            "title": "Substitute",
            "subtitle": "No points are awarded",
            "points": ""
          },
        ],
      },
    ];
    // Initialize _expanded list based on the number of items
    if (_expanded.isEmpty) {
      _expanded = List.generate(dummyData.length, (index) => false);
    }

    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final item = dummyData[index];
          return Card(
            color: Colors.white,
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: ExpansionTile(
              leading: Image.asset(
                item["image"] as String,
                width: 25, // Set a fixed width for the image if needed
                height: 25, // Set a fixed height for the image if needed
                fit: BoxFit.cover, // Ensure the image is scaled properly
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image), // Fallback icon if image fails
              ),
              title: Text(
                item["title"] as String,
                style: FTextStyle.Howtoplay,
              ),
              maintainState: true,
              trailing: Icon(
                size:30,
                color: Color(0xffAFAFAF),
                _expanded[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _expanded[index] = expanded; // Update the expansion state
                });
              },
              // Keep expansion state when changing tab
              children: [
                // Using a Column to wrap content
                Column(
                  children: (item["details"] as List).map((detail) {
                    bool isLastItem = (item["details"] as List).last == detail;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detail["title"] as String,
                                style: FTextStyle.Howtoplaysubtitle,
                              ),
                              Text(
                                detail["points"] as String,
                                style: FTextStyle.change,
                              ),
                            ],
                          ),
                        ),
                        // Divider is only applied between details, not at the top or bottom
                        if (!isLastItem)
                          const Divider(
                            height: 3,
                            thickness: 1,
                            color: Color(0xffe9e9e9),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
