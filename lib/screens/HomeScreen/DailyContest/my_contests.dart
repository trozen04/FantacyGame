import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // Import for Timer
import '../../../Utils/constant.dart';
import '../../../Utils/flutter_color_themes.dart';
import '../../../Utils/flutter_font_style.dart';
import '../../../widgets/match_utils.dart';

class MyContestsScreen extends StatefulWidget {
  @override
  _MyContestsScreenState createState() => _MyContestsScreenState();
}

class _MyContestsScreenState extends State<MyContestsScreen> {
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
    _fetchData(); // Fetch data when the widget is initialized
    _startTimer();
  }

  // Function to fetch data asynchronously (simulate fetching from an API)
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

  // Function to stop the timer
  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      // Show a loading indicator while data is being fetched
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        body: ListView.builder(
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
    ));
  }
}
