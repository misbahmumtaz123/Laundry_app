import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../model/fontfamily_model.dart';
import '../../utils/Colors.dart';
import '../../utils/Custom_widget.dart';
import '../addlocation/location_service.dart';

class DropOffScreen extends StatefulWidget {
  @override
  _DropOffScreenState createState() => _DropOffScreenState();
}

class _DropOffScreenState extends State<DropOffScreen> {
  String? currentAddress;
  bool isFetchingLocation = true;
  bool isEditingAddress = false;
  String deliveryTime = "Now";
  TextEditingController addressController = TextEditingController();
  TextEditingController receiptController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      setState(() {
        isFetchingLocation = true;
      });
      Position position = await LocationService.getCurrentPosition();
      String address = await LocationService.getAddressFromLatLng(position);
      setState(() {
        currentAddress = address;
        addressController.text = address; // Pre-fill the address field
        isFetchingLocation = false;
      });
    } catch (e) {
      setState(() {
        currentAddress = "Failed to fetch location: $e";
        isFetchingLocation = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Deliver Your Drop-off",
            style: TextStyle(
              fontSize: isPortrait ? screenWidth * 0.06 : screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: primeryColor,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFetchingLocation)
                Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Super Laundromat",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  currentAddress ?? "Address not found",
                                  style: TextStyle(fontSize: screenWidth * 0.04),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            "0.2 mi",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Receipt No",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: receiptController,
                      decoration: InputDecoration(
                        hintText: "Enter receipt number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primeryColor, // Red border for enabled state

                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primeryColor, // Red border for focused state
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Upload Receipt Photo",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Select from Gallery'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Take a Photo'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.camera);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primeryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload, color: primeryColor),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "Upload",
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedImage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Image.file(
                          _selectedImage!,
                          height: screenHeight * 0.3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        Text(
                          "Delivering time",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: primeryColor, // Background color of the dropdown
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400, // Shadow color
                                offset: Offset(2, 2), // Horizontal and vertical offset
                                blurRadius: 4, // How blurry the shadow is
                                spreadRadius: 1, // Spread radius
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4), // Padding inside the dropdown
                          child: DropdownButton<String>(
                            value: deliveryTime,
                            items: ["Now", "Later"]
                                .map((time) => DropdownMenuItem(
                              value: time,
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontSize: 16, // Font size of dropdown text
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                deliveryTime = value!;
                              });
                            },
                            underline: SizedBox(), // Removes the default underline
                            icon: Icon(
                              Icons.arrow_drop_down, // Dropdown icon
                              color: Colors.white, // Icon color
                            ),
                            dropdownColor: primeryColor, // Background color of dropdown options
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: addressController,
                      enabled: isEditingAddress,
                      decoration: InputDecoration(
                        hintText: "Enter address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primeryColor, // Red border for enabled state

                          ),
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primeryColor, // Red border for focused state

                          ),
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primeryColor, // Grey border for disabled state
                            width: 2.0, // Border thickness
                          ),
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: GestButton(
                        Width: Get.size.width * 0.8, // Set the button width
                        height: 50, // Button height
                        buttoncolor: Darkblue2, // Button color from color.dart
                        margin: EdgeInsets.only(top: 15, left: 30, right: 30), // Same margin as GestButton
                        buttontext: "Add new address",
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyBold, // Add your font family if defined
                          color: WhiteColor, // Text color from color.dart file
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                        onclick: () {
                          setState(() {
                            isEditingAddress = true;
                          });
                        },
                      ),
                    ),



                  ],
                ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Address: ${addressController.text}");
                    print("Receipt No: ${receiptController.text}");
                    print("Delivery Time: $deliveryTime");
                  },
                  child: Text("Proceed",  style: TextStyle(
                    color: WhiteColor, // Text color from color.dart file
                    fontWeight: FontWeight.bold, // Bold text
                    fontSize: 16, // Font size
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Darkblue2, // Button color from color.dart file
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    elevation: 5, // Button shadow effect
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
