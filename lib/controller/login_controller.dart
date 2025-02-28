// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:laundry/Api/dio_api.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:laundry/Api/config.dart';
// import 'package:laundry/Api/data_store.dart';
// import 'package:laundry/helpar/routes_helper.dart';
// import 'package:laundry/utils/Custom_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginController extends GetxController implements GetxService {
//   TextEditingController number = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   TextEditingController newPassword = TextEditingController();
//   TextEditingController newConformPassword = TextEditingController();
//   final dioApi = Api();
//   bool showPassword = true;
//   bool newShowPassword = true;
//   bool conformPassword = true;
//   bool isChecked = false;
//
//   String userMessage = "";
//   String resultCheck = "";
//
//   String forgetPasswprdResult = "";
//   String forgetMsg = "";
//
//   changeRememberMe(bool? value) {
//     isChecked = value ?? false;
//     update();
//   }
//
//   showOfPassword() {
//     showPassword = !showPassword;
//     update();
//   }
//
//   newShowOfPassword() {
//     newShowPassword = !newShowPassword;
//     update();
//   }
//
//   newConformShowOfPassword() {
//     conformPassword = !conformPassword;
//     update();
//   }
//
//   /// **Get Login API Data and Save Token & Customer ID**
//   Future<void> getLoginApiData(String countryCode) async {
//     try {
//       Map<String, dynamic> map = {
//         "mobile": number.text,
//         "ccode": countryCode,
//         "password": password.text,
//       };
//
//       print("Request Payload: $map");
//       String uri = Config.path + Config.loginApi;
//       print("Login API URL: $uri");
//
//       var response = await dioApi.sendRequest.post(
//         uri,
//         data: jsonEncode(map),
//       );
//
//       print("API Response: ${response.data}");
//
//       if (response.statusCode == 200) {
//         var result = response.data is String ? jsonDecode(response.data) : response.data;
//         userMessage = result["ResponseMsg"];
//         resultCheck = result["Result"];
//
//         showToastMessage(userMessage);
//
//         if (resultCheck == "true") {
//           print("✅ Login Successful! Saving user data...");
//
//           var userLogin = result["UserLogin"];
//           if (userLogin != null && userLogin is Map) {
//             String? token = userLogin["security_token"];
//             String? customerId = userLogin["id"]; // ✅ Extract Customer ID
//
//             if (token != null && token.isNotEmpty) {
//               await saveToken(token);
//               print("✅ Token Successfully Saved: $token");
//
//               String? savedToken = await getToken();
//               print("🔍 Retrieved Token After Saving: $savedToken");
//             } else {
//               print("⚠️ Warning: No security token found in response!");
//             }
//
//             if (customerId != null && customerId.isNotEmpty) {
//               await saveCustomerId(customerId);
//               print("✅ Customer ID Successfully Saved: $customerId");
//
//               String? savedCustomerId = await getCustomerId();
//               print("🔍 Retrieved Customer ID After Saving: $savedCustomerId");
//             } else {
//               print("⚠️ Warning: No customer ID found in response!");
//             }
//           } else {
//             print("❌ Error: 'UserLogin' is null or not a valid object!");
//           }
//
//           // **Navigate to Home Screen**
//           Get.offAllNamed(Routes.homeScreen);
//
//           // Reset Fields
//           number.text = "";
//           password.text = "";
//           isChecked = false;
//           update();
//         }
//
//         // Save other user data
//         save("UserLogin", result["UserLogin"]);
//
//         // OneSignal Push Notification User Tag
//         OneSignal.User.addTagWithKey("userid", getData.read("UserLogin")["id"]);
//         update();
//       }
//     } catch (e) {
//       print("❌ Login API Error: ${e.toString()}");
//     }
//   }
//
//   /// **Save Token to SharedPreferences**
//   Future<void> saveToken(String token) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('auth_token', token);
//       print("✅ Token saved to SharedPreferences: $token");
//     } catch (e) {
//       print("❌ Error saving token: ${e.toString()}");
//     }
//   }
//
//   /// **Retrieve Token for API Requests**
//   Future<String?> getToken() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');
//       print("🔍 Retrieved Token from SharedPreferences: $token");
//       return token;
//     } catch (e) {
//       print("❌ Error retrieving token: ${e.toString()}");
//       return null;
//     }
//   }
//
//   /// **Save Customer ID to SharedPreferences**
//   Future<void> saveCustomerId(String customerId) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('customer_id', customerId);
//       print("✅ Customer ID saved to SharedPreferences: $customerId");
//     } catch (e) {
//       print("❌ Error saving customer ID: ${e.toString()}");
//     }
//   }
//
//   /// **Retrieve Customer ID for API Requests**
//   Future<String?> getCustomerId() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? customerId = prefs.getString('customer_id');
//       print("🔍 Retrieved Customer ID from SharedPreferences: $customerId");
//       return customerId;
//     } catch (e) {
//       print("❌ Error retrieving customer ID: ${e.toString()}");
//       return null;
//     }
//   }
//
//   /// **Forgot Password API**
//   Future<void> setForgetPasswordApi({String? mobile, String? ccode}) async {
//     try {
//       Map<String, dynamic> map = {
//         "mobile": mobile,
//         "ccode": ccode,
//         "password": newPassword.text,
//       };
//
//       String uri = Config.path + Config.forgetPassword;
//       var response = await dioApi.sendRequest.post(
//         uri,
//         data: jsonEncode(map),
//       );
//
//       if (response.statusCode == 200) {
//         var result = response.data is String ? jsonDecode(response.data) : response.data;
//         forgetPasswprdResult = result["Result"];
//         forgetMsg = result["ResponseMsg"];
//
//         if (forgetPasswprdResult == "true") {
//           Get.toNamed(Routes.loginScreen);
//           showToastMessage(forgetMsg);
//         }
//       }
//     } catch (e) {
//       print("❌ Forgot Password API Error: ${e.toString()}");
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/dio_api.dart';
import '../helpar/routes_helper.dart';
import '../utils/Custom_widget.dart';

