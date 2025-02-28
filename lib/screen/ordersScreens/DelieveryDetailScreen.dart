import 'package:flutter/material.dart';
import '../../model/c_orderScreenModel.dart';
import '../../utils/Colors.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final Orders order;

  DeliveryDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order No. ${order.id}'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Status'),
            _buildStatusCard(order.orderStatus ?? 'Not Available'),

            const SizedBox(height: 20),
            _buildSectionTitle('Pickup & Delivery Details'),
            _buildDetailsRow('Laundry Time', order.orderTime ?? 'Not Available'),
            _buildDetailsRow('Weight', order.weight ?? 'Not Available'),
            _buildDetailsRow('Pickup Time', order.pickupOrderTime ?? 'Not Available'),
            _buildDetailsRow('Picked At', order.pickupOrderTime ?? 'Not Available'),
            _buildDetailsRow('Delivery Type', order.deliveryType ?? 'Not Available'),
            _buildDetailsRow('Delivery Time', order.pickupOrderTime ?? 'Not Available'),
            const Divider(),

            _buildDetailsRow('Service Fee', order.orderPrice ?? 'Not Available'),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPaymentOptions(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primeryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Text(
        status,
        style: const TextStyle(fontSize: 18, color: Colors.black87),
      ),
    );
  }

  Widget _buildDetailsRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // Show Payment Options
  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Payment Method",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.green),
                title: const Text("Cash on Delivery"),
                onTap: () {
                  Navigator.pop(context);
                  _showSuccessDialog(context, "Cash on Delivery Selected");
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blueAccent),
                title: const Text("Pay with Card"),
                onTap: () {
                  Navigator.pop(context);
                  _showStripePaymentUI(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show Stripe Payment UI
  void _showStripePaymentUI(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pay with Card",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildPaymentOption(Icons.credit_card, "Credit/Debit Card"),
              _buildPaymentOption(Icons.payment, "Google Pay"),
              _buildPaymentOption(Icons.apple, "Apple Pay"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showSuccessDialog(context, "Payment Successful"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Center(child: Text("Proceed to Payment")),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Payment Option Tile
  Widget _buildPaymentOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      onTap: () {},
    );
  }

  // Show Success Dialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Status"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
