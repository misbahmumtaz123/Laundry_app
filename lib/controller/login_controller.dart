import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/data_store.dart';
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

  /// ✅ Toggle Remember Me Checkbox
  void changeRememberMe(bool? value) {
    isChecked = value ?? false;
    update();
  }

  /// ✅ Toggle Password Visibility
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

  /// ✅ Handle User Login and Save Token & Customer ID
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

      var response = await dioApi.sendRequest.post(uri, data: jsonEncode(map));

      print("🟢 API Response: ${response.data}");

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

  /// ✅ Save User Data After Successful Login
  Future<void> _saveUserData(Map<String, dynamic> userLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userLogin.isNotEmpty) {
      await prefs.setString('UserLogin', jsonEncode(userLogin)); // ✅ Save full user data
      getData.write("UserLogin", userLogin); // ✅ Ensure data is available globally

      // ✅ Save Security Token
      String? token = userLogin["security_token"];
      if (token != null && token.isNotEmpty) {
        await prefs.setString('auth_token', token);
        print("✅ Security Token Saved: $token");
      } else {
        print("⚠ Warning: No security token found!");
      }

      // ✅ Save Customer ID
      String? customerId = userLogin["id"];
      if (customerId != null && customerId.isNotEmpty) {
        await prefs.setString('customer_id', customerId);
        print("✅ Customer ID Saved: $customerId");

        // ✅ OneSignal Push Notification User Tag
        OneSignal.User.addTagWithKey("userid", customerId);
      } else {
        print("⚠ Warning: No customer ID found!");
      }

      print("✅ User Data Saved Successfully!");
    } else {
      print("❌ Warning: UserLogin data is empty!");
    }
  }

  /// ✅ Retrieve Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    print("🔍 Retrieved Security Token: $token");
    return token;
  }

  /// ✅ Retrieve Customer ID
  Future<String?> getCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString('customer_id');
    print("🔍 Retrieved Customer ID: $customerId");
    return customerId;
  }

  /// ✅ Handle Forgot Password API
  Future<void> setForgetPasswordApi({String? mobile, String? ccode}) async {
    try {
      Map<String, dynamic> map = {
        "mobile": mobile,
        "password": newPassword.text,
        "ccode": ccode,
      };

      const String uri = "https://laundry.saleselevation.tech/user_api/u_login_user.php";
      print("🔵 Forgot Password API URL: $uri");

      var response = await dioApi.sendRequest.post(uri, data: jsonEncode(map));

      print("🟢 Forgot Password API Response: ${response.data}");

      var result = response.data is String
          ? jsonDecode(response.data) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      forgetPasswprdResult = result["Result"] ?? "false";
      forgetMsg = result["ResponseMsg"] ?? "Unknown response";

      if (forgetPasswprdResult == "true") {
        Get.toNamed(Routes.loginScreen);
        showToastMessage(forgetMsg);
      }
    } catch (e) {
      print("❌ Forgot Password API Error: ${e.toString()}");
    }
  }
}
