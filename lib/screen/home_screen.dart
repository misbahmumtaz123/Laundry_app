import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:laundry/screen/searchScreen.dart';
import '../Api/data_store.dart';
import '../controller/home_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/stordata_controller.dart';
import '../helpar/routes_helper.dart';
import '../model/fontfamily_model.dart';
import '../screen/addlocation/selectdelivery_address.dart';
import '../screen/onbording_screen.dart';
import '../utils/Colors.dart';
import '../controller/myorder_controller.dart';
import 'package:laundry/controller/laundryment_search_controller.dart';
import 'package:laundry/screen/placeorder/servicesPage.dart';
import '../../model/laundryment_search_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var currency;
var wallat1;

class _HomeScreenState extends State<HomeScreen> {
  HomePageController homePageController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  NotificationController notificationController = Get.find();
  MyOrderController myOrderController = Get.find();
  final LaundryController laundryController = Get.put(LaundryController());
  final TextEditingController searchController = TextEditingController();

  int selectIndex = 0;
  String name = "";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    getCurrentLatAndLong();

    if (getData.read("UserLogin") != null) {
      setState(() {
        name = getData.read("UserLogin")["name"] ?? "Guest";
      });

      myOrderController.normalOrderHistory(statusWise: "Current");
    } else {
      print("⚠ Warning: User data not found in getData!");
    }

    // Fetching Nearby Laundromats on app start
    laundryController.fetchLaundromats(24.92994926038695, 67.07463296801761);
  }

  getCurrentLatAndLong() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    var currentLocation = await Geolocator.getCurrentPosition();
    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);

    if (addresses.isNotEmpty) {
      Placemark place = addresses[0];
      setState(() {
        address = [
          place.name,
          place.thoroughfare,
          place.subLocality,
          place.locality,
          place.subAdministrativeArea,
          place.postalCode,
          place.administrativeArea
        ].where((element) => element != null && element!.isNotEmpty).join(", ");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 📌 App Bar with Search Field
          SliverAppBar(
            backgroundColor: primeryColor,
            elevation: 0,
            expandedHeight: 150,
            floating: true,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size(0, 20),
              child: Container(),
            ),
            flexibleSpace: Stack(
              children: [
                SizedBox(
                  height: 240,
                  width: Get.width,
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(SelectDeliveryAddress());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"Welcome".tr}, ${name}",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: WhiteColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          address,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyMedium,
                                            color: WhiteColor,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset("assets/Arrow - Down 2.svg", color: WhiteColor),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              notificationController.getNotificationData();
                              Get.toNamed(Routes.notificationScreen);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset("assets/Notification.svg", height: 20, width: 20),
                              decoration: BoxDecoration(shape: BoxShape.circle),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 15),

                      // 🔍 Search Bar (Restored UI to match the image)
                      InkWell(
                        onTap: () {
                          Get.to(LaundrySearchScreen()); // Navigates to search screen
                        },
                        child: Container(
                          height: 45,
                          width: Get.size.width,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Image.asset("assets/Search.png", height: 18, width: 18, color: WhiteColor),
                              SizedBox(width: 5),
                              Text(
                                "Search for Laundromat".tr,
                                style: TextStyle(
                                  color: WhiteColor,
                                  fontFamily: FontFamily.gilroyMedium,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          // 📌 Laundromat List with Search Filter
          SliverToBoxAdapter(
            child: Obx(() {
              if (laundryController.laundromats.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              var filteredLaundromats = laundryController.filteredLaundromats
                  .where((laundry) => laundry.name.toLowerCase().contains(searchQuery))
                  .toList();

              if (filteredLaundromats.isEmpty) {
                return Center(child: Text('No laundromats found.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredLaundromats.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    Laundry laundry = filteredLaundromats[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ServicesScreen(laundry: laundry));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: primeryColor, width: 2), // 🟦 Added blue border around the entire card
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🏪 Name of the Laundry with Border
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.blue, width: 2), // 🟦 Blue border around the name
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child:
                              Text(
                                laundry.name,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            // ),

                            SizedBox(height: 8.0),

                            // 📍 Full Address with Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    laundry.address,
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.0),

                            // 📏 Distance & 🟢 Status Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Distance Display
                                Row(
                                  children: [
                                    Icon(Icons.directions_walk, color: Theme.of(context).primaryColor, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "${laundry.distance.toStringAsFixed(1)} km",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),

                                // Status Badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    // color: laundry.status.toLowerCase() == "open"
                                    //     ? Colors.green.shade100
                                    //     : Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    laundry.status.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: laundry.status.toLowerCase() == "open" ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),



        ],
      ),
    );
  }
}



class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        height: isActive ? 9 : 6,
        width: isActive ? 9 : 6,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF36393D) : Color(0xFFB3B2B7),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}