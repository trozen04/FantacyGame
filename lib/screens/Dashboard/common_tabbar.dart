import 'package:fantacy_game/screens/Side%20Menu/side_menu.dart';
import 'package:fantacy_game/screens/HomeScreen/Rummy/rummy_gamescreen.dart';
import 'package:flutter/material.dart';
import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../HomeScreen/DailyContest/daily_contest.dart';
import '../HomeScreen/DailyContest/daily_contest_history.dart';
import '../HomeScreen/DailyContest/leaderboard.dart';
import '../HomeScreen/DailyContest/my_contests.dart';
import '../HomeScreen/Rummy/rummy_home.dart';
import '../HomeScreen/cricket/cricket_home.dart';
import '../../widgets/custom_appbar_home.dart';
import 'package:fantacy_game/Utils/flutter_color_themes.dart';

import '../HomeScreen/cricket/my_matches.dart';
import '../HomeScreen/cricket/referEarn.dart';
import '../Winners/winners.dart';

class CommonTabbar extends StatefulWidget {
  final int initialIndex;

  const CommonTabbar({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<CommonTabbar> {
  late int _currentIndex;
  String _selectedTab = 'Cricket';
  bool _isAppBarVisible = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial tab index
  }

  @override
  Widget build(BuildContext context) {
    bool isHomeTab = _currentIndex == 0; // Check if we're on the home tab
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      appBar: _isAppBarVisible
          ? CustomAppBarHome(
        selectedTab: _selectedTab,
        isHomeTab: isHomeTab, // Pass the home tab status to the app bar
        onTabSelected: (tab) {
          setState(() {
            _selectedTab = tab;
            _currentIndex = 0; // Reset to home (index 0) on tab switch
          });
        },
        scaffoldKey: _scaffoldKey, // Pass the scaffold key to CustomAppBar

      )
          : null,
      drawer: SideMenuScreen(), // The side menu

      body: _getBodyForCurrentTab(context),
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: _selectedTab == 'Cricket'
              ? AppColors.bottomTabBar
              : Colors.white,
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.brand,
          unselectedItemColor: AppColors.tabNotSelected,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: _labelStyle(true),
          unselectedLabelStyle: _labelStyle(false),
          items: _getBottomNavItems(),
          onTap: (index) {
            setState(() {
              _currentIndex = 0; // Reset to index 0 when switching tabs
            });
            _onTabSelected(index); // Handle navigation inside the body
          },
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavItems() {
    if (_selectedTab == 'Rummy') {
      return [
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.home, _currentIndex == 0),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.tournament, _currentIndex == 1),
          label: Constants.tournament,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.leaderboard, _currentIndex == 2),
          label: Constants.leaderboard,
        ),
      ];
    } else if (_selectedTab == 'Cricket') {
      return [
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.home, _currentIndex == 0),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.myMatches, _currentIndex == 1),
          label: Constants.mymatches,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.winners, _currentIndex == 2),
          label: Constants.winners,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.howToPlay, _currentIndex == 3),
          label: Constants.referEarn,
        ),
      ];
    } else {
      // Default for Daily Contest
      return [
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.home, _currentIndex == 0),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.myContests, _currentIndex == 1),
          label: Constants.myContests,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.leaderboard, _currentIndex == 2),
          label: Constants.leaderboard,
        ),
        BottomNavigationBarItem(
          icon: _getImageAsset(ImageAssets.history, _currentIndex == 3),
          label: Constants.history,
        ),
      ];
    }
  }

  Widget _getBodyForCurrentTab(BuildContext context) {
    switch (_selectedTab) {
      case 'Cricket':
        return _getCricketScreen();
      case 'Rummy':
        return _getRummyScreen();
      case 'Daily Contest':
        return _getDailyContestScreen();
      default:
        return Center(child: Text('Unknown Page'));
    }
  }

  Widget _getCricketScreen() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        Cricket(), // Home Screen (index 0)
        MyMatchesScreen(selectedIndex: 0, viewAll: false,), // Placeholder for MyContests (index 1)
        WinnersScreen(), // History (index 2)
        ReferAndEarnScreen(), // History (index 3)
      ],
    );
  }

  Widget _getRummyScreen() {
    if (_currentIndex == 0) {
      return RummyHome(); // Render RummyHome when index is 0
    } else if (_currentIndex == 1) {
      // Navigate to the RummyGameScreen on index 1
      Future.delayed(Duration.zero, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RummyGameScreen()),
        ).then((_) {
          // Reset the index to 0 when returning to this screen
          setState(() {
            _currentIndex = 0;
          });
        });
      });
      return SizedBox(); // Return an empty widget while navigating
    } else {
      return Placeholder(); // Fallback for other screens
    }
  }

  Widget _getDailyContestScreen() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        DailyContest(), // Home Screen (index 0)
        MyContestsScreen(), // My Contests (index 1)
        LeaderboardScreen(), // Leaderboard (index 2)
        DailyContestHistory(), // History (index 3)
      ],
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getImageAsset(String assetPath, bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.brand : AppColors.tabNotSelected,
        BlendMode.srcIn,
      ),
      child: Image.asset(assetPath, width: 24, height: 24),
    );
  }

  TextStyle _labelStyle(bool isSelected) {
    return TextStyle(
      fontFamily: 'Outfit-Regular',
      fontSize: 12,
      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      color: isSelected ? AppColors.brand : AppColors.tabNotSelected,
    );
  }
}
