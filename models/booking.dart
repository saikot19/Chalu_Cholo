class Booking {
  final int id;
  final String details;
  final String status;

  Booking({required this.id, required this.details, required this.status});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      details: json['details'],
      status: json['status'],
    );
  }
}
