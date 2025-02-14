class CurrentOrder {
  final String id;
  final String orderId;
  final String orderType;
  final String orderStatus;
  final String orderTime;
  final String orderDate;
  final String orderPrice;

  CurrentOrder({
    required this.id,
    required this.orderId,
    required this.orderType,
    required this.orderStatus,
    required this.orderTime,
    required this.orderDate,
    required this.orderPrice,
  });

  factory CurrentOrder.fromJson(Map<String, dynamic> json) {
    return CurrentOrder(
      id: json['id'] ?? 'Unknown', // Default value if null
      orderId: json['order_q_id'] ?? 'Unknown',
      orderType: json['order_type'] ?? 'Unknown',
      orderStatus: json['order_status'] ?? 'Unknown',
      orderTime: json['order_time'] ?? 'Unknown',
      orderDate: json['order_date'] ?? 'Unknown',
      orderPrice: json['order_price'] ?? '0.00', // Default price if null
    );
  }
}
