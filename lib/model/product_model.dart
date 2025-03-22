class Product {
  final String productEntryId;
  final String laundromatId;
  final String productId;
  final double basePrice;
  final String productName;
  String selectedQuantity;
  double totalPrice;
  String? additionalInfo;

  Product({
    required this.productEntryId,
    required this.laundromatId,
    required this.productId,
    required this.basePrice,
    required this.productName,
    this.selectedQuantity = 'Single',
    this.additionalInfo,
    double? totalPrice,
  }) : totalPrice = totalPrice ?? basePrice;

  factory Product.fromJson(Map<String, dynamic> json) {
    // Parse base_price with trimming whitespace and debugging
    double basePrice = double.tryParse(json['base_price'].toString().trim()) ?? 0.0;

    // Debugging: Print the parsed base price and product name
    print('Product Name: ${json['product_name']}, Base Price: $basePrice'); // Debugging statement

    return Product(
      productEntryId: json['product_entry_id'],
      laundromatId: json['laundromat_id'],
      productId: json['product_id'],
      basePrice: basePrice,
      productName: json['product_name'],
      additionalInfo: json['additional_info'], // For Cloth additional info
    );
  }

  get selectedWeight => null;

  void updateQuantity(String quantity) {
    selectedQuantity = quantity;
    totalPrice = quantity == 'Single' ? basePrice : basePrice * 2;
  }
}
