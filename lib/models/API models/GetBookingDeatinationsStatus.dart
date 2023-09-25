class GetBookingDestinationsStatus {
  int? bookings_destinations_status_id;
  String? name, status;

  GetBookingDestinationsStatus(
      {this.bookings_destinations_status_id, this.name, this.status});

  Map<String, dynamic> toJson() {
    return {
      "bookings_destinations_status_id": bookings_destinations_status_id,
      "name": name,
      "status": status,
    };
  }

  factory GetBookingDestinationsStatus.fromJson(Map<String, dynamic> json) {
    return GetBookingDestinationsStatus(
      bookings_destinations_status_id:
          json["bookings_destinations_status_id"] ?? -1,
      name: json["name"] ?? '',
      status: json["status"] ?? '',
    );
  }
//
}
