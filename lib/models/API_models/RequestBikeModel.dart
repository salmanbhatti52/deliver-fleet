import 'package:deliver_partner/models/API_models/GetAllAvailableVehicles.dart';

import 'LogInModel.dart';

class RequestBikeModel {
  int? users_fleet_vehicles_assigned_id,
      users_fleet_id,
      vehicles_id,
      users_fleet_vehicles_id;
  String? date_added, date_modified, status;
  GetAllAvailableVehicles? users_fleet_vehicles;
  LogInModel? users_fleet;

  RequestBikeModel({
    this.users_fleet_vehicles_assigned_id,
    this.users_fleet_id,
    this.vehicles_id,
    this.users_fleet_vehicles_id,
    this.date_added,
    this.date_modified,
    this.status,
    this.users_fleet,
    this.users_fleet_vehicles,
  });

  Map<String, dynamic> toJson() {
    return {
      "users_fleet_vehicles_assigned_id": users_fleet_vehicles_assigned_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "users_fleet_vehicles_id": users_fleet_vehicles_id,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "users_fleet_vehicles": users_fleet_vehicles,
      "users_fleet": users_fleet,
    };
  }

  factory RequestBikeModel.fromJson(Map<String, dynamic> json) {
    return RequestBikeModel(
      users_fleet_vehicles_assigned_id:
          json["users_fleet_vehicles_assigned_id"] ?? -1,
      users_fleet_id: json["users_fleet_id"] ?? -1,
      vehicles_id: json["vehicles_id"] ?? -1,
      users_fleet_vehicles_id: json["users_fleet_vehicles_id"] ?? -1,
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
      users_fleet_vehicles: GetAllAvailableVehicles.fromJson(
          json["users_fleet_vehicles"] ?? Map()),
      users_fleet: LogInModel.fromJson(json["users_fleet"] ?? Map()),
    );
  }
//
}