class LoginController extends GetxController implements GetxService {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController newPassword = TextEditingController();
  TextEditingController newConformPassword = TextEditingController();
  final dioApi = Api();
  bool showPassword = true;
  bool newShowPassword = true;
  bool conformPassword = true;
  bool isChecked = false;

  String userMessage = "";
  String resultCheck = "";

  String forgetPasswprdResult = "";
  String forgetMsg = "";

  void changeRememberMe(bool? value) {
    isChecked = value ?? false;
    update();
  }

  void showOfPassword() {
    showPassword = !showPassword;
    update();
  }

  void newShowOfPassword() {
    newShowPassword = !newShowPassword;
    update();
  }

  void newConformShowOfPassword() {
    conformPassword = !conformPassword;
    update();
  }

  /// Get Login API Data and Save Token & Customer ID
  Future<void> getLoginApiData(String countryCode) async {
    try {
      Map<String, dynamic> map = {
        "mobile": number.text.trim(),
        "password": password.text.trim(),
        "ccode": countryCode.trim(),
      };

      print("🔵 Request Payload: ${jsonEncode(map)}");

      const String uri = "https://laundry.saleselevation.tech/user_api/u_login_user.php";
      print("🔵 Login API URL: $uri");

      var response = await dioApi.sendRequest.post(
        uri,
        data: jsonEncode(map),
      );

      print("🟢 API Response: ${response.data}");

      // ✅ Fix: Explicitly cast response to Map<String, dynamic>
      var result = response.data is String
          ? jsonDecode(response.data) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      userMessage = result["ResponseMsg"] ?? "Unknown response";
      resultCheck = result["Result"] ?? "false";

      showToastMessage(userMessage);

      if (resultCheck == "true") {
        print("✅ Login Successful! Saving user data...");

        var userLogin = result["UserLogin"];
        if (userLogin != null && userLogin is Map<String, dynamic>) {
          await _saveUserData(userLogin);
        } else {
          print("❌ Error: 'UserLogin' is missing in the response!");
        }

        // Navigate to Home Screen
        Get.offAllNamed(Routes.homeScreen);

        // Reset Fields
        number.clear();
        password.clear();
        isChecked = false;
        update();
      }
    } catch (e) {
      print("❌ Login API Error: ${e.toString()}");
      showToastMessage("Something went wrong. Please try again.");
    }
  }

  /// Save User Data
  Future<void> _saveUserData(Map<String, dynamic> userLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = userLogin["security_token"];
    String? customerId = userLogin["id"];

    if (token != null && token.isNotEmpty) {
      await prefs.setString('auth_token', token);
      print("✅ Token Saved: $token");
    } else {
      print("⚠ Warning: No security token found!");
    }

    if (customerId != null && customerId.isNotEmpty) {
      await prefs.setString('customer_id', customerId);
      print("✅ Customer ID Saved: $customerId");
    } else {
      print("⚠ Warning: No customer ID found!");
    }

    // OneSignal Push Notification User Tag
    OneSignal.User.addTagWithKey("userid", customerId ?? "Unknown");
  }

  /// Retrieve Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Retrieve Customer ID
  Future<String?> getCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customer_id');
  }

  /// Forgot Password API
  Future<void> setForgetPasswordApi({String? mobile, String? ccode}) async {
    try {
      Map<String, dynamic> map = {
        "mobile": mobile,
        "password": newPassword.text,
        "ccode": ccode,
      };

      const String uri = "https://laundry.saleselevation.tech/user_api/u_login_user.php";
      print("🔵 Forgot Password API URL: $uri");

      var response = await dioApi.sendRequest.post(
        uri,
        data: jsonEncode(map),
      );

      print("🟢 Forgot Password API Response: ${response.data}");

      // ✅ Fix: Explicitly cast response to Map<String, dynamic>
      var result = response.data is String
          ? jsonDecode(response.data) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      forgetPasswprdResult = result["Result"];
      forgetMsg = result["ResponseMsg"];

      if (forgetPasswprdResult == "true") {
        Get.toNamed(Routes.loginScreen);
        showToastMessage(forgetMsg);
      }
    } catch (e) {
      print("❌ Forgot Password API Error: ${e.toString()}");
    }
  }
}
