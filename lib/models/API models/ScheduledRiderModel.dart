import 'GetAllAvailableVehicles.dart';
import 'LogInModel.dart';
import 'ShowBookingsModel.dart';

class ScheduledRiderModel {
  int? bookings_fleet_id,
      bookings_id,
      bookings_destinations_id,
      users_fleet_id,
      vehicles_id;

  String? reason, fleet_amount, date_added, date_modified, status;

  BookingModel? bookings;
  GetAllAvailableVehicles? users_fleet_vehicles;
  LogInModel? users_fleet;

  ScheduledRiderModel(
      {this.bookings_fleet_id,
        this.bookings_id,
        this.bookings_destinations_id,
        this.users_fleet_id,
        this.vehicles_id,
        this.reason,
        this.fleet_amount,
        this.date_added,
        this.date_modified,
        this.status,
        this.bookings,
        this.users_fleet_vehicles,
        this.users_fleet});

  Map<String, dynamic> toJson() {
    return {
      "bookings_fleet_id": bookings_fleet_id,
      "bookings_id": bookings_id,
      "bookings_destinations_id": bookings_destinations_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "reason": reason,
      "fleet_amount": fleet_amount,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "bookings": bookings,
      "users_fleet_vehicles": users_fleet_vehicles,
      "users_fleet": users_fleet,
    };
  }

  factory ScheduledRiderModel.fromJson(Map<String, dynamic> json) {
    return ScheduledRiderModel(
      bookings_fleet_id: json["bookings_fleet_id"],
      bookings_id: json["bookings_id"],
      bookings_destinations_id: json["bookings_destinations_id"],
      users_fleet_id: json["users_fleet_id"],
      vehicles_id: json["vehicles_id"],
      reason: json["reason"],
      fleet_amount: json["fleet_amount"],
      date_added: json["date_added"],
      date_modified: json["date_modified"],
      status: json["status"],
      bookings: BookingModel.fromJson(json["bookings"] ?? Map()),
      users_fleet_vehicles: GetAllAvailableVehicles.fromJson(
          json["users_fleet_vehicles"] ?? GetAllAvailableVehicles()),
      users_fleet: LogInModel.fromJson(json["users_fleet"] ?? Map()),
    );
  }
//
}
