import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/screens/Buy%20Ticket/buy_ticket.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/match_utils.dart';

class DailyContest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;

    // Data for daily contests
    final List<Map<String, String>> dailyContests = [
      {
        'title': 'Morning Draw',
        'prize': '47,000,000',
        'tickets': '60/80',
        'remaining': '04:56 Hrs',
        'backgroundImage': ImageAssets.containerBG1,
        // Background for this contest
        'centerImage': ImageAssets.lottery
        // Center image for all contests
      },
      {
        'title': 'Afternoon Draw',
        'prize': '30,000,000',
        'tickets': '50/100',
        'remaining': '02:30 Hrs',
        'backgroundImage': ImageAssets.containerBG2,
        // Background for this contest
        'centerImage': ImageAssets.lottery
        // Center image for all contests
      },
      {
        'title': 'Evening Draw',
        'prize': '20,000,000',
        'tickets': '70/90',
        'remaining': '06:15 Hrs',
        'backgroundImage': ImageAssets.containerBG3,
        // Background for this contest
        'centerImage': ImageAssets.lottery
        // Center image for all contests
      },
      {
        'title': 'Night Draw',
        'prize': '15,000,000',
        'tickets': '40/70',
        'remaining': '01:45 Hrs',
        'backgroundImage': ImageAssets.containerBG4,
        // Background for this contest
        'centerImage': ImageAssets.lottery
        // Center image for all contests
      },
    ];

    List<List<Color>> gradients = [
      [Colors.lightBlue.shade100, Colors.green.shade100],
      [Colors.pink.shade100, Colors.orange.shade100],
      [Colors.purple.shade100, Colors.blue.shade100],
    ];

    // Data for latest draws
    final List<Map<String, String>> latestDraws = [
      {
        'title': 'Afternoon Draw',
        'id': 'TU5645',
        'date': '09/12/2024',
        'number': '6258',
        'amount': '50000'
      },
      {
        'title': 'Morning Draw',
        'id': 'TU1234',
        'date': '08/12/2024',
        'number': '7821',
        'amount': '40000'
      },
    ];
    // Data for top winners
    final List<Map<String, dynamic>> topWinners = [
      {'name': 'Anil Kumar', 'amount': '20', 'image': ImageAssets.profile},
      {'name': 'Priya Sharma', 'amount': '15', 'image': ImageAssets.profile},
      {'name': 'Rahul Verma', 'amount': '10', 'image': ImageAssets.profile},
    ];

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.033),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.4,
                color: AppColors.borderBG, // Set the border color to #152031
              ),
              image: DecorationImage(
                image: AssetImage(ImageAssets.background),
                // Replace with your BG image
                fit: BoxFit.cover,
                // alignment: Alignment.center, // Aligns the image to the top center of the screen
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Jackpot Section
                Container(
                  padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.0),
                  height: height * 0.145, // Desired height
                  width: width, // Full width of the parent widget
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Apply rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      ImageAssets.rummyBanner,
                      fit: BoxFit.cover, // Ensure the image covers the entire container without distortion
                       width: width * 0.7,
                      height: height, // Ensure image takes full height of the container
                    ),
                  ),
                ),

                // Daily Contests Section
                sectionHeading(context, Constants.dailyContests),

                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two contests per row
                    crossAxisSpacing: width * 0.04, // Space between columns
                    mainAxisSpacing: height * 0.016, // Reduced space between rows
                    childAspectRatio: 0.85, // Adjust height-width ratio of each item
                  ),
                  itemCount: dailyContests.length,
                  itemBuilder: (context, index) {
                    return contestRow(context, dailyContests[index], index);
                  },
                ),

                // Latest Draw Section
                sectionHeading(context, Constants.latestDraw),
                Container(
                  height: height * 0.18,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: latestDraws.length,
                      itemBuilder: (context, index) {
                        return latestDrawContainer(context, latestDraws[index],
                            gradients[index % gradients.length]);
                      },
                    ),
                  ),
                ),

                // Top Winners Section
                sectionHeading(context, Constants.topWinners),
                Container(
                  height: height * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topWinners.length,
                    itemBuilder: (context, index) {
                      return topWinnerContainer(context, topWinners[index]);
                    },
                  ),
                ),

                staticContent(context),
              ],
            ),
          ),
        )

    );
  }

  Widget sectionHeading(BuildContext context, String title) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Padding(

      padding: EdgeInsets.symmetric(horizontal: width * 0.0, vertical: height * 0.015),
      child: Row(
        children: [
          // Image to the left of the text
          Image.asset(
            ImageAssets.trophy,
            height: 20, // Adjust size based on your needs
            width: 15, // Adjust size based on your needs
          ),
          SizedBox(width: width * 0.02), // Space between image and text
          Text(
            title,
            style: FTextStyle.headingContest,
          ),
        ],
      ),
    );
  }


  Widget contestRow(BuildContext context, Map<String, String> data, int index) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // List of gradients for each index
    final List<LinearGradient> gradients = [
      LinearGradient(colors: [Colors.pink.shade100, Colors.blue.shade100]),
      LinearGradient(colors: [Colors.yellow.shade100, Colors.orange.shade100]),
      LinearGradient(colors: [Colors.green.shade100, Colors.blue.shade50]),
      LinearGradient(colors: [Colors.purple.shade100, Colors.red.shade100]),
    ];


    final List<Color> prizeColors = [
      AppColors.brand, // Color for index 0
      AppColors.prizePot2, // Color for index 1
      AppColors.prizePot3, // Color for index 2
      AppColors.prizePot4, // Color for index 3
    ];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BuyTicket(),
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: gradients[index %
              gradients.length], // Apply gradient based on index
        ),
        child: Stack(
          children: [
            // Centered Image
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                data['centerImage']!,
                width: width * 0.27,
                fit: BoxFit.contain,
                color: Colors.black.withOpacity(0.5), // Apply 50% opacity
                colorBlendMode: BlendMode
                    .dstIn, // Ensures the opacity is applied only to the image
              ),
            ),
            // Text content overlay
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4.0,
                  // Adjust the elevation for more or less shadow
                  borderRadius: BorderRadius.circular(100),
                  // Keep the same border radius as the Container
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      // Semi-transparent black background (50% opacity)
                      borderRadius: BorderRadius.circular(100),
                      // Optional: Add border radius for rounded corners
                      border: Border.all(
                        color: Colors.white, // White border color
                        width: 1, // Border width
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025, vertical: height * 0.001),
                    child: Text(
                      data['title']!,
                      style: FTextStyle.dailyContestHeading.copyWith(
                        shadows: [
                          Shadow(
                            color: Color(0xFF00000040),
                            // Shadow color with 25% opacity
                            offset: Offset(0, 4),
                            // Shadow offset (y: 4, x: 0)
                            blurRadius: 4, // Shadow blur radius
                          ),
                        ],
                      ), // Text color
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                Column(
                  children: [
                    Stack(
                      children:  [
                        Text(
                          Constants.prizePot,
                          style: FTextStyle.prizeText.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            Constants.prizePot,
                            style: FTextStyle.prizeText.copyWith(
                              color: prizeColors[index % prizeColors.length],
                            ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    Stack(
                      children:  [
                        Text(
                          '₹${data['prize']}',
                          style: FTextStyle.prizeText.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            '₹${data['prize']}',
                            style: FTextStyle.prizeText.copyWith(
                              color: prizeColors[index % prizeColors.length],
                            ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02,),
                Container(
                  margin: EdgeInsets.only(left: width * 0.02,right: width * 0.02, top: height * 0.011 ),
                  // Padding around the row content
                  decoration: BoxDecoration(
                    color: AppColors.ticketContainer.withOpacity(0.53),
                    // Semi-transparent black background (20% opacity)
                    borderRadius: BorderRadius.circular(7),
                    // Optional: rounded corners
                    border: Border.all(
                      color: Colors.white, // White border color
                      width: 1, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centers the content horizontally
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align text to the start (left)
                        children: [
                          Text(
                            Constants.ticketsSold,
                            style: FTextStyle.ticketSold,
                            overflow: TextOverflow.ellipsis,

                          ),
                          SizedBox(height: height * 0.004),
                          // Add some spacing between text and data
                          Text(
                            '${data['tickets']}',
                            style: FTextStyle.dailyContestHeading,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02), // Adjust the padding as needed
                        child: Container(
                          height: height * 0.04, // Set the height of the divider
                          child: VerticalDivider(
                            color: Colors.white, // Color of the vertical line
                            thickness: 1, // Thickness of the line
                            width: 1, // Space between the columns and the divider
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align text to the start (left)
                        children: [
                          Text(
                            Constants.remaining,
                            style: FTextStyle.ticketSold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.004),
                          // Add some spacing between text and data
                          Text(
                            '${data['remaining']}',
                            style: FTextStyle.dailyContestHeading,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget latestDrawContainer(BuildContext context, Map<String, String> data,
      List<Color> gradientColors) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BuyTicket(),
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
      child: Container(
        // width: width * 0.8, // Adjust for responsive width
        margin: EdgeInsets.only(right: width * 0.025),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.008),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors, // Custom gradient for each container
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 4), // Shadow position
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 1, // Adjust position as per your layout
              right: 0,
              child: SizedBox(
                height: height * 0.1, // Set your desired height
                width: width * 0.35, // Set your desired width
                child: Image.asset(
                  ImageAssets.lottery,
                  fit: BoxFit.contain, // Ensure image is properly scaled
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                Material(
                  elevation: 4.0,
                  // Adjust the elevation for more or less shadow
                  borderRadius: BorderRadius.circular(100),
                  // Keep the same border radius as the Container
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      // Semi-transparent black background (50% opacity)
                      borderRadius: BorderRadius.circular(100),
                      // Optional: Add border radius for rounded corners
                      border: Border.all(
                        color: Colors.white, // White border color
                        width: 1, // Border width
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025, vertical: height * 0.001),
                    child: Text(
                      data['title']!,
                      style: FTextStyle.dailyContestHeading.copyWith(
                        shadows: [
                          Shadow(
                            color: Color(0xFF00000040),
                            // Shadow color with 25% opacity
                            offset: Offset(0, 4),
                            // Shadow offset (y: 4, x: 0)
                            blurRadius: 4, // Shadow blur radius
                          ),
                        ],
                      ), // Text color
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.012),

                // ID and Date
                Text(
                  data['id']!,
                  style: FTextStyle.latestDrawHeadings,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data['date'] != null ? formatDate(data['date']!) : 'Date not available',
                  style: FTextStyle.latestDrawHeadings,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.012),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Winning Number Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.winningNumber,
                          style: FTextStyle.latestDrawHeadings,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height * 0.004),
                        Row(
                          children: [
                            for (int i = 0; i < data['number']!.length; i++)
                              Container(
                                width: width * 0.07,
                                height: height * 0.035,
                                margin: EdgeInsets.symmetric(horizontal: width *
                                    0.005),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                    data['number']![i],
                                    style: FTextStyle.digital,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        )

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   Constants.winningAmount,
                        //   style: FTextStyle.winningAmountHeading.copyWith(
                        //
                        //   ),
                        // ),
                        Stack(
                          children:  [
                            Text(
                              Constants.winningAmount,
                              style: FTextStyle.winningAmountHeading.copyWith(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                Constants.winningAmount,
                                style: FTextStyle.winningAmountHeading,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.004),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '₹${NumberFormat('#,##0').format(double.tryParse(data['amount'] ?? '0') ?? 0)}',
                              overflow: TextOverflow.ellipsis,
                              style: FTextStyle.winningAmount.copyWith(
                                shadows: [
                                  // Shadows for the bold shadow effect
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(2, 2),
                                    // Larger offset for more boldness
                                    blurRadius: 0, // No blur
                                  ),
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(-2, 2),
                                    // Larger offset for more boldness
                                    blurRadius: 0, // No blur
                                  ),
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(2, -2),
                                    // Larger offset for more boldness
                                    blurRadius: 0, // No blur
                                  ),
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(-2, -2),
                                    // Larger offset for more boldness
                                    blurRadius: 0, // No blur
                                  ),
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(3, 0),
                                    // Larger horizontal offset
                                    blurRadius: 0, // No blur
                                  ),
                                  Shadow(
                                    color: Colors.white,
                                    // White shadow
                                    offset: Offset(0, 3),
                                    // Larger vertical offset
                                    blurRadius: 0, // No blur
                                  ),
                                ],

                              ),
                            ),
                          ],
                        )

                      ],
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget topWinnerContainer(BuildContext context, Map<String, dynamic> data) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      // width: height * 0.15,
      margin: EdgeInsets.only(right: width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: width * 0.015, vertical: height * 0.00),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.47),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 20.0,
              // Adjust radius size as needed
              // backgroundImage: AssetImage(data['image']!),
              backgroundColor: AppColors.imageBG.withOpacity(0.5),
              // Set the background color dynamically
              child: ClipOval(
                child: Image.asset(
                  data['image']!, // Path to the image in your assets
                  width: 55.0, // Set the desired width of the image
                  height: 55.0, // Set the desired height of the image
                  fit: BoxFit
                      .contain, // Adjust how the image fits within the circular shape
                ),
              )
          ),
          SizedBox(height: height * 0.004),
          Text(data['name']!, style: FTextStyle.heading,overflow: TextOverflow.ellipsis,),
          Text(Constants.winningAmount, style: FTextStyle.winningAmountHeading),
          Text('₹ ${data['amount']} L',overflow: TextOverflow.ellipsis,
              style: FTextStyle.winningAmountTopWinners),
        ],
      ),
    );
  }

  Widget staticContent(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // Responsive padding and container sizes
    final double paddingValue = width * 0.04; // 4% of screen width
    final double paddingheight = height * 0.004; // 4% of screen width
    final double stepPadding = width * 0.02; // 5% of screen width
    final double stepHeight = height * 0.025; // 10% of screen height for step spacing
    final double stepWidth = width * 0.75; // 75% of screen width for step content

    // List of step descriptions
    List<String> stepDescriptions = [
      Constants.stepDesc,
      Constants.stepDesc,
      Constants.stepDesc,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingValue, vertical: height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // How to Play Title
          Text(
            Constants.howtoplay,
            style: FTextStyle.howToPlay.copyWith(
              shadows: [
                // Multiple shadows with smooth offsets and no blur
                Shadow(
                  color: Colors.white.withOpacity(0.5), // Light white shadow with opacity
                  offset: Offset(1, 1), // Slight, smooth offset
                  blurRadius: 0, // No blur
                ),
                Shadow(
                  color: Colors.white.withOpacity(0.5), // Light white shadow with opacity
                  offset: Offset(-1, 1), // Slight, smooth offset
                  blurRadius: 0, // No blur
                ),
                Shadow(
                  color: Colors.white.withOpacity(0.5), // Light white shadow with opacity
                  offset: Offset(1, -1), // Slight, smooth offset
                  blurRadius: 0, // No blur
                ),
                Shadow(
                  color: Colors.white.withOpacity(0.5), // Light white shadow with opacity
                  offset: Offset(-1, -1), // Slight, smooth offset
                  blurRadius: 0, // No blur
                ),
                // Additional shadows with smooth offsets
                Shadow(
                  color: Colors.white.withOpacity(0.3), // Slightly more transparent for subtle effect
                  offset: Offset(2, 0), // Slight horizontal offset
                  blurRadius: 0, // No blur
                ),
                Shadow(
                  color: Colors.white.withOpacity(0.3), // Slightly more transparent for subtle effect
                  offset: Offset(0, 2), // Slight vertical offset
                  blurRadius: 0, // No blur
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.004),
          // Subtitle Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Text(
                Constants.howtoplayDesc,
                textAlign: TextAlign.center,
                style: FTextStyle.howToPlayDesc
            ),
          ),
          SizedBox(height: height * 0.03),
          // Steps Section with Vertical Line
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Vertical Line
              Positioned(
                left: width * 0.057, // Adjust position for vertical line
                top: 0,
                bottom: height * 0.028,
                child: Container(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              Column(
                children: List.generate(stepDescriptions.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(left: stepPadding, bottom: stepHeight),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step Number Circle
                        Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.03, horizontal: width * 0.0),
                          width: width * 0.08, // Adjust circle size dynamically
                          height: width * 0.08, // Adjust circle size dynamically
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // White border color
                              width: 4, // Border width, adjust as needed
                            ),
                          ),
                          child: Center(
                            child: Text(
                                '${index + 1}',
                                style: FTextStyle.headingContest
                            ),
                          ),
                        ),

                        SizedBox(width: width * 0.03),
                        // Step Content
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Ensure the blur respects the rounded corners
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Apply background blur
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: paddingValue, vertical: paddingheight), // Padding applied here
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2), // Background color with some opacity
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${Constants.step} ${index + 1}',
                                      style: FTextStyle.howToPlayStepHeading,
                                    ),
                                    SizedBox(height: height * 0.004),
                                    Text(
                                      stepDescriptions[index], // Use the step description from the list
                                      style: FTextStyle.tabbar,
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
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

}