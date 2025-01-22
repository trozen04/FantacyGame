import 'package:flutter/material.dart';

import '../../Utils/flutter_color_themes.dart';
import '../../Utils/flutter_font_style.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  // Dropdown values
  String? _gender;
  String? _state;
  String? _country;

  // Dummy Lists
  final List<String> _genders = ["Male", "Female", "Others"];
  final List<String> _states = ["California", "Texas", "New York", "Florida"];
  final List<String> _countries = ["USA", "India", "Canada", "Australia"];


  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid name';
    }
    if (value.length > 20) {
      return 'Maximum 20 characters allowed';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required'; // Check for empty input
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email'; // Validate email format
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required'; // Check for empty input
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number'; // Validate phone number format
    }
    return null; // Input is valid
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) return 'Address is required';
    if (value.length < 8) return 'Please enter a valid address';
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) return 'City is required';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid city name';
    }
    if (value.length > 15) return 'Please enter a valid city name';
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.isEmpty) return 'Pincode is required';
    if (!RegExp(r'^\d+$').hasMatch(value)) return 'Only numbers are allowed';
    if (value.length != 6) return 'Enter a valid 6-digit pincode';
    return null;
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // Logic to save/update profile
      print("Profile Updated Successfully!");
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
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
                    'Edit Profile',
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

                        // Name Field
                        Text("Name:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            hintStyle: FTextStyle.mobilenumber,
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

                        // Email Field
                        Text("Email:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: FTextStyle.mobilenumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.textfieldborder.withOpacity(0.5), // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          validator: _validateEmail,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // Mobile Number Field
                        Text("Mobile No:", style:FTextStyle.mobilenumber ),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            hintText: 'Enter your mobile number',
                            hintStyle: FTextStyle.mobilenumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.textfieldborder, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: _validateMobile,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // Gender Dropdown
                        Text("Gender:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        DropdownButtonFormField<String>(
                          value: _gender,
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
                          items: _genders.map((gender) {
                            return DropdownMenuItem(value: gender, child: Text(gender));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                          validator: (value) => value == null ? 'Please select gender' : null,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // Address Field
                        Text("Address:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: 'Enter your address',
                            hintStyle: FTextStyle.mobilenumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.textfieldborder, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          validator: _validateAddress,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // City Field
                        Text("City:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter your city',
                            hintStyle: FTextStyle.mobilenumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.textfieldborder, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          validator: _validateCity,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // Pincode Field
                        Text("Pin Code:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        TextFormField(
                          controller: _pincodeController,
                          decoration: InputDecoration(
                            hintText: 'Enter your pin code',
                            hintStyle: FTextStyle.mobilenumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.textfieldborder, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: _validatePincode,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // State Dropdown
                        Text("Select State:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        DropdownButtonFormField<String>(
                          value: _state,
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
                          items: _states.map((state) {
                            return DropdownMenuItem(value: state, child: Text(state));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _state = value;
                            });
                          },
                          validator: (value) => value == null ? 'Please select a state' : null,
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        // Country Dropdown
                        Text("Select Country:", style: FTextStyle.mobilenumber),
                        SizedBox(height: screenHeight*0.006,),
                        DropdownButtonFormField<String>(
                          value: _country,
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
                          items: _countries.map((country) {
                            return DropdownMenuItem(value: country, child: Text(country));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                          validator: (value) => value == null ? 'Please select a country' : null,
                        ),
                        SizedBox(height: screenHeight*0.03,),

                        // Update Button
                        SizedBox(
                          width: double.infinity,
                          height: screenHeight*0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor:AppColors.buttoncolor,
                            ),
                            onPressed: _updateProfile,
                            child: Text(
                              "UPDATE",
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
    );
  }
}

