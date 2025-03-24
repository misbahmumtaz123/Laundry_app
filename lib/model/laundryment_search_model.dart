//
// class Laundry {
//   final String name;
//   final String address;
//   final double distance;
//   final String status;
//   final double? rating;
//   final String startTime;
//   final String endTime;
//
//   Laundry({
//     required this.name,
//     required this.address,
//     required this.distance,
//     required this.status,
//     this.rating,
//     required this.startTime,
//     required this.endTime,
//   });
//
//   // ✅ Convert JSON to Laundry Object
//   factory Laundry.fromJson(Map<String, dynamic> json) {
//     return Laundry(
//       name: json['laundromat_name'] ?? 'Unknown', // Name from API
//       address:
//       "${json['street_name']}, ${json['city']}, ${json['state']} ${json['zip_code']}", // Full address
//       distance: json['km'] != null ? (json['km'] as num).toDouble() : 0.0, // Distance in km
//       status: (json['status'] != null && json['status'].isNotEmpty)
//           ? json['status'].toString().toLowerCase() == "open"
//           ? "Open"
//           : "Closed"
//           : "Closed", // Default to 'Closed' if null or empty
//       rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null, // Rating from API
//       startTime: json['start_time'] ?? 'N/A', // Start Time
//       endTime: json['end_time'] ?? 'N/A', // End Time
//     );
//   }
//
//   // ✅ Convert Laundry Object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "laundromat_name": name,
//       "street_name": address.split(", ")[0], // Extract street name from full address
//       "city": address.split(", ")[1], // Extract city
//       "state": address.split(", ")[2].split(" ")[0], // Extract state
//       "zip_code": address.split(", ")[2].split(" ")[1], // Extract zip code
//       "km": distance,
//       "status": status.toLowerCase() == "open" ? "open" : "closed",
//       "rating": rating,
//       "start_time": startTime,
//       "end_time": endTime,
//     };
//   }
// }
class Laundry {
  final String id; // Add the ID field
  final String name;
  final String address;
  final double distance;
  final String status;
  final double? rating;
  final String startTime;
  final String endTime;

  Laundry({
    required this.id,  // Include the id in the constructor
    required this.name,
    required this.address,
    required this.distance,
    required this.status,
    this.rating,
    required this.startTime,
    required this.endTime,
  });

  // ✅ Convert JSON to Laundry Object
  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      id: json['id'] ?? '', // Extract the 'id' field from the JSON
      name: json['laundromat_name'] ?? 'Unknown', // Name from API
      address:
      "${json['street_name']}, ${json['city']}, ${json['state']} ${json['zip_code']}", // Full address
      distance: json['km'] != null ? (json['km'] as num).toDouble() : 0.0, // Distance in km
      status: (json['status'] != null && json['status'].isNotEmpty)
          ? json['status'].toString().toLowerCase() == "open"
          ? "Open"
          : "Closed"
          : "Closed", // Default to 'Closed' if null or empty
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null, // Rating from API
      startTime: json['start_time'] ?? 'N/A', // Start Time
      endTime: json['end_time'] ?? 'N/A', // End Time
    );
  }

  // ✅ Convert Laundry Object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id, // Include the 'id' field in the JSON
      "laundromat_name": name,
      "street_name": address.split(", ")[0], // Extract street name from full address
      "city": address.split(", ")[1], // Extract city
      "state": address.split(", ")[2].split(" ")[0], // Extract state
      "zip_code": address.split(", ")[2].split(" ")[1], // Extract zip code
      "km": distance,
      "status": status.toLowerCase() == "open" ? "open" : "closed",
      "rating": rating,
      "start_time": startTime,
      "end_time": endTime,
    };
  }
}

