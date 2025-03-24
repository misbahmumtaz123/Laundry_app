import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:laundry/controller/product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/config.dart';
import '../model/laundryment_search_model.dart';

class LaundryController extends GetxController {
  var laundromats = <Laundry>[].obs;
  var filteredLaundromats = <Laundry>[].obs;
  var isLoading = true.obs;

  // Fetch laundromats using latitude and longitude
  Future<void> fetchLaundromats(double latitude, double longitude) async {
    final String url = '${Config.baseurl}${Config.getLaundromatsApi}';

    try {
      isLoading(true);
      print('🧼🧴 Fetching laundromats from: $url');
      print('🌍 With latitude: $latitude, longitude: $longitude');

      var response = await Dio().get(url, queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
      });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('✔ Fetched laundromats data: $data');

        laundromats.value = data.map((json) => Laundry.fromJson(json)).toList();
        filteredLaundromats.value = laundromats;
        print('✅ Laundromats loaded successfully');
      } else {
        print('❌ Failed to load laundromats, status code: ${response.statusCode}');
        throw Exception('Failed to load laundromats');
      }
    } catch (e) {
      print('⚠ Error fetching laundromats: $e');
    } finally {
      isLoading(false);
      print('🛑 Finished loading laundromats');
    }
  }

  // Save selected laundromat ID to SharedPreferences
  Future<void> saveSelectedLaundromatId(String laundromatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('💾 Saving laundromat ID: $laundromatId');
    await prefs.setString('laundromat_id', laundromatId);  // Save the selected laundromat ID
    print('✅ Laundromat ID saved successfully');

    // Verifying by checking if it is indeed saved
    String? savedId = prefs.getString('laundromat_id');
    print('🔑 Saved laundromat ID from SharedPreferences: $savedId');

    // Trigger fetch products from ProductController after saving the laundromat ID
   // Get.find<ProductController>().fetchProducts();
  }

  // Retrieve selected laundromat ID from SharedPreferences
  Future<String?> getSelectedLaundromatId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? laundromatId = prefs.getString('laundromat_id');
    print('🔄 Retrieved laundromat ID from SharedPreferences: $laundromatId');
    return laundromatId;
  }

  // Search laundromats based on a query
  void searchLaundromats(String query) {
    print('🔍 Searching laundromats with query: $query');
    if (query.isEmpty) {
      filteredLaundromats.value = laundromats;
      print('❓ Query is empty, showing all laundromats');
    } else {
      filteredLaundromats.value = laundromats.where((laundromat) =>
          laundromat.name.toLowerCase().contains(query.toLowerCase())).toList();
      print('🔎 Filtered laundromats: ${filteredLaundromats.map((laundromat) => laundromat.name).toList()}');
    }
  }
}
//// lang latttttttttttttttttttttttttttttttttttttttttttt
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:laundry/controller/product_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:laundry/Api/config.dart';
// import 'package:laundry/model/laundryment_search_model.dart';
//
// class LaundryController extends GetxController {
//   var laundromats = <Laundry>[].obs;
//   var filteredLaundromats = <Laundry>[].obs;
//   var isLoading = true.obs;
//
//   // Fetch laundromats using latitude and longitude
//   Future<void> fetchLaundromats(double latitude, double longitude) async {
//     final String url = '${Config.baseurl}${Config.getLaundromatsApi}';
//
//     try {
//       isLoading(true);
//       var response = await Dio().get(url, queryParameters: {
//         'latitude': latitude,
//         'longitude': longitude,
//       });
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         laundromats.value = data.map((json) => Laundry.fromJson(json)).toList();
//         filteredLaundromats.value = laundromats;
//       } else {
//         throw Exception('Failed to load laundromats');
//       }
//     } catch (e) {
//       print('Error fetching laundromats: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Save selected laundromat ID to SharedPreferences
//   Future<void> saveSelectedLaundromatId(String laundromatId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('laundromat_id', laundromatId);
//
//     // Trigger fetch products from ProductController after saving the laundromat ID
//     Get.find<ProductController>().fetchProducts();
//   }
//
//   // Retrieve selected laundromat ID from SharedPreferences
//   Future<String?> getSelectedLaundromatId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('laundromat_id');
//   }
//
//   // Search laundromats based on a query
//   void searchLaundromats(String query) {
//     if (query.isEmpty) {
//       filteredLaundromats.value = laundromats;
//     } else {
//       filteredLaundromats.value = laundromats.where((laundromat) =>
//           laundromat.name.toLowerCase().contains(query.toLowerCase())).toList();
//     }
//   }
// }
