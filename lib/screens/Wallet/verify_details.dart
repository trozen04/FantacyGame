import 'package:fantacy_game/Utils/ImageAssets.dart';
import 'package:fantacy_game/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart'; // Import the permission handler package
import '../../Utils/constant.dart';
import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/custom_snackbar.dart';

class VerifyDetailsScreen extends StatefulWidget {
  const VerifyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<VerifyDetailsScreen> createState() => _VerifyDetailsScreenState();
}

class _VerifyDetailsScreenState extends State<VerifyDetailsScreen> {
  String? _selectedLocation;
  DateTime? _selectedDate;
  bool _isWarning = false;
  String _snackbarMessage = '';
  final List<String> _locations = ["New York", "London", "Tokyo", "Delhi", "Sydney"];
  bool _isSnackbarVisible = false;
  DateTime? _lastSnackbarTime;
  bool _isDetailsVerified = false;  // Add a flag to track verification status
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _overlayEntry?.remove();
    super.dispose();
  }

  void showCustomSnackbar(BuildContext context, String message, bool isWarning) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackbar(
        message: message,
        isWarning: isWarning,
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the snackbar after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      showCustomSnackbar(context, "Location permission granted!", false);
    } else if (status.isDenied) {
      showCustomSnackbar(context, "Location denied. Allow to continue.", true);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(title: Constants.verifyDetails),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: height * 0.004, horizontal: width * 0.035),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: height * 0.03, right: width * 0.09),
                  child: Image.asset(
                    ImageAssets.verifyDetailsBG,
                    height: height * 0.2,
                    width: width * 0.7,
                  ),
                ),
                Text(
                  Constants.verifyDesc,
                  style: FTextStyle.verifyDetailsheading,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.008),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.verifyDetailsSteps,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Constants.step}1",
                              style: FTextStyle.dailyContestHistoryTitle,
                            ),
                            Text(
                              Constants.enterDetails,
                              style: FTextStyle.enterDetail,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.008),
                    TextField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: _selectedDate != null
                            ? DateFormat("dd/MM/yyyy").format(_selectedDate!)
                            : Constants.DOB,
                        hintStyle: FTextStyle.hintText,
                        contentPadding: EdgeInsets.symmetric(vertical: height * 0.016, horizontal: width * 0.025),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              ImageAssets.verifyDetailsCalender,
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.textfieldborder),
                        ),
                      ),
                    ),

                    if (_selectedDate != null && DateTime.now().difference(_selectedDate!).inDays < 365 * 18)
                      Text(
                        Constants.DOBWarning,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    SizedBox(height: height * 0.02),
                    DropdownButtonFormField<String>(
                      value: _selectedLocation,
                      items: _locations.map((location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                      style: FTextStyle.enterDetail,
                      decoration: InputDecoration(
                        labelText: Constants.whereFrom,
                        labelStyle: FTextStyle.enterDetail,
                        contentPadding: EdgeInsets.symmetric(vertical: height * 0.016, horizontal: width * 0.025),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.textfieldborder),
                        ),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.heading),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand,
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {

                        setState(() {
                          _isDetailsVerified = true;  // Mark as verified
                        });
                        showCustomSnackbar(context, "Details verified successfully!", false);

                        if (_selectedDate == null || _selectedLocation == null || DateTime.now().difference(_selectedDate!).inDays < 365 * 18) {
                          showCustomSnackbar(context,"Please fill in all the corrected details.", true);
                        } else {
                          setState(() {
                            _isDetailsVerified = true;  // Mark as verified
                          });
                          showCustomSnackbar(context,"Details verified successfully!", false);
                        }
                      },
                      child: Text(
                        Constants.verifyDetailsCap,
                        style: FTextStyle.headingContest,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.verifyDetailsSteps,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Constants.step}2",
                              style: FTextStyle.dailyContestHistoryTitle,
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              Constants.locationPermission,
                              style: FTextStyle.enterDetail,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // Share Location Button: Only visible if details are verified
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isDetailsVerified ? AppColors.brand : Colors.transparent, // Null background when not verified
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: _isDetailsVerified ? Colors.transparent : AppColors.textfieldborder), // Optional: Add a border to indicate it's disabled
                        ),
                      ),
                      onPressed: _isDetailsVerified ? () {
                        _requestLocationPermission();
                      } : null, // Disable onPressed when not verified
                      child: Text(
                        Constants.shareLocation,
                        style: FTextStyle.headingContest.copyWith(
                          color: _isDetailsVerified ? Colors.white : Colors.black38, // Color based on the verification status
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isSnackbarVisible)
          CustomSnackbar(message: _snackbarMessage, isWarning: _isWarning),
      ],
    );
  }
}
