import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Utils/ImageAssets.dart';
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/custom_popup.dart';

class ManualBuyView extends StatefulWidget {
  @override
  _ManualBuyViewState createState() => _ManualBuyViewState();
}

class _ManualBuyViewState extends State<ManualBuyView> {
  final int ticketPrice = 10;
  int totalTickets = 0; // Total tickets selected
  int totalPrice = 0;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _pinController = TextEditingController();
  List<List<int>> ticketNumbers = [
    [0, 0, 0, 0], // Initial ticket
  ];
  List<int> ticketQuantities = [0]; // Initial quantity

  void calculateTotalPriceAndTickets() {
    setState(() {
      totalTickets = 0;
      totalPrice = 0;

      for (int quantity in ticketQuantities) {
        totalTickets += quantity;
      }

      totalPrice = totalTickets * ticketPrice;
    });
  }

  void addNewTicketSlot() {
    setState(() {
      ticketNumbers.add([0, 0, 0, 0]); // Add a new ticket
      ticketQuantities.add(0); // Add a corresponding quantity
    });
  }

  bool validateFields() {
    // Check if any ticket number is empty or invalid
    // for (List<int> ticket in ticketNumbers) {
    //   for (int number in ticket) {
    //     if (number == 0) {
    //       return false; // Invalid if any ticket number is 0
    //     }
    //   }
    // }
    //
    // // Check if any quantity is empty or invalid
    // for (int quantity in ticketQuantities) {
    //   if (quantity == 0) {
    //     return false; // Invalid if quantity is 0
    //   }
    // }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: height * 0.008, horizontal: width * 0.035),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.containerBorderWinners),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.pink.shade100, Colors.blue.shade100]),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.008, horizontal: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Morning 7402',
                            style: FTextStyle.dailyContestHistoryTitle,
                            overflow: TextOverflow.ellipsis),
                        Text('20 Dec, 2024 06:30 PM',
                            style: FTextStyle.dailyContestHistoryDate,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.01),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Choose Tickets Number',
                                    style:  FTextStyle.dailyContestprizePot
                                ),
                                Text(
                                    'Quantity',
                                    style: FTextStyle.dailyContestprizePot
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ticketNumbers.length,
                              itemBuilder: (context, ticketIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns the children at the top
                                      children: [
                                        // Lucky Numbers Section
                                        Row(
                                          children: List.generate(4, (boxIndex) {
                                            return Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: ticketNumbers[ticketIndex][boxIndex] != null && ticketNumbers[ticketIndex][boxIndex] != 0
                                                      ? AppColors.brand // Border color when input is provided
                                                      : AppColors.buyTicketBorder, // Default border color when input is empty
                                                ),
                                              ),
                                              child: TextField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.isNotEmpty && int.tryParse(value) != null) {
                                                      ticketNumbers[ticketIndex][boxIndex] = int.parse(value);
                                                    } else if(value.isEmpty && ticketNumbers[ticketIndex][boxIndex] != 0){
                                                      FocusScope.of(context).previousFocus();
                                                    }
                                                    else {
                                                      ticketNumbers[ticketIndex][boxIndex] = 0; // Reset the value if input is removed
                                                    }
                                                  });

                                                  // Move focus to the next field if value length is 1 and boxIndex is less than 3
                                                  if (value.length == 1 && boxIndex < 3) {
                                                    FocusScope.of(context).nextFocus();
                                                  }
                                                },
                                                maxLength: 1,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                ],
                                                textAlign: TextAlign.center, // Center the input text horizontally
                                                decoration: InputDecoration(
                                                  border: InputBorder.none, // No border to allow the container's border to take effect
                                                  counterText: '',
                                                  hintText: '-', // Display this when input is empty
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                        // Quantity Section
                                        Center(
                                          child: SizedBox(
                                            width: width * 0.2,
                                            height: 40,
                                            child: TextField(
                                              style: FTextStyle.dailyContestAmount, // Matches the input text style with the hint style
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value.isNotEmpty && int.tryParse(value) != null) {
                                                    int enteredQuantity = int.parse(value);
                                                    if (enteredQuantity <= 100) {
                                                      ticketQuantities[ticketIndex] = enteredQuantity;
                                                      calculateTotalPriceAndTickets();
                                                    }
                                                  }
                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              textAlign: TextAlign.center, // Centers text horizontally
                                              maxLength: 2,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ticketQuantities[ticketIndex] != null && ticketQuantities[ticketIndex] > 0
                                                        ? AppColors.brand2 // Border color when the field is not empty
                                                        : AppColors.buyTicketBorder, // Default border color
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),

                                                hintText: '0',
                                                hintStyle: FTextStyle.dailyContestAmount,
                                                counterText: '',
                                                suffixIcon: Container(
                                                  height: height * 0.045,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (ticketQuantities[ticketIndex] < 100) {
                                                              ticketQuantities[ticketIndex]++;
                                                              calculateTotalPriceAndTickets();
                                                            }
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          ImageAssets.up, // Replace with your image path
                                                          width: 10, // Adjust the image width as needed
                                                          height: 10, // Adjust the image height as needed
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.01), // Adjust the space between the images
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (ticketQuantities[ticketIndex] > 0) {
                                                              ticketQuantities[ticketIndex]--;
                                                              calculateTotalPriceAndTickets();
                                                            }
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          ImageAssets.down, // Replace with your image path
                                                          width: 10, // Adjust the image width as needed
                                                          height: 10, // Adjust the image height as needed
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                contentPadding: EdgeInsets.symmetric(vertical: 0), // Adjust vertical padding
                                              ),
                                            ),
                                          ),

                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 2),
                            Container(

                              child: TextButton(
                                onPressed: addNewTicketSlot,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero, // Remove the default padding around the button
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, // Ensures the row takes only as much space as the icon and text
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Icon(
                                        Icons.add_box_outlined,
                                        size: 20,
                                        color: AppColors.viewDetails,
                                      ),
                                    ),
                                    const SizedBox(width: 4), // Adds a small space between the icon and text
                                    const Text(
                                      'Add More Ticket',
                                      style: FTextStyle.viewDetails,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.00),
                            Text('Note',style: FTextStyle.dailyContestHistoryDate),
                            SizedBox(height: height * 0.001),
                            Text(
                              "The ticket counter will be closed before 1 min the actual time. Create your own lucky number to get a chance to win a super exciting lottery prize.",
                              style: FTextStyle.Activity,
                            ),
                            SizedBox(height: height * 0.006),
                            Text('1 Ticket = ₹$ticketPrice',style: FTextStyle.dailyContestHistoryDate),
                            Center(
                              child: Text('₹ $totalPrice',
                                style: FTextStyle.sideMenuLabels,),
                            ),
                            SizedBox(height: height * 0.01),
                            ElevatedButton(
                              onPressed: () {
                                showCustomPopup(context);
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
                          ]))
                ]))
          ],
        ),
      ),
    );
  }

  void showCustomPopup(BuildContext context, {bool isSecondPopup = false}) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        imagePath: ImageAssets.buyTicket, // Change the image path
        title: isSecondPopup ? 'Congratulations!' : 'Are you sure do you want to buy this ticket?', // Change the title
        descriptions: [
          isSecondPopup
              ? 'You\'ve got this ticket no.  \n - '
              : 'Total Tickets : ',
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
