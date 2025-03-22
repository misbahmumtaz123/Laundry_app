import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/product_controller.dart';
import '../../model/laundryment_search_model.dart';
import '../../model/product_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final ProductController productController = Get.put(ProductController());
  List<Product> selectedProducts = []; // This will hold the selected products
  String? selectedTemperature = 'Warm';
  TimeOfDay? pickupTime;
  TimeOfDay? deliveryTime;
  String? selectedDeliveryType = 'Same Day';
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments as Map<String, dynamic>;
    final Laundry laundry = Laundry.fromJson(data["laundry"]);
    final String serviceName = data["serviceName"] ?? "Unknown Service";
    final double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the total price of all selected products
    double totalPrice = selectedProducts.fold(0.0, (sum, product) {
      // Assuming the price logic is based on product attributes
      double weight = 0.0; // Default weight is 0
      String selectedType = "Single"; // Default to Single
      return sum + productController.calculateTotalPrice(product, 1, selectedType, weight); // Modify as needed
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Laundry Details Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laundry.name,
                    style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    laundry.address,
                    style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${laundry.distance.toStringAsFixed(2)} km",
                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        laundry.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: laundry.status.toLowerCase() == "open" ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic Data Section for Rating, Distance, and Timing
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;
                return isWideScreen
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildDynamicInfoWidgets(screenWidth, laundry),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildDynamicInfoWidgets(screenWidth, laundry),
                );
              },
            ),

            const SizedBox(height: 20),

            Text(
              "Selected Service: $serviceName",
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.blue),
            ),

            // Product Category Section (from Screen 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryCard(label: "Clothes", icon: Icons.local_laundry_service, onTap: () {
                  addProductToSelection("Clothes");
                }),
                CategoryCard(label: "Blanket", icon: Icons.bed, onTap: () {
                  addProductToSelection("Blanket");
                }),
                CategoryCard(label: "Comforter", icon: Icons.bed, onTap: () {
                  addProductToSelection("Comforter");
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Selected Products Section
            for (var product in selectedProducts)
              ProductCard(
                product: product,
                screenWidth: screenWidth,
                removeProduct: removeProduct,
              ),

            const SizedBox(height: 20),
            const Text("Temperature", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Cold',
                  groupValue: selectedTemperature,
                  onChanged: (value) {
                    setState(() {
                      selectedTemperature = value;
                    });
                  },
                ),
                const Text('Cold'),
                Radio<String>(
                  value: 'Warm',
                  groupValue: selectedTemperature,
                  onChanged: (value) {
                    setState(() {
                      selectedTemperature = value;
                    });
                  },
                ),
                const Text('Warm'),
                Radio<String>(
                  value: 'Hot',
                  groupValue: selectedTemperature,
                  onChanged: (value) {
                    setState(() {
                      selectedTemperature = value;
                    });
                  },
                ),
                const Text('Hot'),
              ],
            ),

            // Pickup Time Selection (from Screen 2)
            const SizedBox(height: 20),
            const Text("Select Pickup Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    pickupTime = time;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pickupTime == null ? "Select Pickup Time" : pickupTime!.format(context),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            // Delivery Type Selection (from Screen 2)
            const SizedBox(height: 20),
            const Text("Delivery Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedDeliveryType,
              items: [
                const DropdownMenuItem<String>(value: 'Same Day', child: Text('Same Day')),
                const DropdownMenuItem<String>(value: 'Next Day', child: Text('Next Day')),
                const DropdownMenuItem<String>(value: 'Scheduled', child: Text('Scheduled')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value;
                });
              },
              isExpanded: true,
            ),

            // Address Section (from Screen 2)
            const SizedBox(height: 20),
            const Text("Address & Instruction", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Enter address and instructions',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            // Display Total Price Section (from Screen 2)
            const SizedBox(height: 20),
            Text(
              "Total Price: \$${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Proceed Button (from Screen 2)
            ElevatedButton(
              onPressed: () {
                // Proceed with the order
                Get.snackbar("Order Proceeded", "Your order has been proceeded.");
              },
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to add products to the selection
  void addProductToSelection(String productType) async {
    Product selectedProduct = productController.products.firstWhere(
          (product) => product.productName == productType,
      orElse: () => Product(
        productEntryId: '',
        laundromatId: '',
        productId: '',
        basePrice: 0.0,
        productName: productType,
        selectedQuantity: 'Single',
        totalPrice: 0.0,
      ),
    );

    setState(() {
      selectedProducts.add(selectedProduct);
    });
  }

  // Function to remove products from the selection
  void removeProduct(Product product) {
    setState(() {
      selectedProducts.remove(product);
    });
  }

  // Widget to build dynamic info for Rating, Distance, and Time
  List<Widget> _buildDynamicInfoWidgets(double screenWidth, Laundry laundry) {
    return [
      Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 20),
          const SizedBox(width: 4),
          Text(
            laundry.rating != null ? laundry.rating!.toStringAsFixed(1) : "N/A",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 20),
          const SizedBox(width: 4),
          Text(
            "${laundry.distance.toStringAsFixed(2)} Km",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.access_time, color: Colors.blue, size: 20),
          const SizedBox(width: 4),
          Text(
            "${laundry.startTime} - ${laundry.endTime}",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        ],
      ),
    ];
  }
}

