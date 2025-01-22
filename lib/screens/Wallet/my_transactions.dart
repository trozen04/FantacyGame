import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/Utils/flutter_color_themes.dart';
import 'package:fantacy_game/Utils/flutter_font_style.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/constant.dart';
import '../../widgets/match_utils.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}


class _TransactionsScreenState extends State<TransactionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<String>> subTabFilters = {
    Constants.contests: [Constants.entryPaid, Constants.entryRefund, Constants.winning],
    Constants.withdrawals: [Constants.success, Constants.inProcess, Constants.failed],
    Constants.deposits: [Constants.success, Constants.inProcess, Constants.failed],
  };

  String? selectedSubTab;

  // Updated data
  final Map<String, List<Map<String, dynamic>>> data = {
    Constants.contests: [
      {'type': Constants.winning, 'amount': 49, 'time': '21:11', 'date': '11/01/2025'},
      {'type': Constants.entryPaid, 'amount': -49, 'time': '20:15', 'date': '10/01/2025'},
      {'type': Constants.entryRefund, 'amount': -49, 'time': '19:10', 'date': '09/01/2025'},
    ],
    Constants.withdrawals: [
      {'status': null, 'amount': 60, 'time': '19:30', 'date': '09/01/2025'},
      {'status': true, 'amount': 30, 'time': '18:30', 'date': '08/01/2025'},
      {'status': false, 'amount': 49, 'time': '11:45', 'date': '10/01/2025'},

    ],
    Constants.deposits: [
      {'status': null, 'amount': 49, 'time': '12:00', 'date': '11/01/2025'},
      {'status': false, 'amount': 49, 'time': '11:45', 'date': '10/01/2025'},
      {'status': true, 'amount': 49, 'time': '11:45', 'date': '10/01/2025'},

    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(_onTabChanged);
    selectedSubTab = null; // Initially no subtab selected
  }
  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }
  void _onTabChanged() {
    setState(() {}); // Rebuild when the tab changes
  }

  List<Map<String, dynamic>> filterData(String parentTab) {
    List<Map<String, dynamic>> filteredData = [];
    if (parentTab == Constants.contests) {
      if (selectedSubTab == null) {
        filteredData = data[parentTab] ?? [];
      } else {
        filteredData = data[parentTab]!
            .where((item) => item['type'] == selectedSubTab)
            .toList();
      }
    } else {
      if (selectedSubTab == null) {
        filteredData = data[parentTab] ?? [];
      } else if (selectedSubTab == Constants.success) {
        filteredData = data[parentTab]!
            .where((item) => item['status'] == true)
            .toList();
      } else if (selectedSubTab == Constants.failed) {
        filteredData = data[parentTab]!
            .where((item) => item['status'] == false)
            .toList();
      } else if (selectedSubTab == Constants.inProcess) {
        filteredData = data[parentTab]!
            .where((item) => item['status'] == null)
            .toList();
      }
    }
    filteredData.sort((a, b) {
      final dateA = DateFormat('dd/MM/yyyy').parse(a['date']);
      final dateB = DateFormat('dd/MM/yyyy').parse(b['date']);
      return dateB.compareTo(dateA);
    });
    return filteredData;
  }

  Map<String, List<Map<String, dynamic>>> groupDataByDate(List<Map<String, dynamic>> filteredData) {
    Map<String, List<Map<String, dynamic>>> groupedData = {};
    for (var item in filteredData) {
      final date = item['date'];
      if (!groupedData.containsKey(date)) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(item);
    }
    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'My Transactions'),
      body: Stack(
        children: [
          Column(
            children: [
              _buildTabBar(width, height),
              _buildSubTabs(width, height),
              Expanded(child: _buildDataList(width, height)),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildTabBar(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background), // Background image
          fit: BoxFit.cover,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab, // Adjust the size of the indicator to match the tab
        labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0), // Padding around the text
        labelColor: AppColors.brand,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Outfit-Regular',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Outfit-Regular',
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: Constants.contests),
          Tab(text: Constants.withdrawals),
          Tab(text: Constants.deposits),
        ],
      ),
    );
  }


  Widget _buildSubTabs(double width, double height) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: subTabFilters[_getTabName()]!
            .map((subTab) {
          bool isSelected = selectedSubTab == subTab; // Cache selection state

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSubTab = isSelected ? null : subTab; // Toggle subTab only when necessary
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.02),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brand : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isSelected ? AppColors.brand : AppColors.transactionsSubTabBorder,
                    width: 1,
                  ),
                ),
                child: Text(
                  subTab,
                  style: FTextStyle.mega.copyWith(
                    color: isSelected ? Colors.white : AppColors.transactionsSubTabText,
                  ),
                ),
              ),
            ),
          );
        })
            .toList(),
      ),
    );
  }

  String _getTabName() {
    if (_tabController.index == 0) return Constants.contests;
    if (_tabController.index == 1) return Constants.withdrawals;
    return Constants.deposits;
  }

  Widget _buildDataList(double width, double height) {
    return TabBarView(
      controller: _tabController,
      children: [Constants.contests, Constants.withdrawals, Constants.deposits]
          .map((tab) {
        final filteredData = filterData(tab);
        final groupedData = groupDataByDate(filteredData);

        return ListView(
          children: groupedData.entries.map((entry) {
            final date = entry.key;
            final transactions = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.035),
                  child: Text(
                    formatDate(date),
                    style: FTextStyle.preferredPayment,
                  ),
                ),
                ...transactions.map((item) {
                  return _buildTransactionItem(item, width, height, tab);
                }).toList(),
              ],
            );
          }).toList(),
        );
      }).toList(),
    );
  }


  Widget _buildTransactionItem(Map<String, dynamic> item, double width, double height, String tab) {
    final type = item['type'] ?? 'Unknown';
    String status;

    // Only set 'In Process' for deposits or withdrawals (not contests)
    if (tab == Constants.deposits || tab == Constants.withdrawals) {
      status = item['status'] != null
          ? (item['status']! ? Constants.success : Constants.failed)
          : Constants.inProcess;
    } else {
      status = item['status'] != null
          ? (item['status']! ? Constants.success : Constants.failed)
          : ''; // No 'In Process' for contests
    }

    final amount = item['amount']?.toString() ?? '0';
    final isDeposits = tab == Constants.deposits;

    // Contests specific fields
    final originalTime = item['time'] ?? '00:00';
    final formattedTime = DateFormat("hh:mm a").format(DateFormat("HH:mm").parse(originalTime));
    final originalDate = item['date'] ?? '01/01/2000';
    final formattedDate = formatDate(originalDate);

    final team1 = item['team1'] ?? 'Team 1'; // Assuming you have the team1 field
    final team2 = item['team2'] ?? 'Team 2'; // Assuming you have the team2 field

    if (isDeposits) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
        margin: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.005),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.transactionContainerBorder,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // First row: Amount, Deposits, and PhonePe icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.wallet, color: AppColors.heading, height: 24, width: 24,),
                SizedBox(width: width * 0.03,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (status == Constants.inProcess) ...[
                      Text(
                        'In- Progress',
                        style: FTextStyle.dailyContestHistoryTitle,
                      )
                    ]
                    else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              '${Constants.rupee}$amount Deposits',
                              style: FTextStyle.dailyContestHistoryTitle
                          ),
                          SizedBox(width: width * 0.01,),

                          Image.asset(ImageAssets.phonepe, height: 18, width: 18,),

                        ],
                      ),
                    ],

                    Text(
                      '$formattedDate - $formattedTime',
                      style: FTextStyle.leaderBoardtabbarHeadings,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0),
            // Second row: Date, Time, and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (status == Constants.inProcess) ...[
                  Row(
                    children: [
                      Text(
                          '${Constants.rupee}$amount',
                          style: FTextStyle.dailyContestHistoryTitle
                      ),
                      Image.asset(ImageAssets.bank, height: 24, width: 24,),

                    ],
                  ),
                ]
                else ...[
                  // Status
                  Container(
                    height: height * 0.03,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: status == Constants.success
                          ? AppColors.brand.withOpacity(0.1)
                          : (status == Constants.failed
                          ? AppColors.failed.withOpacity(0.1)
                          : Colors.yellow.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center, // Center the content
                    child: Text(
                      status,
                      style: FTextStyle.status.copyWith(
                        color: status == Constants.success
                            ? AppColors.brand
                            : (status == Constants.failed ? AppColors.failed : Colors.yellow),
                      ),
                    ),
                  )

                ]
              ],
            )

          ],
        ),
      );
    }

    // Layout for Withdrawals (show status instead of type)
    if (tab == Constants.withdrawals) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
        margin: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.005),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.transactionContainerBorder,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // First row: Amount, Deposits, and PhonePe icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.wallet, color: AppColors.heading, height: 24, width: 24,),
                SizedBox(width: width * 0.03,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (status == Constants.inProcess) ...[
                      Text(
                        'In- Progress',
                        style: FTextStyle.dailyContestHistoryTitle,
                      )
                    ]
                    else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              '${Constants.rupee}$amount Deposits',
                              style: FTextStyle.dailyContestHistoryTitle
                          ),
                          SizedBox(width: width * 0.01,),

                          Image.asset(ImageAssets.phonepe, height: 18, width: 18,),

                        ],
                      ),
                    ],

                    Text(
                      '$formattedDate - $formattedTime',
                      style: FTextStyle.leaderBoardtabbarHeadings,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0),
            // Second row: Date, Time, and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (status == Constants.inProcess) ...[
                  Row(
                    children: [
                      Text(
                          '${Constants.rupee}$amount',
                          style: FTextStyle.dailyContestHistoryTitle
                      ),
                      Image.asset(ImageAssets.bank, height: 24, width: 24,),

                    ],
                  ),
                ]
                else ...[
                  // Status
                  Container(
                    height: height * 0.03,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: status == Constants.success
                          ? AppColors.brand.withOpacity(0.1)
                          : (status == Constants.failed
                          ? AppColors.failed.withOpacity(0.1)
                          : Colors.yellow.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center, // Center the content
                    child: Text(
                      status,
                      style: FTextStyle.status.copyWith(
                        color: status == Constants.success
                            ? AppColors.brand
                            : (status == Constants.failed ? AppColors.failed : Colors.yellow),
                      ),
                    ),
                  )

                ]
              ],
            )

          ],
        ),
      );
    }

    // Layout for Contests (show team1 vs team2)
    if (tab == Constants.contests) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
        margin: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.005),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.transactionContainerBorder,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              ImageAssets.trophyPNG,
              color: AppColors.heading,
              height: 24,
              width: 24,
            ),
            SizedBox(width: width * 0.03),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    type, // Use the type directly
                    style: FTextStyle.dailyContestHistoryTitle.copyWith
                      (
                      color: type == Constants.winning
                          ? AppColors.brand // Winning text color (green)
                          : (type == Constants.entryPaid
                          ? AppColors.heading // Entry paid text color (blue)
                          : (type == Constants.entryRefund
                          ? AppColors.heading // Entry refund text color (red)
                          : Colors.black)), // Default black for others
                    ),
                  ),
                  SizedBox(height: 0),
                  // Second row: Time and Team 1 vs Team 2
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        formattedTime,
                        style: FTextStyle.leaderBoardtabbarHeadings,
                      ),
                      Container(
                        width: 1, // Set width of divider
                        height: 12, // Adjust the height if needed
                        color: Colors.grey, // Set the color of the divider
                        margin: EdgeInsets.symmetric(horizontal: 8.0), // Optional margin for spacing
                      ),
                      Text(
                        '$team1 vs $team2',
                        style: FTextStyle.leaderBoardtabbarHeadings,
                      ),
                    ],
                  )


                ],
              ),
            ),
            Text(
              '${Constants.rupee}${amount}',
              style: TextStyle(
                color: double.parse(amount) > 0
                    ? AppColors.brand // Positive amount (blue)
                    : AppColors.failed, // Negative amount (red)
              ),
            ),
          ],
        ),
      );

    }

    return Container();
  }

}
