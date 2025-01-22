import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/flutter_font_style.dart';
import '../../widgets/custom_popup.dart';

class VerifyPanCard extends StatefulWidget {
  const VerifyPanCard({super.key, required String title});

  @override
  State<VerifyPanCard> createState() => _VerifyPanCardState();
}

class _VerifyPanCardState extends State<VerifyPanCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _panNumberController = TextEditingController();
  final TextEditingController _frontImageController = TextEditingController();
  final TextEditingController _backImageController = TextEditingController();

  bool _isButtonEnabled = false;
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _panNumberController.addListener(_checkFormValidity);
    _frontImageController.addListener(_checkFormValidity);
    _backImageController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _panNumberController.dispose();
    _frontImageController.dispose();
    _backImageController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() == true &&
          _frontImage != null &&
          _backImage != null;
    });
  }

  String? _validatePanNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN Number is required';
    } else if (!RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid PAN Number';
    }
    return null;
  }

  Future<void> _pickImage(String field) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (field == 'front') {
          _frontImage = File(image.path);
          _frontImageController.text = 'Front side image uploaded';
        } else {
          _backImage = File(image.path);
          _backImageController.text = 'Back side image uploaded';
        }
      });
    }
  }

  Widget _buildUploadField(
      {required String label,
        required TextEditingController controller,
        required File? imageFile,
        required VoidCallback onUpload}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: FTextStyle.mobilenumber),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onUpload,
          child: Container(
            height: screenHeight*0.2,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white, // Set the color inside the field to white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload',
                  style: FTextStyle.mobilenumber_textfield,
                ),
                SizedBox(width: 8),
                Image.asset(
                  'assets/images/uploadImage.png', // Replace with the path to your image
                  height: screenHeight * 0.08, // Adjust the image size dynamically
                  width: screenWidth * 0.08,   // Adjust the image size dynamically
                  fit: BoxFit.contain,           // Fit the image within the container
                ),
              ],
            ),
          ),
        ),
        if (imageFile != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              controller.text,
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            top: screenHeight * 0.06,
            left: screenWidth * 0.06,
            right: screenWidth * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back.png',
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Verify PAN Card',
                  style: FTextStyle.privacy_policy_headersection,
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
                  topLeft: Radius.circular(screenWidth * 0.09),
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
                        Text("PAN Number:", style: FTextStyle.mobilenumber),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _panNumberController,
                          decoration: InputDecoration(
                            hintText: 'Enter your Pan Number',
                            hintStyle: FTextStyle.mobilenumber_textfield,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: _validatePanNumber,
                        ),
                        SizedBox(height: screenHeight*0.025),
                        _buildUploadField(
                          label: "Upload PAN Card Front Side:",
                          controller: _frontImageController,
                          imageFile: _frontImage,
                          onUpload: () => _pickImage('front'),
                        ),
                        SizedBox(height: screenHeight*0.01),
                        _buildUploadField(
                          label: "Upload PAN Card Back Side:",
                          controller: _backImageController,
                          imageFile: _backImage,
                          onUpload: () => _pickImage('back'),
                        ),
                        SizedBox(height: screenHeight*0.03),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: _isButtonEnabled
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            onPressed: _isButtonEnabled
                                ? () => showCustomDialogBank(
                              context,
                              'assets/images/tick_check_mark.png',
                              'Your Pan Card has been submit successfully admin for verification. We will notify you shortly.',
                            )
                                : null, // Disable the button when conditions are not met
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
    );
  }
}
