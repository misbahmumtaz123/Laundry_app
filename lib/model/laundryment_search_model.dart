class Laundry {
  final String name;
  final String address;
  final double distance;

  Laundry({required this.name, required this.address, required this.distance});

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      name: json['laundromat_name'] ?? 'Unknown', // Map `laundromat_name`
      address: "${json['street_name']}, ${json['city']}, ${json['state']} ${json['zip_code']}", // Concatenate address fields
      distance: 0.0, // Distance not provided in API, set to default
    );
  }
}
