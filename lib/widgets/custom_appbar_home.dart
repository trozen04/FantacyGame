import 'package:flutter/material.dart';
import '../Utils/ImageAssets.dart';
import '../Utils/flutter_color_themes.dart';
import '../Utils/flutter_font_style.dart';
import '../Utils/constant.dart';
import '../screens/Side Menu/side_menu.dart';
import '../screens/Wallet/add_cash.dart';
import '../screens/Wallet/my_transactions.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  String selectedTab = 'Cricket';
  final bool isHomeTab;  // New parameter to indicate if it's the home tab
  final Function(String) onTabSelected;
  final GlobalKey<ScaffoldState> scaffoldKey;  // Accept the scaffoldKey here

  CustomAppBarHome({
    Key? key,
    required this.selectedTab,
    required this.isHomeTab,
    required this.onTabSelected,
    required this.scaffoldKey,  // Constructor to accept the scaffoldKey

  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 80); // Adjust height as needed

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,  // Removes the default hamburger menu
      flexibleSpace: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImageAssets.background,
              fit: BoxFit.cover,
            ),
          ),
          // AppBar content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.0, horizontal: width * 0.035),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState?.openDrawer(); // Open the drawer
                           // Opens the sidebar
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(ImageAssets.profile),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          ImageAssets.appIcon,
                          width: width * 0.25,

                        ),
                      ),
                      Spacer(),
                      // IconButton(
                      //   icon: Image.asset(
                      //     ImageAssets.bell,
                      //     height: 24,
                      //     width: 24,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       PageRouteBuilder(
                      //         pageBuilder:
                      //             (context, animation, secondaryAnimation) =>
                      //                 TransactionsScreen(),
                      //         transitionsBuilder: (context, animation,
                      //             secondaryAnimation, child) {
                      //           const begin = Offset(1.0, 0.0);
                      //           const end = Offset.zero;
                      //           const curve = Curves.easeInOut;
                      //           final tween = Tween(begin: begin, end: end)
                      //               .chain(CurveTween(curve: curve));
                      //           final offsetAnimation = animation.drive(tween);
                      //           return SlideTransition(
                      //             position: offsetAnimation,
                      //             child: child,
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SizedBox(width: width * 0.005),
                      isHomeTab
                          ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.buttonBG.withOpacity(0.4)),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.white)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const AddCashScreen(),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(ImageAssets.wallet, height: 18, width: 18),
                            SizedBox(width: width * 0.01),
                            Icon(Icons.currency_rupee, color: Colors.white, size: 18),
                            Text('1000', style: FTextStyle.homeAppbar),
                            SizedBox(width: width * 0.01),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.brand,
                              child: Icon(Icons.add, color: Colors.white, size: 18),
                            ),
                          ],
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const AddCashScreen(),
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
                        child: Image.asset(
                          ImageAssets.wallet,
                          height: 24,
                          width: 24,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.03),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          padding: EdgeInsets.symmetric(vertical: height * 0.003, horizontal: width * 0.035),
          margin: EdgeInsets.symmetric(vertical: height * 0.01),
          child:  Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.004),
            // margin: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.00),
            decoration: BoxDecoration(
              color: AppColors.tabBG,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton(Constants.cricket, ImageAssets.cricket, context),
                _buildTabButton(Constants.rummy, ImageAssets.rummy, context),
                _buildTabButton(Constants.dailyContest, ImageAssets.dailyContest, context),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildTabButton(String label, String icon, BuildContext context) {
    bool isSelected = selectedTab == label;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => onTabSelected(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.055, vertical: height * 0.014),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brand : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 15,
              color: isSelected ? Colors.white : AppColors.tabNotSelected,
            ),
            SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : AppColors.tabNotSelected),
            ),
          ],
        ),
      ),
    );
  }

}

