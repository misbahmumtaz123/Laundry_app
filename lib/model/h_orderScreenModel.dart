class HistoryOrder {
  final String id;
  final String orderId;
  final String orderStatus;
  final String orderDate;
  final String orderPrice;

  HistoryOrder({
    required this.id,
    required this.orderId,
    required this.orderStatus,
    required this.orderDate,
    required this.orderPrice,
  });

  factory HistoryOrder.fromJson(Map<String, dynamic> json) {
    return HistoryOrder(
      id: json['id'] ?? 'Unknown', // Default value if null
      orderId: json['order_q_id'] ?? 'Unknown',
      orderStatus: json['order_status'] ?? 'Unknown',
      orderDate: json['order_date'] ?? 'Unknown',
      orderPrice: json['order_price'] ?? '0.00', // Default price if null
    );
  }
}
