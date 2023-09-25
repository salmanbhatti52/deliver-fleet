import 'GetAllVehicalsModel.dart';
import 'LogInModel.dart';

class AddVehicleModel {
  int? users_fleet_vehicles_id, users_fleet_id, vehicles_id;

  String? model,
      color,
      vehicle_registration_no,
      vehicle_identification_no,
      vehicle_license_expiry_date,
      vehicle_insurance_expiry_date,
      rwc_expiry_date,
      cost,
      manufacture_year,
      image,
      date_added,
      date_modified,
      status;

  LogInModel? users_fleet;
  GetAllVehicalsModel? vehicles;

  AddVehicleModel({
    this.users_fleet_vehicles_id,
    this.users_fleet_id,
    this.vehicles_id,
    this.model,
    this.color,
    this.vehicle_registration_no,
    this.vehicle_identification_no,
    this.vehicle_license_expiry_date,
    this.vehicle_insurance_expiry_date,
    this.rwc_expiry_date,
    this.cost,
    this.manufacture_year,
    this.image,
    this.date_added,
    this.date_modified,
    this.status,
    this.users_fleet,
    this.vehicles,
  });

  Map<String, dynamic> toJson() {
    return {
      "users_fleet_vehicles_id": users_fleet_vehicles_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "model": model,
      "color": color,
      "vehicle_registration_no": vehicle_registration_no,
      "vehicle_identification_no": vehicle_identification_no,
      "vehicle_license_expiry_date": vehicle_license_expiry_date,
      "vehicle_insurance_expiry_date": vehicle_insurance_expiry_date,
      "rwc_expiry_date": rwc_expiry_date,
      "cost": cost,
      "manufacture_year": manufacture_year,
      "image": image,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "users_fleet": users_fleet,
      "vehicles": vehicles,
    };
  }

  factory AddVehicleModel.fromJson(Map<String, dynamic> json) {
    return AddVehicleModel(
      users_fleet_vehicles_id: json["users_fleet_vehicles_id"] ?? -1,
      users_fleet_id: json["users_fleet_id"] ?? -1,
      vehicles_id: json["vehicles_id"] ?? -1,
      model: json["model"] ?? '',
      color: json["color"] ?? '',
      vehicle_registration_no: json["vehicle_registration_no"] ?? '',
      vehicle_identification_no: json["vehicle_identification_no"] ?? '',
      vehicle_license_expiry_date: json["vehicle_license_expiry_date"] ?? '',
      vehicle_insurance_expiry_date:
          json["vehicle_insurance_expiry_date"] ?? '',
      rwc_expiry_date: json["rwc_expiry_date"] ?? '',
      cost: json["cost"] ?? '',
      manufacture_year: json["manufacture_year"] ?? '',
      image: json["image"] ?? '',
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
      users_fleet: LogInModel.fromJson(json["users_fleet"] ?? LogInModel()),
      vehicles: GetAllVehicalsModel.fromJson(
          json["vehicles"] ?? GetAllVehicalsModel()),
    );
  }
//

//
}