// Other necessary widget definitions (CategoryCard, ProductCard) will remain the same.

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final double screenWidth;
  final Function(Product) removeProduct; // Function to remove product from list

  const ProductCard({required this.product, required this.screenWidth, required this.removeProduct});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int quantity;
  late String selectedType;
  late TextEditingController weightController;
  bool isWeightUnknown = false;

  @override
  void initState() {
    super.initState();
    quantity = 1; // Default quantity
    selectedType = widget.product.selectedQuantity; // Default type: Single
    weightController = TextEditingController();
    isWeightUnknown = false; // By default, weight is known
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      updatePrice();
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updatePrice();
      });
    }
  }

  void updatePrice() {
    double price = widget.product.basePrice;

    // If it's a "Clothes" product, calculate price based on weight
    if (widget.product.productName == "Clothes" && weightController.text.isNotEmpty && !isWeightUnknown) {
      double weight = double.parse(weightController.text);
      price = widget.product.basePrice * weight;
    } else if (widget.product.productName == "Blanket" || widget.product.productName == "Comforter") {
      // If Single or Double, adjust price accordingly
      if (selectedType == "Double") {
        price = widget.product.basePrice * 2; // Double the price for Double bed type
      }
    }

    // Multiply by quantity to get the final total price
    setState(() {
      widget.product.totalPrice = price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.productName,
              style: TextStyle(fontSize: widget.screenWidth * 0.04, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${widget.product.totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: widget.screenWidth * 0.035, color: Colors.green),
            ),
            const SizedBox(height: 8),

            // Product Type Dropdown for Blanket and Comforter
            if (widget.product.productName == "Blanket" || widget.product.productName == "Comforter") ...[
              DropdownButton<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem<String>(value: "Single", child: Text('Single')),
                  DropdownMenuItem<String>(value: "Double", child: Text('Double')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedType = value;
                      widget.product.selectedQuantity = value;
                      updatePrice();
                    });
                  }
                },
              ),
            ],

            // Weight input for Clothes
            if (widget.product.productName == "Clothes") ...[
              TextField(
                controller: weightController,
                enabled: !isWeightUnknown,
                decoration: const InputDecoration(
                  labelText: 'Enter weight in pounds',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updatePrice();
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: isWeightUnknown,
                    onChanged: (value) {
                      setState(() {
                        isWeightUnknown = value ?? false;
                        if (isWeightUnknown) {
                          weightController.clear();
                        }
                        updatePrice();
                      });
                    },
                  ),
                  const Text("I don't know the weight"),
                ],
              ),
            ],

            const SizedBox(height: 8),

            // Remove the quantity controls for clothes
            if (widget.product.productName != "Clothes") ...[
              // Quantity Controls for Blanket and Comforter
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: decreaseQuantity,
                  ),
                  Text("$quantity", style: TextStyle(fontSize: widget.screenWidth * 0.04)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: increaseQuantity,
                  ),
                ],
              ),
            ],

            // Action Buttons (Add and Cancel)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add product logic
                    Get.snackbar("Added", "Product added to your cart!");
                  },
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Cancel logic - Remove product
                    widget.removeProduct(widget.product);  // Calls the remove function
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
