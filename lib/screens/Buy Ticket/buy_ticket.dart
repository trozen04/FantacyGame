import 'dart:async';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../Utils/ImageAssets.dart';
import '../../../widgets/match_utils.dart';
import '../../widgets/custom_popup.dart';
import 'manual_buy.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({super.key});

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int amount = 0;
  double ticketValue = 10.00; // Global variable for ticket value
  TextEditingController _quantityController = TextEditingController();
  List<Map<String, dynamic>> data = []; // Initialize empty list
  final List<LinearGradient> gradients = [
    LinearGradient(colors: [Colors.pink.shade100, Colors.blue.shade100]),
    LinearGradient(colors: [Colors.yellow.shade100, Colors.orange.shade100]),
    LinearGradient(colors: [Colors.green.shade100, Colors.blue.shade50]),
    LinearGradient(colors: [Colors.purple.shade100, Colors.red.shade100]),
  ];

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _quantityController.text = amount.toString(); // Initialize with the current amount
    _fetchData(); // Fetch data when the widget is initialized
    _startTimer();
  }
  Future<void> _fetchData() async {
    // Simulate a delay for fetching data (e.g., API request)
    await Future.delayed(Duration(seconds: 1));

    // Here you can make your API call to fetch data
    // For now, we use static data as an example
    setState(() {
      data = [
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
        {
          'title': 'Afternoon 7402',
          'date': '12/12/2024',
          'time': '18:30',
          'amount': 1375852,
          'tickets': [
            '6258',
            '1754',
            '6258',
            '6258',
          ],
        },
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
        {
          'title': 'Morning 7402',
          'date': '08/01/2025',
          'time': DateTime.now().add(Duration(hours: 1)),
          'amount': 1375852,
          'tickets': ['6258', '1754', '6258', '6258'],
        },
      ];
    });
  }
  // Function to start the timer and update every second
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // Rebuild the UI every second
    });
  }
  void _stopTimer() {
    _timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CustomAppBar(title: 'Buy Ticket'),
        body: Column(
          children: [
            // TabBar with a custom design
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.background),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.01),
                    topRight: Radius.circular(screenWidth * 0.01),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                labelColor: AppColors.brand,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 14, fontFamily: 'Outfit-Regular', fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 14, fontFamily: 'Outfit-Regular', fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: "AutoBuy"),
                  Tab(text: "ManualBuy"),
                  Tab(text: "MyTicket"),
                ],
              ),
            ),
            // Content below TabBar
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(  // Make sure it is scrollable to avoid overflow
                      child: _buildAutoBuyView(),
                    ),
                    ManualBuyView(),
                    _buildMyTicketView(),
                  ],
                ),
              ),
            ),
          ],
        )

    );
  }

  // AutoBuy View
  Widget _buildAutoBuyView() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.035),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.containerBorderWinners),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.pink.shade100, Colors.blue.shade100]),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
            ),
            padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Morning 7402', style: FTextStyle.dailyContestHistoryTitle, overflow: TextOverflow.ellipsis),
                Text('20 Dec, 2024 06:30 PM', style: FTextStyle.dailyContestHistoryDate, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter Quantity', style: FTextStyle.dailyContestprizePot),
                SizedBox(height: height * 0.01),
                TextFormField(
                  style: FTextStyle.dailyContestAmount,
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12), // Adjust vertical padding to reduce height
                    suffixIcon: Container(
                      height: height * 0.055,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                amount++; // Increase amount by 1
                                _quantityController.text = amount.toString(); // Update the controller
                              });
                            },
                            child: Image.asset(
                              ImageAssets.up, // Replace with your image path
                              width: 20, // Adjust the image width as needed
                              height: 10, // Adjust the image height as needed
                            ),
                          ),
                          SizedBox(height: height * 0.01), // Adjust the space between the images
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (amount > 0) {
                                  amount--; // Decrease amount by 1, not going below 0
                                  _quantityController.text = amount.toString(); // Update the controller
                                }
                              });
                            },
                            child: Image.asset(
                              ImageAssets.down, // Replace with your image path
                              width: 20, // Adjust the image width as needed
                              height: 10, // Adjust the image height as needed
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _quantityController.text.isNotEmpty
                            ? AppColors.buyTicketBorder // Border color when the field is not empty
                            : AppColors.brand, // Default border color
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      amount = int.tryParse(value) ?? 0; // Update amount based on text input
                    });
                  },
                ),
                SizedBox(height: height * 0.01),
                Text('Note',style: FTextStyle.dailyContestHistoryDate),
                SizedBox(height: height * 0.002),
                Text(
                  "The ticket counter will be closed before 1 min the actual time. Create your own lucky number to get a chance to win a super exciting lottery prize.",
                  style: FTextStyle.Activity,
                ),
                SizedBox(height: height * 0.01),
                Text('1 Ticket = ₹ $ticketValue', style: FTextStyle.dailyContestHistoryDate),
                SizedBox(height: height * 0.01),
                Center(
                  child: Text(
                    '₹ ${(amount * ticketValue).toStringAsFixed(2)}',
                    style: FTextStyle.sideMenuLabels,
                  ),
                ),
                SizedBox(height: height * 0.01),
                ElevatedButton(
                  onPressed: () {
                    if (_quantityController.text.isNotEmpty) {
                      showCustomPopup(context);
                    } else {
                      // Optionally, you can show a message or handle the case when the controller is empty
                      print('Quantity is empty');
                    }
                  },

                  child: Text('Buy Ticket', style: FTextStyle.privacy_policy_headersection),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.brand,
                    minimumSize: Size(double.infinity, height * 0.07),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MyTicket View
  Widget _buildMyTicketView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final gradient = gradients[index % gradients.length];

        // Parse raw date into DateTime
        final rawDate = DateFormat('dd/MM/yyyy').parse(item['date']);

        // Handle 'time' field being either DateTime or String
        DateTime matchDateTime;
        if (item['time'] is DateTime) {
          matchDateTime = item['time']; // If time is already DateTime
        } else {
          final rawTime = DateFormat('HH:mm')
              .parse(item['time']); // Parse time if it's a String
          matchDateTime = DateTime(
            rawDate.year,
            rawDate.month,
            rawDate.day,
            rawTime.hour,
            rawTime.minute,
          );
        }

        final now = DateTime.now();
        final isUpcoming = matchDateTime.isAfter(now);

        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

        return GestureDetector(
          onTap: () {
            // Your action when the container is tapped
            print('Item tapped: ${item['title']}');
            // You can navigate to another screen or do any action
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: height * 0.008, horizontal: width * 0.035),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColors.containerBorderWinners),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.008, horizontal: width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: FTextStyle.dailyContestHistoryTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(matchDateTime),
                        style: FTextStyle.dailyContestHistoryDate,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.008, horizontal: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // First Column (Left Aligned)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constants.prizePot,
                              style: FTextStyle.dailyContestprizePot,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.004),
                            Text(
                              '${item.containsKey('amount') ? formatCash(item['amount']) : ''}',
                              style: FTextStyle.dailyContestAmount,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.015),
                            ElevatedButton(
                              onPressed: isUpcoming ? null : () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                isUpcoming ? Colors.grey : Colors.green,
                                minimumSize: Size(width * 0.4, height * 0.07),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Constants.checkWinnings,
                                    style: FTextStyle.homeAppbar,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (isUpcoming)
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: height * 0.001),
                                      child: Text(
                                        getTimeLeft(matchDateTime),
                                        style: FTextStyle.homeAppbar,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Add some spacing between the columns
                        SizedBox(
                            width: width *
                                0.145), // Adjust the width for the space between columns

                        // Second Column (Right Aligned) with Padding
                        Column(
                          children: [
                            Text(
                              '${Constants.myTickets} (${item['tickets'].length})',
                              style: FTextStyle.dailyContestprizePot,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height * 0.004),
                            // Wrap the ticket list in a horizontally scrollable view
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item['tickets'].map<Widget>((ticket) {
                                List<String> digits = ticket.split('');
                                return Row(
                                  children: digits.map<Widget>((digit) {
                                    return Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * 0.005,
                                          vertical: height * 0.0015),
                                      decoration: BoxDecoration(
                                        border:
                                        Border.all(color: AppColors.brand),
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          digit,
                                          style: FTextStyle.digital,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _stopTimer(); // Stop the timer when the widget is disposed

    _quantityController.dispose(); // Dispose of the controller
    super.dispose();
  }


  void showCustomPopup(BuildContext context, {bool isSecondPopup = false}) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        imagePath: ImageAssets.buyTicket,// Change the image path
        title: isSecondPopup ? 'Congratulations!' : 'Are you sure do you want to buy this ticket?', // Change the title
        descriptions: [
          isSecondPopup
              ? 'You\'ve got this ticket no.  \n - ${_quantityController.text}'
              : 'Total Tickets : ${_quantityController.text}\nTotal Amount : ${(amount * ticketValue)}',
          // Different description for second popup if needed
        ],
        descriptionStyles: [
          isSecondPopup? FTextStyle.popUpTitle : FTextStyle.DescText2,
        ],
        buttonTexts: !isSecondPopup? [
          Constants.cancel,
          Constants.confirm,
        ] : ['Ok'],
        onTapCallbacks: !isSecondPopup?  [
              () {
            print('Button 1 tapped');
            Navigator.pop(context);
          },
              () {
            print('Button 2 tapped');
            Navigator.pop(context);
            showCustomPopup(context, isSecondPopup: true);  // Second popup with different content
          },
        ] : [ () { Navigator.pop(context);}],
        titleStyle: isSecondPopup? FTextStyle.popuptitle3 :FTextStyle.popuptitle2,
      ),
    );
  }

}




