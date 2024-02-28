class AcceptAndRejectRequestedVehicleModel {
  int? users_fleet_vehicles_assigned_id,
      users_fleet_id,
      vehicles_id,
      users_fleet_vehicles_id;
  String? date_added, date_modified, status;

  AcceptAndRejectRequestedVehicleModel(
      {this.users_fleet_vehicles_assigned_id,
      this.users_fleet_id,
      this.vehicles_id,
      this.users_fleet_vehicles_id,
      this.date_added,
      this.date_modified,
      this.status});

  Map<String, dynamic> toJson() {
    return {
      "users_fleet_vehicles_assigned_id": users_fleet_vehicles_assigned_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "users_fleet_vehicles_id": users_fleet_vehicles_id,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
    };
  }

  factory AcceptAndRejectRequestedVehicleModel.fromJson(
      Map<String, dynamic> json) {
    return AcceptAndRejectRequestedVehicleModel(
      users_fleet_vehicles_assigned_id:
          json["users_fleet_vehicles_assigned_id"] ?? -1,
      users_fleet_id: json["users_fleet_id"] ?? -1,
      vehicles_id: json["vehicles_id"] ?? -1,
      users_fleet_vehicles_id: json["users_fleet_vehicles_id"] ?? -1,
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
    );
  }
//
}
