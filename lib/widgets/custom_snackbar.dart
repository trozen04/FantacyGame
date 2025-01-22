import 'package:flutter/material.dart';
import '../Utils/flutter_color_themes.dart';
import '../Utils/flutter_font_style.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final bool isWarning;

  CustomSnackbar({required this.message, required this.isWarning});

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: 0, // To make the snackbar appear at the top of the screen
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(top: 50.0, bottom: 15),
          color: isWarning ? Colors.red : AppColors.brand, // Red for warning, brand color for success
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the row's children horizontally
            crossAxisAlignment: CrossAxisAlignment.center, // Center the row's children vertically
            children: [
              Icon(
                isWarning ? Icons.warning_amber_outlined : Icons.check_circle,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 5),
              Text(
                message,
                style: FTextStyle.sideMenuScore,
                textAlign: TextAlign.center, // Center the text inside the row
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );


  }
}
