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
    return Product(
      productEntryId: json['product_entry_id'],
      laundromatId: json['laundromat_id'],
      productId: json['product_id'],
      basePrice: double.parse(json['base_price']),
      productName: json['product_name'],
      additionalInfo: json['additional_info'], // For Cloth additional info
    );
  }

  void updateQuantity(String quantity) {
    selectedQuantity = quantity;
    totalPrice = quantity == 'Single' ? basePrice : basePrice * 2;
  }
}
