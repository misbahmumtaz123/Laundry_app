// // // import 'package:get/get.dart';
// // // import 'package:dio/dio.dart';
// // // import '../Api/config.dart';
// // // import '../model/product_model.dart';
// // //
// // // class ProductController extends GetxController {
// // //   var products = <Product>[].obs; // Stores all available products from API
// // //   var selectedProduct = Rxn<Product>(); // Stores the currently selected product
// // //   var isLoading = false.obs;
// // //
// // //   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
// // //
// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchProducts();
// // //   }
// // //
// // //   Future<void> fetchProducts() async {
// // //     try {
// // //       isLoading(true);
// // //       final response = await _dio.post(
// // //         Config.getProductsLaundryApi,
// // //         options: Options(headers: {"Content-Type": "application/json"}),
// // //         data: {"laundromat_id": "2"},
// // //       );
// // //
// // //       if (response.statusCode == 200) {
// // //         final data = response.data;
// // //         if (data['Result'] == 'true' && data['Products'] is List) {
// // //           // Debugging: Inspect the products fetched from the API
// // //           print('Fetched products: ${data['Products']}');
// // //           products.value = (data['Products'] as List).map((product) {
// // //             double basePrice = double.tryParse(product['base_price'].toString().trim()) ?? 0.0;
// // //             if (basePrice == 0.0) {
// // //               print('Base price for ${product['product_name']} is invalid, setting it to 0');
// // //             } else {
// // //               print('Base price for ${product['product_name']} is valid: $basePrice');
// // //             }
// // //             return Product(
// // //               productEntryId: product['product_entry_id'],
// // //               laundromatId: product['laundromat_id'],
// // //               productId: product['product_id'],
// // //               basePrice: basePrice,
// // //               productName: product['product_name'],
// // //               additionalInfo: product['additional_info'],
// // //             );
// // //           }).toList();
// // //         } else {
// // //           Get.snackbar('Error', 'No products found!');
// // //         }
// // //       } else {
// // //         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
// // //       }
// // //     } catch (e) {
// // //       print('Error fetching products: $e');
// // //       Get.snackbar('Error', 'Failed to fetch products: $e');
// // //     } finally {
// // //       isLoading(false);
// // //     }
// // //   }
// // //
// // //   void selectProduct(Product product) {
// // //     selectedProduct.value = product;
// // //   }
// // //
// // //   // Function to calculate the total price of a product based on quantity, selected type, and weight
// // //   double calculateTotalPrice(Product product, int quantity, String selectedType, double? weight) {
// // //     double price = product.basePrice;
// // //
// // //     // Debugging: Check if the price is correct before calculating the total price
// // //     print('Calculating total price for product: ${product.productName}');
// // //     print('Base price: ${product.basePrice}, Quantity: $quantity, Type: $selectedType, Weight: $weight');
// // //
// // //     // If it's a "Clothes" product, calculate price based on weight
// // //     if (product.productName == "Clothes" && weight != null && weight > 0) {
// // //       price = product.basePrice * weight;
// // //       print('Clothes price calculated based on weight: $price');
// // //     } else if (product.productName == "Blanket" || product.productName == "Comforter") {
// // //       // If Single or Double, adjust price accordingly
// // //       if (selectedType == "Double") {
// // //         price = product.basePrice * 2; // Double the price for Double bed type
// // //         print('Price adjusted for Double type: $price');
// // //       }
// // //     }
// // //
// // //     // Multiply by quantity to get the final total price
// // //     double totalPrice = price * quantity;
// // //
// // //     // Debugging: Print the final calculated price
// // //     print('Final total price: $totalPrice');
// // //
// // //     return totalPrice;
// // //   }
// // // }
// // //
// // //bbbbeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefore
// // // import 'package:get/get.dart';
// // // import 'package:dio/dio.dart';
// // // import '../Api/config.dart';
// // // import '../model/product_model.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // class ProductController extends GetxController {
// // //   var products = <Product>[].obs; // Stores all available products from API
// // //   var selectedProduct = Rxn<Product>(); // Stores the currently selected product
// // //   var isLoading = false.obs;
// // //
// // //   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
// // //
// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchProducts();
// // //   }
// // //
// // //   // Function to fetch products based on the selected laundromat ID
// // //   Future<void> fetchProducts() async {
// // //     try {
// // //       isLoading(true);
// // //
// // //       // Retrieve the selected laundromat ID from SharedPreferences
// // //       String? laundromatId = await getSelectedLaundromatId();
// // //       print('🧼 Selected laundromat ID retrieved: $laundromatId');  // Debugging the laundromat ID
// // //
// // //       if (laundromatId == null) {
// // //         Get.snackbar('Error', 'No laundromat selected');
// // //         return;
// // //       }
// // //
// // //       // API request to fetch products for the selected laundromat
// // //       final response = await _dio.post(
// // //         Config.getProductsLaundryApi,
// // //         options: Options(headers: {"Content-Type": "application/json"}),
// // //         data: {"laundromat_id": laundromatId},  // Dynamically use the retrieved laundromat ID
// // //       );
// // //
// // //       if (response.statusCode == 200) {
// // //         final data = response.data;
// // //         if (data['Result'] == 'true' && data['Products'] is List) {
// // //           // Debugging: Inspect the products fetched from the API
// // //           print('✔️ Fetched products: ${data['Products']}');
// // //           products.value = (data['Products'] as List).map((product) {
// // //             double basePrice = double.tryParse(product['base_price'].toString().trim()) ?? 0.0;
// // //             return Product(
// // //               productEntryId: product['product_entry_id'],
// // //               laundromatId: product['laundromat_id'],
// // //               productId: product['product_id'],
// // //               basePrice: basePrice,
// // //               productName: product['product_name'],
// // //               additionalInfo: product['additional_info'],
// // //             );
// // //           }).toList();
// // //         } else {
// // //           Get.snackbar('Error', 'No products found!');
// // //           print('⚠️ Error: No products found');
// // //         }
// // //       } else {
// // //         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
// // //         print('❌ Error: Server returned status code ${response.statusCode}');
// // //       }
// // //     } catch (e) {
// // //       print('⚠️ Error fetching products: $e');
// // //       Get.snackbar('Error', 'Failed to fetch products: $e');
// // //     } finally {
// // //       isLoading(false);
// // //       print('🛑 Finished fetching products');
// // //     }
// // //   }
// // //
// // //   // Function to retrieve the selected laundromat ID from SharedPreferences
// // //   Future<String?> getSelectedLaundromatId() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     String? laundromatId = prefs.getString('laundromat_id');
// // //     print('🔄 Retrieved laundromat ID from SharedPreferences for products: $laundromatId');  // Debugging
// // //     return laundromatId;
// // //   }
// // //
// // //   // Function to calculate the total price of a product based on quantity, selected type, and weight
// // //   double calculateTotalPrice(Product product, int quantity, String selectedType, double? weight) {
// // //     double price = product.basePrice;
// // //
// // //     // Debugging: Check if the price is correct before calculating the total price
// // //     print('Calculating total price for product: ${product.productName}');
// // //     print('Base price: ${product.basePrice}, Quantity: $quantity, Type: $selectedType, Weight: $weight');
// // //
// // //     // If it's a "Clothes" product, calculate price based on weight
// // //     if (product.productName == "Clothes" && weight != null && weight > 0) {
// // //       price = product.basePrice * weight;
// // //       print('Clothes price calculated based on weight: $price');
// // //     } else if (product.productName == "Blanket" || product.productName == "Comforter") {
// // //       // If Single or Double, adjust price accordingly
// // //       if (selectedType == "Double") {
// // //         price = product.basePrice * 2; // Double the price for Double bed type
// // //         print('Price adjusted for Double type: $price');
// // //       }
// // //     }
// // //
// // //     // Multiply by quantity to get the final total price
// // //     double totalPrice = price * quantity;
// // //
// // //     // Debugging: Print the final calculated price
// // //     print('Final total price: $totalPrice');
// // //
// // //     return totalPrice;
// // //   }
// // // }
// // // Myyyyy last modify code
// // // import 'package:get/get.dart';
// // // import 'package:dio/dio.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // import '../Api/config.dart';
// // // import '../model/product_model.dart';
// // //
// // //
// // // class ProductController extends GetxController {
// // //   var products = <Product>[].obs; // Stores all available products from API
// // //   var selectedProduct = Rxn<Product>(); // Stores the currently selected product
// // //   var isLoading = false.obs;
// // //
// // //   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
// // //
// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchProducts();
// // //   }
// // //
// // //   // Function to fetch products based on the selected laundromat ID
// // //   Future<void> fetchProducts() async {
// // //     try {
// // //       isLoading(true);
// // //
// // //       // Retrieve the selected laundromat ID from SharedPreferences
// // //       String? laundromatId = await getSelectedLaundromatId();
// // //       print('🧼 Selected laundromat ID retrieved: $laundromatId');  // Debugging the laundromat ID
// // //
// // //       if (laundromatId == null) {
// // //         Get.snackbar('Error', 'No laundromat selected');
// // //         return;
// // //       }
// // //
// // //       // API request to fetch products for the selected laundromat
// // //       final response = await _dio.post(
// // //         Config.getProductsLaundryApi,
// // //         options: Options(headers: {"Content-Type": "application/json"}),
// // //         data: {"laundromat_id": laundromatId},  // Dynamically use the retrieved laundromat ID
// // //       );
// // //
// // //       if (response.statusCode == 200) {
// // //         final data = response.data;
// // //         if (data['Result'] == 'true' && data['Products'] is List) {
// // //           // Debugging: Inspect the products fetched from the API
// // //           print('✔ Fetched products: ${data['Products']}');
// // //           products.value = (data['Products'] as List).map((product) {
// // //             double basePrice = double.tryParse(product['base_price'].toString().trim()) ?? 0.0;
// // //             return Product(
// // //               productEntryId: product['product_entry_id'],
// // //               laundromatId: product['laundromat_id'],
// // //               productId: product['product_id'],
// // //               basePrice: basePrice,
// // //               productName: product['product_name'],
// // //               additionalInfo: product['additional_info'],
// // //             );
// // //           }).toList();
// // //         } else {
// // //           Get.snackbar('Error', 'No products found!');
// // //           print('⚠ Error: No products found');
// // //         }
// // //       } else {
// // //         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
// // //         print('❌ Error: Server returned status code ${response.statusCode}');
// // //       }
// // //     } catch (e) {
// // //       print('⚠ Error fetching products: $e');
// // //       Get.snackbar('Error', 'Failed to fetch products: $e');
// // //     } finally {
// // //       isLoading(false);
// // //       print('🛑 Finished fetching products');
// // //     }
// // //   }
// // //
// // //   // Function to retrieve the selected laundromat ID from SharedPreferences
// // //   Future<String?> getSelectedLaundromatId() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     String? laundromatId = prefs.getString('3');
// // //     print('🔄 Retrieved laundromat ID from SharedPreferences for products: $laundromatId');  // Debugging
// // //     return laundromatId;
// // //   }
// // //
// // //   // Function to calculate the total price of a product based on quantity, selected type, and weight
// // //   double calculateTotalPrice(Product product, int quantity, String selectedType, double? weight) {
// // //     double price = product.basePrice;
// // //
// // //     // Debugging: Check if the price is correct before calculating the total price
// // //     print('Calculating total price for product: ${product.productName}');
// // //     print('Base price: ${product.basePrice}, Quantity: $quantity, Type: $selectedType, Weight: $weight');
// // //
// // //     // If it's a "Clothes" product, calculate price based on weight
// // //     if (product.productName == "Clothes" && weight != null && weight > 0) {
// // //       price = product.basePrice * weight;
// // //       print('Clothes price calculated based on weight: $price');
// // //     } else if (product.productName == "Blanket" || product.productName == "Comforter") {
// // //       // If Single or Double, adjust price accordingly
// // //       if (selectedType == "Double") {
// // //         price = product.basePrice * 2; // Double the price for Double bed type
// // //         print('Price adjusted for Double type: $price');
// // //       }
// // //     }
// // //
// // //     // Multiply by quantity to get the final total price
// // //     double totalPrice = price * quantity;
// // //
// // //     // Debugging: Print the final calculated price
// // //     print('Final total price: $totalPrice');
// // //
// // //     return totalPrice;
// // //   }
// // // }
// // //emannnnnnnnnnnnnnnnnnnnnnnnnn
// // import 'package:get/get.dart';
// // import 'package:dio/dio.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import '../Api/config.dart';
// // import '../model/product_model.dart';
// //
// // class ProductController extends GetxController {
// //   var products = <Product>[].obs; // Stores all available products from API
// //   var selectedProduct = Rxn<Product>(); // Stores the currently selected product
// //   var isLoading = false.obs;
// //
// //   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //   }
// //
// //   // Fetch products based on laundromat ID passed from ServicesScreen or PlaceOrderScreen
// //   Future<void> fetchProductsByLaundromat(String laundromatId) async {
// //     try {
// //       isLoading(true);
// //       print("🧼 Fetching products for laundromat ID: $laundromatId");
// //
// //       // API request to fetch products for the selected laundromat
// //       final response = await _dio.post(
// //         Config.getProductsLaundryApi,
// //         options: Options(headers: {"Content-Type": "application/json"}),
// //         data: {"laundromat_id": laundromatId}, // Use dynamic laundromat ID
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final data = response.data;
// //         if (data['Result'] == 'true' && data['Products'] is List) {
// //           print('✔ Fetched products: ${data['Products']}');
// //
// //           // Map the response into Product objects
// //           products.value = (data['Products'] as List).map((product) {
// //             double basePrice = double.tryParse(product['base_price'].toString().trim()) ?? 0.0;
// //             return Product(
// //               productEntryId: product['product_entry_id'],
// //               laundromatId: product['laundromat_id'],
// //               productId: product['product_id'],
// //               basePrice: basePrice,
// //               productName: product['product_name'],
// //               additionalInfo: product['additional_info'],
// //             );
// //           }).toList();
// //         } else {
// //           Get.snackbar('Error', 'No products found!');
// //           print('⚠ Error: No products found');
// //         }
// //       } else {
// //         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
// //         print('❌ Error: Server returned status code ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('⚠ Error fetching products: $e');
// //       Get.snackbar('Error', 'Failed to fetch products: $e');
// //     } finally {
// //       isLoading(false);
// //       print('🛑 Finished fetching products');
// //     }
// //   }
// //
// //   // Function to calculate the total price of a product based on quantity, selected type, and weight
// //   double calculateTotalPrice(Product product, int quantity, String selectedType, double? weight) {
// //     double price = product.basePrice;
// //
// //     // Debugging: Check if the price is correct before calculating the total price
// //     print('Calculating total price for product: ${product.productName}');
// //     print('Base price: ${product.basePrice}, Quantity: $quantity, Type: $selectedType, Weight: $weight');
// //
// //     // If it's a "Clothes" product, calculate price based on weight
// //     if (product.productName == "Clothes" && weight != null && weight > 0) {
// //       price = product.basePrice * weight;
// //       print('Clothes price calculated based on weight: $price');
// //     } else if (product.productName == "Blanket" || product.productName == "Comforter") {
// //       // If Single or Double, adjust price accordingly
// //       if (selectedType == "Double") {
// //         price = product.basePrice * 2; // Double the price for Double bed type
// //         print('Price adjusted for Double type: $price');
// //       }
// //     }
// //
// //     // Multiply by quantity to get the final total price
// //     double totalPrice = price * quantity;
// //
// //     // Debugging: Print the final calculated price
// //     print('Final total price: $totalPrice');
// //
// //     return totalPrice;
// //   }
// // }
// // import 'package:get/get.dart';
// // import 'package:dio/dio.dart';
// // import '../Api/config.dart';
// // import '../model/product_model.dart';
// //
// // class ProductController extends GetxController {
// //   var products = <Product>[].obs; // Stores all available products from API
// //   var selectedProduct = Rxn<Product>(); // Stores the currently selected product
// //   var isLoading = false.obs;
// //
// //   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchProducts();
// //   }
// //
// //   Future<void> fetchProducts() async {
// //     try {
// //       isLoading(true);
// //       final response = await _dio.post(
// //         Config.getProductsLaundryApi,
// //         options: Options(headers: {"Content-Type": "application/json"}),
// //         data: {"laundromat_id": "1"},
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final data = response.data;
// //
// //         if (data['Result'] == 'true' && data['Products'] is List) {
// //           products.value = (data['Products'] as List)
// //               .map((product) => Product.fromJson(product))
// //               .toList();
// //         } else {
// //           Get.snackbar('Error', 'No products found!');
// //         }
// //       } else {
// //         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to fetch products: $e');
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   void selectProduct(Product product) {
// //     selectedProduct.value = product;
// //   }
// // }
// //
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:laundry/Api/config.dart';
// import '../model/product_model.dart';
//
// class ProductController extends GetxController {
//   var products = <Product>[].obs;
//   var selectedProduct = Rxn<Product>();
//   var selectedProducts = <Product>[].obs;
//   var isLoading = false.obs;
//
//   final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }
//
//   Future<void> fetchProducts() async {
//     try {
//       isLoading(true);
//       final response = await _dio.post(
//         Config.getProductsLaundryApi,
//         options: Options(headers: {"Content-Type": "application/json"}),
//         //
//
//
//
//
//
//
//
//
//
//         data: {"laundromat_id": "1"},
//       );
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//         if (data['Result'] == 'true' && data['Products'] is List) {
//           products.value = (data['Products'] as List)
//               .map((product) => Product.fromJson(product))
//               .toList();
//         } else {
//           Get.snackbar('Error', 'No products found!');
//         }
//       } else {
//         Get.snackbar('Error', 'Server Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch products: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void selectProduct(Product product) {
//     selectedProduct.value = product;
//   }
//
// //   void updateSelectedProducts(Product updatedProduct) {
// //     // final index = selectedProducts.indexWhere((p) => p.id == updatedProduct.id);
// //   //   if (index != -1) {
// //   //     selectedProducts[index] = updatedProduct;
// //   //   } else {
// //   //     selectedProducts.add(updatedProduct);
// //   //   }
// //   // }
// //
// //   double get totalPrice => selectedProducts.fold(0, (sum, item) => sum + item.totalPrice);
// // }
// }
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../Api/config.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs; // Stores all available products from API
  var selectedProduct = Rxn<Product>(); // Stores the currently selected product
  var isLoading = false.obs;

  final Dio _dio = Dio(BaseOptions(baseUrl: Config.path));

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await _dio.post(
        Config.getProductsLaundryApi,
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {"laundromat_id": "1"},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['Result'] == 'true' && data['Products'] is List) {
          // Debugging: Inspect the products fetched from the API
          print('Fetched products: ${data['Products']}');
          products.value = (data['Products'] as List).map((product) {
            double basePrice = double.tryParse(product['base_price'].toString().trim()) ?? 0.0;
            if (basePrice == 0.0) {
              print('Base price for ${product['product_name']} is invalid, setting it to 0');
            } else {
              print('Base price for ${product['product_name']} is valid: $basePrice');
            }
            return Product(
              productEntryId: product['product_entry_id'],
              laundromatId: product['laundromat_id'],
              productId: product['product_id'],
              basePrice: basePrice,
              productName: product['product_name'],
              additionalInfo: product['additional_info'],
            );
          }).toList();
        } else {
          Get.snackbar('Error', 'No products found!');
        }
      } else {
        Get.snackbar('Error', 'Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectProduct(Product product) {
    selectedProduct.value = product;
  }

  // Function to calculate the total price of a product based on quantity, selected type, and weight
  double calculateTotalPrice(Product product, int quantity, String selectedType, double? weight) {
    double price = product.basePrice;

    // Debugging: Check if the price is correct before calculating the total price
    print('Calculating total price for product: ${product.productName}');
    print('Base price: ${product.basePrice}, Quantity: $quantity, Type: $selectedType, Weight: $weight');

    // If it's a "Clothes" product, calculate price based on weight
    if (product.productName == "Clothes" && weight != null && weight > 0) {
      price = product.basePrice * weight;
      print('Clothes price calculated based on weight: $price');
    } else if (product.productName == "Blanket" || product.productName == "Comforter") {
      // If Single or Double, adjust price accordingly
      if (selectedType == "Double") {
        price = product.basePrice * 2; // Double the price for Double bed type
        print('Price adjusted for Double type: $price');
      }
    }

    // Multiply by quantity to get the final total price
    double totalPrice = price * quantity;

    // Debugging: Print the final calculated price
    print('Final total price: $totalPrice');

    return totalPrice;
  }
}