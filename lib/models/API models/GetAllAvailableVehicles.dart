import 'package:deliver_partner/models/API%20models/GetAllVehicalsModel.dart';
import 'package:deliver_partner/models/API%20models/LogInModel.dart';

class GetAllAvailableVehicles {
  GetAllVehicalsModel? vehicles;
  LogInModel? users_fleet;

  int? users_fleet_vehicles_id, users_fleet_id, vehicles_id, total_requests;
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

  GetAllAvailableVehicles({
    this.vehicles,
    this.users_fleet_vehicles_id,
    this.users_fleet_id,
    this.vehicles_id,
    this.total_requests,
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
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicle": vehicles,
      "users_fleet_vehicles_id": users_fleet_vehicles_id,
      "users_fleet_id": users_fleet_id,
      "vehicles_id": vehicles_id,
      "total_requests": total_requests,
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
    };
  }

  factory GetAllAvailableVehicles.fromJson(Map<String, dynamic> json) {
    return GetAllAvailableVehicles(
      vehicles: GetAllVehicalsModel.fromJson(
          json["vehicles"] ?? GetAllVehicalsModel()),
      users_fleet: LogInModel.fromJson(json["users_fleet"] ?? Map()),
      users_fleet_vehicles_id: json["users_fleet_vehicles_id"] ?? -1,
      users_fleet_id: json["users_fleet_id"] ?? -1,
      vehicles_id: json["vehicles_id"] ?? -1,
      total_requests: json["total_requests"] ?? -1,
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
    );
  }
//

//
}
