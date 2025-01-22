import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/Utils/flutter_color_themes.dart';
import 'package:fantacy_game/screens/Wallet/payment_options.dart';
import 'package:fantacy_game/screens/Wallet/verify_details.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/widgets.dart';
import '../Side Menu/edit_profile.dart';
import 'my_transactions.dart';

class AddCashScreen extends StatefulWidget implements PreferredSizeWidget {
  const AddCashScreen({Key? key}) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 200); // Adjust height as needed
  @override
  State<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends State<AddCashScreen> {
  bool isExpanded = false; // For dropdown toggle
  TextEditingController amountController = TextEditingController(text: "500");
  int selectedAmount = 500;

  final List<int> quickAmounts = [500, 1000, 1500, 2000];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: Constants.addCash),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Section
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets
                      .background), // Replace with your image path
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              child: Container(
                color: Colors.white.withOpacity(0.2),
                padding: EdgeInsets.symmetric(vertical: height * 0.003),
                margin: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.01),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.00),
                  decoration: BoxDecoration(
                    color: AppColors.tabBG,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Constants.currentBalance,
                                  overflow: TextOverflow.ellipsis,
                                  style: FTextStyle.howToPlayDesc,
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              "${Constants.rupee}302",
                              overflow: TextOverflow.ellipsis,
                              style: FTextStyle.sideMenuName,
                            ),
                          ],
                        ),
                      ),
                      if (isExpanded) const SizedBox(height: 16),
                      if (isExpanded)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            balanceDetail(Constants.amountUnutilized, "${Constants.rupee}100"),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                balanceDetail(Constants.winnings, ""),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.brand,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                            vertical: height * 0.00),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (context, animation, secondaryAnimation) =>
                                                VerifyDetailsScreen(),
                                            transitionsBuilder: (context, animation,
                                                secondaryAnimation, child) {
                                              const begin = Offset(1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;
                                              final tween = Tween(begin: begin, end: end)
                                                  .chain(CurveTween(curve: curve));
                                              final offsetAnimation = animation.drive(tween);
                                              return SlideTransition(
                                                position: offsetAnimation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        Constants.verifytoWithdraw,
                                        overflow: TextOverflow.ellipsis,
                                        style: FTextStyle.sideMenuButtons,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                      '${Constants.rupee}82',
                                      overflow: TextOverflow.ellipsis,
                                      style: FTextStyle.sideMenuScore,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            balanceDetail(Constants.discountBonus, "${Constants.rupee}118"),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.amountToAdd,
                    overflow: TextOverflow.ellipsis,
                    style: FTextStyle.sideMenuAmount,
                  ),
                  SizedBox(height: height * 0.004),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        selectedAmount =
                            int.tryParse(value) ?? selectedAmount;
                      });
                    },
                    decoration: InputDecoration(
                      prefixText: Constants.rupee,
                      prefixStyle:
                          TextStyle(color: AppColors.heading, fontSize: 16),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.heading,
                        ),
                        onPressed: () {
                          setState(() {
                            amountController.text = ' ';
                            selectedAmount = 0;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: AppColors.textfieldborder,
                            width: 1), // Border size and color when enabled
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: AppColors.containerBG,
                            width:
                                1.0), // Border size and color when focused
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.0), // Border size and color when error
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width:
                                1.0), // Border size and color when focused and error
                      ),
                    ),
                    style: FTextStyle.sideMenuAmount,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Allows only numeric input
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: quickAmounts.map((amount) {
                      bool isSelected = selectedAmount == amount;

                      return Container(
                        margin:EdgeInsets.symmetric(vertical: height * 0.015),
                        width: width * 0.2, // Fixed width
                        height: height * 0.045, // Fixed height
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.brand
                              : Colors
                                  .white70, // Background color when selected or not
                          borderRadius: BorderRadius.circular(
                              100), // Radius for rounded corners
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColors
                                    .amountButton, // Border color when not selected
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                              100), // Ensure ink ripple effect matches the radius
                          onTap: () {
                            setState(() {
                              selectedAmount = amount;
                              amountController.text = amount.toString();
                            });
                          },
                          child: Center(
                            child: Text(
                              "$amount",
                              style: FTextStyle.amountButton.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors
                                        .amountButton, // Text color based on selection
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: height * 0.004),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, height * 0.055),
                      backgroundColor: Colors.white, // Set background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        side: BorderSide(
                          color: AppColors.heading, // Border color
                          width: 0.5, // Border width
                        ),
                      ),
                      elevation: 0
                    ),
                    onPressed: () {
                      navigateWithSlideTransition(context, TransactionsScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the items (icon, text, arrow)
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet, // You can change this to any icon you want
                              color: AppColors.heading,
                            ),
                            SizedBox(width: 8.0), // Space between icon and text
                            Text(
                              'My Transactions', // Text of the button
                              style: FTextStyle.sideMenuLabels,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios, // Arrow icon on the right
                          color: AppColors.heading,
                          size: 18.0, // Adjust the size of the arrow
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.035),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, height * 0.055),
                  backgroundColor: AppColors.brand,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: selectedAmount > 0
                    ? () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                          PaymentOptionScreen(),
                      transitionsBuilder: (context, animation,
                          secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        final offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
                    : null,
                child: Text(
                  "${Constants.add} ${Constants.rupee}$selectedAmount",
                  style: FTextStyle.headingContest,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget balanceDetail(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: FTextStyle.tabbar,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 4),
            const Icon(Icons.info_outline, color: Colors.white70, size: 16),
          ],
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: FTextStyle.sideMenuScore,
        ),
      ],
    );
  }
}
