import 'package:deliver_partner/models/API%20models/ShowBookingsModel.dart';

class GetAllRatingsModel {
  int? bookings_ratings_id, users_customers_id, users_fleet_id, bookings_id;
  String? rated_by, rating, comment, date_added, date_modified;

  ShowBookingsModel? bookings_fleet;

  GetAllRatingsModel(
      {this.bookings_ratings_id,
      this.users_customers_id,
      this.users_fleet_id,
      this.bookings_id,
      this.rated_by,
      this.rating,
      this.comment,
      this.date_added,
      this.date_modified,
      this.bookings_fleet});

  Map<String, dynamic> toJson() {
    return {
      "bookings_ratings_id": bookings_ratings_id,
      "users_customers_id": users_customers_id,
      "users_fleet_id": users_fleet_id,
      "bookings_id": bookings_id,
      "rated_by": rated_by,
      "rating": rating,
      "comment": comment,
      "date_added": date_added,
      "date_modified": date_modified,
      "bookings_fleet": bookings_fleet,
    };
  }

  factory GetAllRatingsModel.fromJson(Map<String, dynamic> json) {
    return GetAllRatingsModel(
      bookings_ratings_id: json["bookings_ratings_id"],
      users_customers_id: json["users_customers_id"],
      users_fleet_id: json["users_fleet_id"],
      bookings_id: json["bookings_id"],
      rated_by: json["rated_by"],
      rating: json["rating"],
      comment: json["comment"],
      date_added: json["date_added"],
      date_modified: json["date_modified"],
      bookings_fleet: ShowBookingsModel.fromJson(json["bookings_fleet"]),
    );
  }
//
}
