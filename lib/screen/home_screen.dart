import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:laundry/Api/config.dart';
import '../Api/data_store.dart';
import '../controller/catdetails_controller.dart';
import '../controller/home_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/stordata_controller.dart';
import '../helpar/routes_helper.dart';
import '../model/fontfamily_model.dart';
import '../screen/addlocation/selectdelivery_address.dart';
import '../screen/categorydetails_screen.dart';
import '../screen/home_search.dart';
import '../screen/onbording_screen.dart';
import '../utils/Colors.dart';
import '../controller/myorder_controller.dart';
import 'my booking/mybooking_screen.dart';

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
  CatDetailsController catDetailsController = Get.find();
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
      Future.delayed(
        Duration(seconds: 1),
            () {
          catDetailsController.getCartLangth();
        },
      );
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
    return Scaffold(
      backgroundColor: bgcolor,
      body: CustomScrollView(
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
                      InkWell(
                        onTap: () async {

                          Get.to(HomeSearchScreen(
                            statusWiseSearch: true,
                            backbutton: true,
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
                                "Search for stores".tr,
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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: WhiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                  bottom: -3,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GetBuilder<HomePageController>(
                builder: (homePageController) {
                  return homePageController.isLoading
                      ? Column(
                    children: [
                      Container(
                        color: WhiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 190,
                              width: Get.size.width,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      selectIndex = index;
                                    });
                                  },
                                ),
                                items: homePageController.bannerList
                                    .map(
                                      (item) => Container(
                                    width: Get.size.width,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: FadeInImage.assetNetwork(
                                        fadeInCurve:
                                        Curves.easeInCirc,
                                        placeholder:
                                        "assets/ezgif.com-crop.gif",

                                        placeholderCacheHeight: 210,
                                        placeholderFit: BoxFit.fill,
                                        // placeholderScale: 1.0,
                                        image: item,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: Get.size.width,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                      homePageController
                                          .homeInfo!
                                          .homeData
                                          .banlist
                                          .length, (index) {
                                    return Indicator(
                                      isActive: selectIndex == index
                                          ? true
                                          : false,
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Fastest Delivery".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily: FontFamily.gilroyExtraBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "When you need it most".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily: FontFamily.gilroyMedium,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 260,
                              width: Get.size.width,
                              child:
                              homePageController.homeInfo!.homeData
                                  .spotlightStore.isNotEmpty
                                  ? ListView.builder(
                                itemCount: homePageController
                                    .homeInfo
                                    ?.homeData
                                    .spotlightStore
                                    .length,
                                scrollDirection:
                                Axis.horizontal,
                                physics:
                                BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      catDetailsController.strId =
                                          homePageController.homeInfo?.homeData.spotlightStore[index].storeId ?? "";
                                      await storeDataContoller.getStoreData(
                                        storeId: homePageController.homeInfo?.homeData.spotlightStore[index].storeId,
                                      );
                                      save("changeIndex", true);
                                      homePageController
                                          .isback = "1";
                                      Get.to(
                                          CategoryDetailsScreen());
                                    },
                                    child: Container(
                                      height: 270,
                                      width: 290,
                                      margin:
                                      EdgeInsets.all(10),
                                      alignment:
                                      Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "${Config.imageUrl}${homePageController.homeInfo?.homeData.spotlightStore[index].storeCover ?? ""}",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                            color: Colors
                                                .grey.shade300),
                                        borderRadius:
                                        BorderRadius
                                            .circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            height: 135,
                                            width: 290,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Stack(
                                            clipBehavior:
                                            Clip.none,
                                            children: [
                                              Container(
                                                height: 90,
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    5),
                                                margin: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    4),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10),
                                                      child:
                                                      SizedBox(
                                                        width: Get.width *
                                                            0.44,
                                                        child:
                                                        Text(
                                                          homePageController.homeInfo?.homeData.spotlightStore[index].storeTitle ??
                                                              "",
                                                          maxLines:
                                                          1,
                                                          style:
                                                          TextStyle(
                                                            color:
                                                            BlackColor,
                                                            fontFamily:
                                                            FontFamily.gilroyExtraBold,
                                                            fontSize:
                                                            17,
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10),
                                                      child:
                                                      Text(
                                                        homePageController.homeInfo?.homeData.spotlightStore[index].storeSlogan ??
                                                            "",
                                                        maxLines:
                                                        1,
                                                        style:
                                                        TextStyle(
                                                          color:
                                                          BlackColor,
                                                          fontFamily:
                                                          FontFamily.gilroyMedium,
                                                          fontSize:
                                                          15,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          10),
                                                      child:
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/Location.png",
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                          SizedBox(width: 5,),
                                                          SizedBox(
                                                            width:
                                                            Get.size.width * 0.3,
                                                            child:
                                                            Text(
                                                              homePageController.homeInfo?.homeData.spotlightStore[index].storeAddress ?? "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontFamily: FontFamily.gilroyMedium,
                                                                color: BlackColor,
                                                                fontSize: 13,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            10,
                                                          ),
                                                          Image.asset(
                                                            "assets/Sport-mode.png",
                                                            height:
                                                            18,
                                                            width:
                                                            18,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            5,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              homePageController.homeInfo?.homeData.spotlightStore[index].restDistance ?? "",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontFamily: FontFamily.gilroyMedium,
                                                                color: BlackColor,
                                                                fontSize: 13,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                decoration:
                                                BoxDecoration(
                                                  color:
                                                  WhiteColor,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      20),
                                                ),
                                              ),
                                              Positioned(
                                                top: -30,
                                                right: 15,
                                                child:
                                                Container(
                                                  height: 55,
                                                  width: 55,
                                                  child:
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    child: Image
                                                        .network(
                                                      "${Config.imageUrl}${homePageController.homeInfo?.homeData.spotlightStore[index].storeLogo ?? ""}",
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    WhiteColor,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey
                                                            .shade300),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                                  : Container(
                                height: 300,
                                width: Get.size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  "No store available \nin your area."
                                      .tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                    FontFamily.gilroyBold,
                                    fontSize: 15,
                                    color: BlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      myOrderController.nOrderInfo.isNull
                          ? SizedBox()
                          : myOrderController
                          .nOrderInfo!.orderHistory.isNotEmpty
                          ? Container(
                        width: Get.size.width,
                        color: WhiteColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Text(
                                  "Recent Order".tr,
                                  style: TextStyle(
                                    fontFamily:
                                    FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Get.to(MyBookingScreen());
                                  },
                                  child: Text(
                                    "See all".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily
                                          .gilroyMedium,
                                      color:
                                      gradient.defoultColor,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // SizedBox(
                            //   height: 5,
                            // ),

                            myOrderController.nOrderInfo!
                                .orderHistory.isNotEmpty
                                ? MediaQuery.removePadding(
                              removeTop: true,
                              context: Get.context!,
                              child: ListView.builder(
                                itemCount: 1,
                                physics:
                                NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      myOrderController
                                          .normalOrderDetails(
                                        orderID: myOrderController
                                            .nOrderInfo
                                            ?.orderHistory[
                                        index]
                                            .id ??
                                            "",
                                      );
                                      Get.toNamed(
                                          Routes
                                              .orderdetailsScreen,
                                          arguments: {
                                            "oID": myOrderController
                                                .nOrderInfo
                                                ?.orderHistory[
                                            index]
                                                .id ??
                                                "",
                                          });
                                    },
                                    child: Container(
                                      width:
                                      Get.size.width,
                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal: 10,
                                      //     vertical: 6),
                                      padding: EdgeInsets
                                          .symmetric(
                                          horizontal:
                                          10,
                                          vertical:
                                          8),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                myOrderController
                                                    .nOrderInfo
                                                    ?.orderHistory[index]
                                                    .odate
                                                    .toString()
                                                    .split(" ")
                                                    .first ??
                                                    "",
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  FontFamily.gilroyMedium,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Order ID: #${myOrderController.nOrderInfo?.orderHistory[index].id ?? ""}",
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  FontFamily.gilroyBold,
                                                  color:
                                                  BlackColor,
                                                  fontSize:
                                                  16,
                                                ),
                                              ),

                                            ],
                                          ),


                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                50,
                                                width: 50,
                                                alignment:
                                                Alignment
                                                    .center,
                                                decoration:
                                                BoxDecoration(
                                                  shape: BoxShape
                                                      .circle,
                                                  color: Colors
                                                      .grey
                                                      .shade200,
                                                  image:
                                                  DecorationImage(
                                                    image:
                                                    NetworkImage("${Config.imageUrl}${myOrderController.nOrderInfo?.orderHistory[index].storeImg ?? ""}"),
                                                    fit: BoxFit
                                                        .cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child:
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            myOrderController.nOrderInfo?.orderHistory[index].storeTitle ?? "",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.gilroyBold,
                                                              fontSize: 15,
                                                              color: BlackColor,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            myOrderController.nOrderInfo?.orderHistory[index].storeAddress ?? "",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.gilroyBold,
                                                              fontSize: 13,
                                                              color: BlackColor,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${currency}${myOrderController.nOrderInfo?.orderHistory[index].oTotal ?? ""}",
                                                            maxLines: 1,
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.gilroyBold,
                                                              fontSize: 15,
                                                              color: BlackColor,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          stepper(
                                              status: myOrderController
                                                  .nOrderInfo!
                                                  .orderHistory[
                                              index]
                                                  .status),

                                        ],
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color: WhiteColor,
                                        border: Border.all(
                                            color: Colors
                                                .grey
                                                .withOpacity(
                                                0.4)),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                                : Center(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No orders placed!"
                                        .tr,
                                    style: TextStyle(
                                      fontFamily:
                                      FontFamily
                                          .gilroyBold,
                                      color: BlackColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Currently you don’t have any orders."
                                        .tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily
                                          .gilroyMedium,
                                      color: greytext,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                          : SizedBox(),
                      homePageController
                          .homeInfo!.homeData.favlist.isNotEmpty
                          ? SizedBox(
                        height: 10,
                      )
                          : SizedBox(),
                      homePageController
                          .homeInfo!.homeData.favlist.isNotEmpty
                          ? Container(
                        width: Get.size.width,
                        color: WhiteColor,
                        padding:
                        EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Your favorites".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily:
                                  FontFamily.gilroyExtraBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "FastLaundry your love".tr,
                                    style: TextStyle(
                                      color: BlackColor,
                                      fontFamily:
                                      FontFamily.gilroyMedium,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Image.asset(
                                    "assets/heart.png",
                                    height: 18,
                                    width: 18,
                                    color: gradient.defoultColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              width: Get.size.width,
                              child: ListView.builder(
                                itemCount: homePageController
                                    .homeInfo
                                    ?.homeData
                                    .favlist
                                    .length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      catDetailsController.strId =
                                          homePageController
                                              .homeInfo
                                              ?.homeData
                                              .favlist[index]
                                              .storeId ??
                                              "";
                                      await storeDataContoller
                                          .getStoreData(
                                        storeId: homePageController
                                            .homeInfo
                                            ?.homeData
                                            .favlist[index]
                                            .storeId,
                                      );
                                      Get.to(
                                          CategoryDetailsScreen());
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 110,
                                          width: 90,
                                          margin: EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(15),
                                            child: FadeInImage
                                                .assetNetwork(
                                              placeholderCacheHeight:
                                              110,
                                              placeholderCacheWidth:
                                              90,
                                              placeholderFit:
                                              BoxFit.cover,
                                              placeholder:
                                              "assets/ezgif.com-crop.gif",
                                              image:
                                              "${Config.imageUrl}${homePageController.homeInfo?.homeData.favlist[index].storeCover ?? ""}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 95,
                                          child: Text(
                                            homePageController
                                                .homeInfo
                                                ?.homeData
                                                .favlist[index]
                                                .storeTitle ??
                                                "",
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FontFamily
                                                  .gilroyMedium,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              fontSize: 15,
                                              color: BlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: WhiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Shop by category".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily: FontFamily.gilroyExtraBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            homePageController.homeInfo!.homeData.catlist.length >= 2
                                ? Column(
                              children: [
                                homePageController.homeInfo!.homeData.catlist.length >= 2
                                    ? Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          await catDetailsController.getCatWiseData(catId: homePageController.homeInfo?.homeData.catlist[0].id ?? "");
                                          Get.toNamed(Routes.categoryScreen,
                                            arguments: {"catName": homePageController.homeInfo?.homeData.catlist[0].title ?? "",
                                              "catImag": homePageController.homeInfo?.homeData.catlist[0].cover ?? "",
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 130,
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 90,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12),
                                                  child: FadeInImage
                                                      .assetNetwork(
                                                    fadeInCurve: Curves
                                                        .easeInCirc,
                                                    placeholder:
                                                    "assets/ezgif.com-crop.gif",

                                                    placeholderCacheHeight:
                                                    80,
                                                    placeholderCacheWidth:
                                                    90,
                                                    placeholderFit:
                                                    BoxFit.fill,
                                                    // placeholderScale: 1.0,
                                                    image:
                                                    "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[0].img ?? ""}",
                                                    fit: BoxFit.fill,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                alignment:
                                                Alignment.center,
                                                child: Text(
                                                  homePageController
                                                      .homeInfo
                                                      ?.homeData
                                                      .catlist[0]
                                                      .title ??
                                                      "",
                                                  maxLines: 2,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FontFamily
                                                        .gilroyMedium,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          await catDetailsController
                                              .getCatWiseData(
                                              catId:
                                              homePageController
                                                  .homeInfo
                                                  ?.homeData
                                                  .catlist[
                                              1]
                                                  .id ??
                                                  "");
                                          Get.toNamed(
                                            Routes.categoryScreen,
                                            arguments: {
                                              "catName":
                                              homePageController
                                                  .homeInfo
                                                  ?.homeData
                                                  .catlist[1]
                                                  .title ??
                                                  "",
                                              "catImag":
                                              homePageController
                                                  .homeInfo
                                                  ?.homeData
                                                  .catlist[1]
                                                  .cover ??
                                                  "",
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 130,
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 90,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12),
                                                  child: FadeInImage
                                                      .assetNetwork(
                                                    fadeInCurve: Curves
                                                        .easeInCirc,
                                                    placeholder:
                                                    "assets/ezgif.com-crop.gif",

                                                    placeholderCacheHeight:
                                                    80,
                                                    placeholderCacheWidth:
                                                    90,
                                                    placeholderFit:
                                                    BoxFit.fill,
                                                    // placeholderScale: 1.0,
                                                    image:
                                                    "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[1].img ?? ""}",
                                                    fit: BoxFit.fill,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                alignment:
                                                Alignment.center,
                                                child: Text(
                                                  homePageController
                                                      .homeInfo
                                                      ?.homeData
                                                      .catlist[1]
                                                      .title ??
                                                      "",
                                                  maxLines: 2,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FontFamily
                                                        .gilroyMedium,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : SizedBox(),
                                homePageController.homeInfo!.homeData.catlist.isNotEmpty
                                    ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GridView.builder(
                                    itemCount: homePageController.homeInfo!.homeData.catlist.length - 2,
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 110,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 3,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          await catDetailsController.getCatWiseData(catId: homePageController.homeInfo?.homeData.catlist[index + 2].id ?? "");
                                          Get.toNamed(
                                            Routes.categoryScreen,
                                            arguments: {
                                              "catName": homePageController.homeInfo?.homeData.catlist[index + 2].title ??"",
                                              "catImag": homePageController.homeInfo?.homeData.catlist[index + 2].cover ?? "",
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(12),
                                                child: FadeInImage
                                                    .assetNetwork(
                                                  fadeInCurve:
                                                  Curves.easeInCirc,
                                                  placeholder:
                                                  "assets/ezgif.com-crop.gif",

                                                  placeholderCacheHeight:
                                                  80,
                                                  placeholderCacheWidth:
                                                  90,
                                                  placeholderFit:
                                                  BoxFit.fill,
                                                  // placeholderScale: 1.0,
                                                  image:
                                                  "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[index + 2].img ?? ""}",
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(12),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              alignment:
                                              Alignment.center,
                                              child: Text(
                                                homePageController
                                                    .homeInfo
                                                    ?.homeData
                                                    .catlist[
                                                index + 2]
                                                    .title ??
                                                    "",
                                                maxLines: 2,
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: FontFamily
                                                      .gilroyMedium,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                                    : Container(
                                  height: 200,
                                  width: Get.size.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "The category \nis unavailable in your area."
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 15,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(
                              alignment: Alignment.centerLeft,
                              height: 140,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: homePageController.homeInfo?.homeData.catlist.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      await catDetailsController.getCatWiseData(catId: homePageController.homeInfo?.homeData.catlist[index].id ?? "");
                                      Get.toNamed(Routes.categoryScreen,
                                        arguments: {"catName": homePageController.homeInfo?.homeData.catlist[index].title ?? "",
                                          "catImag": homePageController.homeInfo?.homeData.catlist[index].cover ?? "",
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 130,
                                      margin: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(12),
                                              child: FadeInImage
                                                  .assetNetwork(
                                                fadeInCurve: Curves
                                                    .easeInCirc,
                                                placeholder:
                                                "assets/ezgif.com-crop.gif",

                                                placeholderCacheHeight:
                                                80,
                                                placeholderCacheWidth:
                                                90,
                                                placeholderFit:
                                                BoxFit.fill,
                                                // placeholderScale: 1.0,
                                                image: "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[index].img ?? ""}",
                                                fit: BoxFit.fill,
                                                // fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            padding: EdgeInsets.only(left: 32),
                                            alignment:
                                            Alignment.centerLeft,
                                            child: Text(
                                              homePageController.homeInfo?.homeData.catlist[index].title ?? "",
                                              maxLines: 2,
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: FontFamily
                                                    .gilroyMedium,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                      ),
                                    ),
                                  );
                                },),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Shop by store".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily: FontFamily.gilroyExtraBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            homePageController.homeInfo!.homeData.topStore.isNotEmpty
                                ? SizedBox(
                              height: 240,
                              width: Get.size.width,
                              child: ListView.builder(
                                itemCount: homePageController
                                    .homeInfo
                                    ?.homeData
                                    .topStore
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      catDetailsController.strId =
                                          homePageController
                                              .homeInfo
                                              ?.homeData
                                              .topStore[index]
                                              .storeId ??
                                              "";
                                      await storeDataContoller
                                          .getStoreData(
                                        storeId: homePageController
                                            .homeInfo
                                            ?.homeData
                                            .topStore[index]
                                            .storeId,
                                      );
                                      save("changeIndex", true);
                                      homePageController.isback =
                                      "1";
                                      Get.to(
                                          CategoryDetailsScreen());
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 240,
                                          width: 250,
                                          margin: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    width: 290,
                                                    margin: EdgeInsets
                                                        .only(
                                                        left: 5,
                                                        right:
                                                        5,
                                                        top: 5),
                                                    child:
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                        "assets/ezgif.com-crop.gif",
                                                        placeholderCacheHeight:
                                                        180,
                                                        placeholderFit:
                                                        BoxFit
                                                            .fill,
                                                        image:
                                                        "${Config.imageUrl}${homePageController.homeInfo?.homeData.topStore[index].storeCover ?? ""}",
                                                        fit: BoxFit
                                                            .cover,
                                                      ),
                                                    ),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          offset:
                                                          const Offset(
                                                            0.5,
                                                            0.5,
                                                          ),
                                                          blurRadius:
                                                          0.5,
                                                          spreadRadius:
                                                          0.5,
                                                        ), //BoxShadow
                                                        BoxShadow(
                                                          color: Colors
                                                              .white,
                                                          offset: const Offset(
                                                              0.0,
                                                              0.0),
                                                          blurRadius:
                                                          0.0,
                                                          spreadRadius:
                                                          0.0,
                                                        ), //BoxShadow
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child:
                                                    Container(
                                                      height: 25,
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          8),
                                                      alignment:
                                                      Alignment
                                                          .center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Image
                                                              .asset(
                                                            "assets/ic_star_review.png",
                                                            height:
                                                            15,
                                                            width:
                                                            15,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            4,
                                                          ),
                                                          Text(
                                                            homePageController.homeInfo?.homeData.topStore[index].storeRate ??
                                                                "",
                                                            style:
                                                            TextStyle(
                                                              fontFamily:
                                                              FontFamily.gilroyMedium,
                                                              fontSize:
                                                              13,
                                                              color:
                                                              WhiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Color(
                                                            0xFF000000)
                                                            .withOpacity(
                                                            0.5),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                      ),
                                                    ),
                                                  ),
                                                  homePageController
                                                      .homeInfo
                                                      ?.homeData
                                                      .topStore[
                                                  index]
                                                      .couponTitle !=
                                                      "0" &&
                                                      homePageController
                                                          .homeInfo
                                                          ?.homeData
                                                          .topStore[index]
                                                          .couponTitle !=
                                                          ""
                                                      ? Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child:
                                                    Container(
                                                      height:
                                                      25,
                                                      padding:
                                                      EdgeInsets.symmetric(horizontal: 8),
                                                      alignment:
                                                      Alignment.center,
                                                      child:
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/percent-circle.svg",
                                                            height: 16,
                                                            width: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            homePageController.homeInfo?.homeData.topStore[index].couponTitle ?? "",
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.gilroyMedium,
                                                              fontSize: 13,
                                                              color: WhiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                      BoxDecoration(
                                                        color:
                                                        Color(0xFF000000).withOpacity(0.5),
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                  )
                                                      : SizedBox(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: Get.size
                                                      .width *
                                                      0.6,
                                                  child: Text(
                                                    homePageController
                                                        .homeInfo
                                                        ?.homeData
                                                        .topStore[
                                                    index]
                                                        .storeTitle ??
                                                        "",
                                                    maxLines: 1,
                                                    style:
                                                    TextStyle(
                                                      color:
                                                      BlackColor,
                                                      fontFamily:
                                                      FontFamily
                                                          .gilroyExtraBold,
                                                      fontSize: 20,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: Get.size
                                                      .width *
                                                      0.63,
                                                  child: Text(
                                                    homePageController
                                                        .homeInfo
                                                        ?.homeData
                                                        .topStore[
                                                    index]
                                                        .storeSlogan ??
                                                        "",
                                                    maxLines: 1,
                                                    style:
                                                    TextStyle(
                                                      color:
                                                      BlackColor,
                                                      fontFamily:
                                                      FontFamily
                                                          .gilroyMedium,
                                                      fontSize: 14,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors
                                                    .grey.shade300),
                                            borderRadius:
                                            BorderRadius
                                                .circular(15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                                : Container(
                              height: 200,
                              width: Get.size.width,
                              alignment: Alignment.center,
                              child: Text(
                                "No store available \nin your area."
                                    .tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 15,
                                  color: BlackColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : SizedBox(
                    height: Get.size.height,
                    width: Get.size.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: gradient.defoultColor,
                      ),
                    ),
                  );
                }),
          ),
          // Existing SliverAppBar and other UI components remain unchanged


          // New Code: Nearby Laundromats Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search Nearby Laundromats",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => laundryController.searchLaundromats(value),
              ),
            ),
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
              return SizedBox(
                height: 180, // Adjust height based on design
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  itemCount: laundryController.filteredLaundromats.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: (context, index) {
                    Laundry laundry = laundryController.filteredLaundromats[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ServicesScreen(laundry: laundry));
                      },
                      child: Container(
                        width: 220, // Adjust width as needed
                        margin: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
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
