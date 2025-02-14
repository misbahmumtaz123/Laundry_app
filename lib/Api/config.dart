
class Config {
  static const String baseurl = 'https://laundry.saleselevation.tech/';
  static const String path = baseurl + 'user_api/';
  static const String laundryApiPath = baseurl + 'laundry_api/';
  static const String imageUrl = baseurl;

  // Correctly define the orderApi with the base URL
  static const String orderApi = '${baseurl}order_api/order.php';

  static const paymentBaseUrl = baseurl;

  static const String googleKey = "AIzaSyBgQqPY151izYpElaCaOr3jtsREsV6H9tQ";

  static const String oneSignel = "******************";
  static const String loginApi = 'u_login_user.php';

  static const String registerUser = 'u_reg_user.php';
  static const String mobileChack = 'mobile_check.php';
  static const String forgetPassword = 'u_forget_password.php';
  static const String homeDataApi = 'u_home_data.php';
  static const String catWiseData = 'u_cat_wise_store.php';
  static const String storeData = 'u_store_data.php';
  static const String pageList = "u_pagelist.php";
  static const String addressList = "address_list.php";
  static const String addAddress = "add_address.php";
  static const String produtsInformetion = "u_product_data.php";
  static const String favAndRemoveApi = "u_fav.php";
  static const String cartDataApi = "u_cart_data.php";
  static const String couponList = "u_couponlist.php";
  static const String couponCheck = "u_check_coupon.php";
  static const String paymentList = "u_paymentgateway.php";
  static const String orderNow = "u_order_now.php";
  static const String myOrderHistory = "u_order_history.php";
  static const String orderInformetion = "u_order_information.php";
  static const String orderCancle = "cancel_order.php";
  static const String orderReview = "u_rate_update.php";

  static const String makeDecision = "make_decision.php";

  static const String priOrderReview = "u_prate_update.php";

  static const String walletReportApi = "u_wallet_report.php";
  static const String walletUpdateApi = 'u_wallet_up.php';

  static const String storeSearchApi = "u_search_store.php";
  static const String productSearch = 'u_product_search.php';

  static const String profileEdit = "u_profile_edit.php";
  static const String referDataGetApi = 'u_getdata.php';
  static const String deletAccount = 'acc_delete.php';

  static const String notification = 'u_notification_list.php';

  static const String dayDeliveryListApi = 'd_deliverylist.php';

  static const String normalOrderApi = 'd_order_now.php';
  static const String subScriptionOrderApi = 'd_order_now.php';

  static const String timeSlotListApi = 'd_timeslot.php';

  static const String normalOrderHistory = 'd_order_history.php';
  static const String normalOrderInfo = 'd_order_product_list.php';

  static const String subScriptionHistory = 'd_subscribe_order_history.php';
  static const String subScriptionInfo = 'd_sub_order_product_list.php';

  static const String skipAndExtend = 'skip_extend.php';
  static const String mapZone = 'getzone.php';

  static const String smsType = 'sms_type.php';
  static const String msgOtp = 'msg_otp.php';
  static const String twilioOtp = 'twilio_otp.php';
  static String payStack = "paystack/index.php";

  // Laundry-specific API
  static const String addLaundryApi = 'add_laundry.php';

  // Added specific API for fetching laundromats by location
  static const String getLaundromatsApi =
      'user_api/get_laundry_by_use.php?latitude=24.92994926038695&longitude=67.07463296801761';

  // New API for fetching all laundry orders
  static const String getAllOrdersApi = '${path}u_get_all_orders.php';

  // New API for fetching all completed laundry orders
  static const String getAllCompletedOrdersApi = '${path}get_all_completed_orders.php';
}

