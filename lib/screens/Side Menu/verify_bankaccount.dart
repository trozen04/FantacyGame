import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
import '../../widgets/custom_popup.dart';
class VerifyBankAccount extends StatefulWidget {
  const VerifyBankAccount({super.key, required String title});

  @override
  State<VerifyBankAccount> createState() => _VerifyBankAccountState();
}

class _VerifyBankAccountState extends State<VerifyBankAccount> {
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _reAccountController = TextEditingController();

  final TextEditingController _ifscController = TextEditingController();


  // Dropdown values
  String? _selectedBank;


  // Dummy Lists
  final List<String> _bankname = ["Sate Bank Of India", "Bank Of India", "Punjab National Bank","Axis Bank"];
  // Button enable/disable flag
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _accountController.addListener(_checkFormValidity);
    _reAccountController.addListener(_checkFormValidity);
    _ifscController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    _reAccountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }
  void _checkFormValidity() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isButtonEnabled = isValid &&
          _accountController.text == _reAccountController.text &&
          _selectedBank != null;
    });
  }




  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid Account Holder Name';
    }
    if (value.length > 20) {
      return 'The Name Size is too Large';
    }
    return null;
  }

  String? _validateAccount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account Number is required'; // Check for empty input
    } else if (!RegExp(r'^[0-9]{18}$').hasMatch(value)) {
      return 'Please enter a valid Account Number'; // Validate phone number format
    }
    return null; // Input is valid
  }
  String? _validateReAccount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Re-Enter Account Number is required'; // Check for empty input
    } else if (!RegExp(r'^[0-9]{18}$').hasMatch(value)) {
      return 'Please enter a valid Account Number'; // Validate phone number format
    }
    return null; // Input is valid
  }

  String? _validateIFSCE(String? value) {
    if (value == null || value.isEmpty) return 'IFSCE Code is required';
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      return 'Please enter a valid IFSCE Code';
    }
    if (value.length >= 11) return 'Please enter a valid IFSCE Code';
    return null;
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog after form is validated
      showCustomDialogBank(context, 'assets/images/tick_check_mark.png', 'Your Account details has been submit successfully admin for verification. We will notify you shortly.');

      print("Profile Updated Successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true
      ,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss the keyboard when tapping outside
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.06, // Position below the status bar
              left: screenWidth * 0.06, // Slight padding from the left
              right: screenWidth * 0.04, // Slight padding from the right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Action for the back button
                    },
                    child: Image.asset(
                      'assets/images/back.png', // Replace with your back button image
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03), // Space between the button and text
                  Text(
                      'Verify Bank Account',
                      style: FTextStyle.privacy_policy_headersection
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.13,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        screenWidth * 0.09), // Adjust the radius as needed
                    topRight: Radius.circular(screenWidth * 0.09),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Bank Name:", style: FTextStyle.mobilenumber),
                          SizedBox(height: screenHeight*0.006,),
                          DropdownButtonFormField<String>(
                            value: _selectedBank,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.textfieldborder, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.mobilenumber,size: 24,),
                            items: _bankname.map((gender) {
                              return DropdownMenuItem(value: gender, child: Text(gender));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBank = value;
                              });
                            },
                            validator: (value) => value == null ? 'Select Bank' : null,
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          Text("Account Holder Name:", style: FTextStyle.mobilenumber),
                          SizedBox(height: screenHeight*0.006,),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter account holder name',
                              hintStyle: FTextStyle.mobilenumber_textfield,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.textfieldborder, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),

                            ),
                            validator: _validateName,

                          ),
                          SizedBox(height: screenHeight*0.02,),
                          // Mobile Number Field
                          Text("Account Number:", style:FTextStyle.mobilenumber ),
                          SizedBox(height: screenHeight*0.006,),
                          TextFormField(
                            controller: _accountController,
                            decoration: InputDecoration(
                              hintText: 'Account number',
                              hintStyle:  FTextStyle.mobilenumber_textfield,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.textfieldborder, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: _validateAccount,
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          Text("Re-Enter Account Number:", style:FTextStyle.mobilenumber ),
                          SizedBox(height: screenHeight*0.006,),
                          TextFormField(
                            controller: _reAccountController,
                            decoration: InputDecoration(
                              hintText: 'Account number',
                              hintStyle:  FTextStyle.mobilenumber_textfield,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.textfieldborder, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: _validateReAccount,
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          Text("IFSCE Code:", style: FTextStyle.mobilenumber),
                          SizedBox(height: screenHeight*0.006,),
                          TextFormField(
                            controller: _ifscController,
                            decoration: InputDecoration(
                              hintText: 'Enter IFSCE code',
                              hintStyle: FTextStyle.mobilenumber_textfield,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.textfieldborder, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                            ),
                            validator: _validateIFSCE,
                          ),
                          SizedBox(height: screenHeight*0.03,),

                          // Update Button
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight*0.064,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: _isButtonEnabled
                                    ? AppColors.buttoncolor
                                    : Colors.grey,
                              ),
                              onPressed:  _isButtonEnabled ? _updateProfile : null,
                              child: Text(
                                "SUBMIT",
                                style: FTextStyle.button_continue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

