import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

import '../Utils/flutter_color_themes.dart';
import '../Utils/flutter_font_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05, // Dynamic left padding
          top: MediaQuery.of(context).size.width * 0.03, // Optional dynamic top padding
          bottom: MediaQuery.of(context).size.width * 0.03, // Optional dynamic bottom padding
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Action for the back button
          },
          child: Image.asset(
            'assets/images/back.png', // Replace with your back button image path
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.width * 0.04                   ,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 12.0), // Right padding for space
        child: Text(
          title,
          style: FTextStyle.buttonText,
        ),
      ),
      actions: [],
    );
  }
}
