import 'package:flutter/material.dart';
import '../../../Utils/ImageAssets.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/custom_popup.dart';
import '../../../widgets/match_utils.dart';
import 'package:intl/intl.dart';

class DailyContestHistory extends StatefulWidget {
  @override
  _DailyContestHistoryScreenState createState() =>
      _DailyContestHistoryScreenState();
}

class _DailyContestHistoryScreenState extends State<DailyContestHistory> {
  bool isAllHistorySelected = true;

  // Predefined list of light gradients
  final List<List<Color>> headerGradients = [
    [Colors.pink.shade100, Colors.blue.shade100],
    [Colors.yellow.shade100, Colors.orange.shade100],
    [Colors.green.shade100, Colors.blue.shade50],
    [Colors.purple.shade100, Colors.red.shade100],
  ];

  final List<Map<String, dynamic>> allHistoryData = [
    {
      'title': 'Evening 4207',
      'date': '21/12/2024',
      'time': '07:30',
      'prizePot': 1500000,
      'winningNumber': [1, 0, 4, 3],
      'totalTickets': 60015,
      'matchDetails': [
        {'label': 'Match 1', 'amount': 15000},
        {'label': 'Match 2', 'amount': 15000},
        {'label': 'Match 3', 'amount': 15000},
        {'label': 'Match 4', 'amount': 15000},
      ],
    },
    {
      'title': 'Morning 7402',
      'date': '20/12/2024',
      'time': '06:30',
      'prizePot': 1375852,
      'winningNumber': [6, 2, 5, 8],
      'totalTickets': 50012,
      'matchDetails': [
        {'label': 'Match 1', 'amount': 13758},
        {'label': 'Match 2', 'amount': 13758},
        {'label': 'Match 3', 'amount': 13758},
        {'label': 'Match 4', 'amount': 13758},
      ],
    },
  ];

