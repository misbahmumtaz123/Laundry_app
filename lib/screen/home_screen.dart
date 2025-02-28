import 'dart:io';
// import 'package:carousel_slider/carousel_slider.dart';
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
// New imports for Nearby Laundromats functionality
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
  // CatDetailsController catDetailsController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  NotificationController notificationController = Get.find();
  MyOrderController myOrderController = Get.find();
  int selectIndex = 0;
  String name = "";

  // New code: Controller for Nearby Laundromats
  final LaundryController laundryController = Get.put(LaundryController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getCurrentLatAndLong();
    super.initState();
    if (getData.read("UserLogin") != null) {
      setState(() {
        name = getData.read("UserLogin")["name"];
        myOrderController.normalOrderHistory(statusWise: "Current");
      });

    }
    // New code: Fetching Nearby Laundromats on app start
    laundryController.fetchLaundromats(24.92994926038695, 67.07463296801761);
  }
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getCurrentLatAndLong() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      address =
      '${placemarks.first.name!.isNotEmpty ? placemarks.first.name! + ', ' : ''}${placemarks.first.thoroughfare!.isNotEmpty ? placemarks.first.thoroughfare! + ', ' : ''}${placemarks.first.subLocality!.isNotEmpty ? placemarks.first.subLocality! + ', ' : ''}${placemarks.first.locality!.isNotEmpty ? placemarks.first.locality! + ', ' : ''}${placemarks.first.subAdministrativeArea!.isNotEmpty ? placemarks.first.subAdministrativeArea! + ', ' : ''}${placemarks.first.postalCode!.isNotEmpty ? placemarks.first.postalCode! + ', ' : ''}${placemarks.first.administrativeArea!.isNotEmpty ? placemarks.first.administrativeArea : ''}';
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color:Colors.transparent,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: primeryColor,
              elevation: 0,
              expandedHeight: 150,
              floating: true,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              flexibleSpace: Stack(
                children: [
                  SizedBox(
                    height: 240,
                    width: Get.width,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),

                            //code neededdddddddddddddd
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(SelectDeliveryAddress());
                                },
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${"Welcome".tr}, ${name}",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: WhiteColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            address,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily:
                                              FontFamily.gilroyMedium,
                                              color: WhiteColor,
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            "assets/Arrow - Down 2.svg",
                                            color: WhiteColor),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //code neededdddddddddddddd

                            SizedBox(
                              width: 10,
                            ),

                            InkWell(
                              onTap: () {
                                notificationController.getNotificationData();
                                Get.toNamed(Routes.notificationScreen);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: SvgPicture.asset(
                                  "assets/Notification.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),


                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // search bar
                        InkWell(
                          onTap: () async {

                            Get.to(LaundrySearchScreen(
                              // statusWiseSearch: true,
                              // backbutton: true,
                            ));
                          },
                          child: Container(
                            height: 45,
                            width: Get.size.width,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/Search.png",
                                  height: 18,
                                  width: 18,
                                  // color: Color(0xFF636268),
                                  color: WhiteColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
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
                              // border: Border.all(color: Colors.grey.shade300),
                              color: WhiteColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  // Positioned(
                  //   bottom: -1,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     height: 25,
                  //     decoration: BoxDecoration(
                  //       color: Colors.green,
                  //       borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  //     ),
                  //   ),
                  // ),


                ],
              ),
              //-----------------------------------needed code bar
            ),

            // New Code: Display Nearby Laundromats List
            SliverToBoxAdapter(

              child: Obx(() {
                if (laundryController.laundromats.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                if (laundryController.filteredLaundromats.isEmpty) {
                  return Center(child: Text('No laundromats found.'));
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListView.separated(

                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: laundryController.filteredLaundromats.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      Laundry laundry = laundryController.filteredLaundromats[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ServicesScreen(laundry: laundry));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15), // Darker shadow for depth
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(4, 4), // Bottom-right shadow
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8), // Top-left highlight effect
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: Offset(-4, -4), // Top-left shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                laundry.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                laundry.address,
                                style: TextStyle(color: Colors.grey.shade600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${laundry.distance} ml",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Open",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
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
