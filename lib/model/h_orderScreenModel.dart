class HistoryOrder {
  final int id; // Change to int
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
      id: json['id'] ?? 0, // Default to 0 if id is missing
      orderId: json['order_q_id'] ?? 'Unknown', // Default to 'Unknown' if order_q_id is null
      orderStatus: json['order_status'] ?? 'Unknown',
      orderDate: json['order_date'] ?? 'Unknown',
      orderPrice: json['order_price'] ?? '0.00', // Default price if null
    );
  }
}