  final List<Map<String, dynamic>> yourHistoryData = [
    {
      'title': 'Morning 7402',
      'date': '20/12/2024',
      'time': '06:30',
      'prizePot': 1375852,
      'winningNumber': [6, 2, 5, 8],
      'winningAmount': 0.00,
      'isWinning': false,
      'matchDetails': [
        {'label': 'Match 1', 'amount': 13758},
        {'label': 'Match 2', 'amount': 13758},
        {'label': 'Match 3', 'amount': 13758},
        {'label': 'Match 4', 'amount': 13758},
      ],
    },
    {
      'title': 'Evening 4207',
      'date': '21/12/2024',
      'time': '07:30',
      'prizePot': 1500000,
      'winningNumber': [1, 0, 4, 3],
      'winningAmount': 10000,
      'isWinning': true,
      'matchDetails': [
        {'label': 'Match 1', 'amount': 13758},
        {'label': 'Match 2', 'amount': 13758},
        {'label': 'Match 3', 'amount': 13758},
        {'label': 'Match 4', 'amount': 13758},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final data = isAllHistorySelected ? allHistoryData : yourHistoryData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Tabs
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() =>
                        isAllHistorySelected = true); // Select "All History"
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isAllHistorySelected
                          ? Colors.white
                          : Colors.transparent, // White background for selected
                      image: isAllHistorySelected
                          ? null
                          : DecorationImage(
                              // Background image when not selected
                              image: AssetImage(ImageAssets.background),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        Constants.allHistory,
                        style: FTextStyle.lineupsOut.copyWith(
                          color: isAllHistorySelected
                              ? AppColors.brand
                              : Colors
                                  .white, // Black for selected, white for unselected
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() =>
                        isAllHistorySelected = false); // Select "Your History"
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: !isAllHistorySelected
                          ? Colors.white
                          : Colors.transparent, // White background for selected
                      image: !isAllHistorySelected
                          ? null
                          : DecorationImage(
                              // Background image when not selected
                              image: AssetImage(ImageAssets.background),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        Constants.yourHistory,
                        style: FTextStyle.lineupsOut.copyWith(
                          color: isAllHistorySelected
                              ? Colors.white
                              : AppColors
                                  .brand, // Black for selected, white for unselected
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                // Debug the data being passed
                print('Item $index data:');
                print(
                    item); // This prints the entire item to inspect its structure

                return HistoryCard(
                  title: item['title'],
                  date: item['date'],
                  time: item['time'],
                  prizePot:
                      item['prizePot'].toString(), // Ensure it is a String
                  winningNumber: List<int>.from(
                      item['winningNumber']), // Convert to List<int> explicitly
                  totalTickets: isAllHistorySelected
                      ? item['totalTickets'].toString()
                      : null,
                  matchDetails:
                      item['matchDetails'] as List<Map<String, dynamic>>?,
                  headerGradient:
                      headerGradients[index % headerGradients.length],
                  winningAmount: isAllHistorySelected ? null : item['winningAmount'],

                  isWinning: isAllHistorySelected ? null : item['isWinning'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String prizePot;
  final List<int> winningNumber;
  final String? totalTickets;
  final List<Map<String, dynamic>>? matchDetails; // Updated type here
  final List<Color> headerGradient;
  final num? winningAmount;
  final bool? isWinning;

  const HistoryCard({
    required this.title,
    required this.date,
    required this.time,
    required this.prizePot,
    required this.winningNumber,
    required this.headerGradient,
    this.totalTickets,
    this.matchDetails,
    this.winningAmount,
    this.isWinning,
  });

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive size variables
    double cardPadding = screenWidth * 0.04; // 4% of screen width for padding
    double cardPaddingHeight =
        screenHeight * 0.008; // 4% of screen width for padding
    double textPadding =
        screenWidth * 0.03; // 3% of screen width for text padding
    double fontSize = screenWidth * 0.04; // 4% of screen width for font size
    DateTime parsedMatchDateTime = parseMatchDateTime(widget.date ?? '01/01/2022', widget.time ?? '00:00:00');

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
          horizontal: cardPadding, vertical: cardPaddingHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: cardPadding, vertical: cardPaddingHeight),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: FTextStyle.dailyContestHistoryTitle,
                ),
                Text(
                    DateFormat('dd MMM yyyy, hh:mm a').format(parsedMatchDateTime),  // Format the DateTime
                    style: FTextStyle.dailyContestHistoryDate),
              ],
            ),
          ),
          // Body
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: cardPadding, vertical: cardPaddingHeight),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.prizePot,
                          style: FTextStyle.dailyContestprizePot,
                        ),
                        SizedBox(
                            height: screenHeight *
                                0.004), // 1% of screen height for spacing
                        Text(
                          formatCash(double.tryParse(widget.prizePot.toString()) ?? 0), // Convert to num and format it
                          style: FTextStyle.dailyContestAmount,
                        )

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.winningNumber,
                          style: FTextStyle.dailyContestprizePot,
                        ),
                        SizedBox(
                            height: screenHeight *
                                0.004), // 1% of screen height for spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,  // Center the entire Row horizontally
                          crossAxisAlignment: CrossAxisAlignment.center, // Center the children vertically in the Row
                          children: widget.winningNumber
                              .map((num) => Container(
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.brand),
                            ),
                            child: Center(  // This centers the child inside the Container
                              child: Text(
                                '$num',
                                style: FTextStyle.digital,
                                textAlign: TextAlign.center,  // Centers the text
                              ),
                            ),
                          ))
                              .toList(),
                        )


                      ],
                    ),
                  ],
                ),
                Divider(),
                // View Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align the text to the start
                      children: [
                        Text(
                          widget.totalTickets != null
                              ? Constants.totalTicketsSold
                              : Constants.winningAmount,
                          style: FTextStyle.DescText, // Styling for the label
                        ),
                        Text(
                          widget.totalTickets != null
                              ? '${widget.totalTickets}' // Always show totalTickets as-is
                              : widget.winningAmount == null || widget.winningAmount == 0.00
                              ? formatCash(0.00) // If winningAmount is null or 0, use formatCash with 0
                              : formatCash(widget.winningAmount!), // Use formatCash and safely un-wrap the nullable num
                          style: widget.totalTickets != null
                              ? FTextStyle.dailyContestprizePot // Apply this style for totalTickets
                              : FTextStyle.dailyContestprizePot.copyWith(
                            color: widget.winningAmount == null || widget.winningAmount == 0.00
                                ? Colors.red // Red if 0 or null
                                : Colors.green, // Green if non-zero
                          ),
                        ),

                      ],
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => isExpanded = !isExpanded),
                      label: Row(
                        children: [
                          Text(
                            isExpanded
                                ? Constants.hideDetails
                                : Constants.viewDetails,
                            style: FTextStyle.viewDetails,
                          ),
                          Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more, // Same expand icon
                              size: 25,
                              color: AppColors.viewDetails),
                        ],
                      ),
                    ),
                    if (widget.isWinning != null)
                      widget.isWinning!
                          ? ElevatedButton(
                              onPressed: () {
                                showCustomPopup(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.brand.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              child: Text(Constants.claim,
                                  style: FTextStyle.claim),
                            )
                          : Text(Constants.youLoss, style: FTextStyle.youLoss),
                  ],
                ),
                if (isExpanded && widget.matchDetails != null) Divider(),
                // Match Details
                if (isExpanded && widget.matchDetails != null)
                  Row(
                    children: widget.matchDetails!
                        .asMap() // Using asMap() to get the index for each column
                        .map((index, detail) {
                          Color containerColor;
                          switch (index % 4) {
                            case 0:
                              containerColor = AppColors.match1; // First color
                              break;
                            case 1:
                              containerColor = AppColors.match2; // Second color
                              break;
                            case 2:
                              containerColor = AppColors.match3
                                  .withOpacity(0.53); // Third color
                              break;
                            case 3:
                              containerColor = AppColors.match4
                                  .withOpacity(0.53); // Fourth color
                              break;
                            default:
                              containerColor =
                                  AppColors.match1; // Default color
                          }

                          return MapEntry(
                            index,
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.00,
                                    vertical: screenHeight * 0.008),
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.006,
                                    vertical: screenHeight * 0.00),
                                decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      detail['label'] as String? ??
                                          'Default Label', // Use a default label if 'label' is null or not a String
                                      style: FTextStyle.matchLabel,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenHeight * 0.004),
                                    Text(
                                      '${formatCash(detail['amount'])}', // Use the formatCash function to format the amount
                                      style: FTextStyle.dailyContestprizePot,
                                      textAlign: TextAlign.center,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
          imagePath: ImageAssets.claimPopUpImage, // Local image path
          title: Constants.claimPopUpTitle,
          descriptions: [
            Constants.claimPopUpDesc,
          ],
          descriptionStyles: [FTextStyle.DescText],
          buttonTexts: [
            Constants.claimNow,
          ],
          onTapCallbacks: [
            () {
              print('Button 1 tapped');
              Navigator.pop(context);
            },
          ],
          titleStyle: FTextStyle.popUpTitle),
    );
  }
}
