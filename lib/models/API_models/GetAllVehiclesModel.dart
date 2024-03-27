class ServiceTypes {
  int? service_types_id;
  String? name, status;

  ServiceTypes({this.service_types_id, this.name, this.status});

  factory ServiceTypes.fromJson(Map<String, dynamic> json) {
    return ServiceTypes(
      service_types_id: json["service_types_id"],
      name: json["name"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "service_types_id": service_types_id,
      "name": name,
      "status": status,
    };
  }
}

class GetAllVehicalsModel {
  int? vehicles_id, service_types_id;
  String? name,
      weight_allowed,
      number_of_parcels,
      amount,
      tollgate_amount,
      cancellation_amount,
      date_added,
      date_modified,
      status;

  ServiceTypes? service_types;

  GetAllVehicalsModel(
      {this.vehicles_id,
      this.service_types_id,
      this.name,
      this.weight_allowed,
      this.number_of_parcels,
      this.amount,
      this.tollgate_amount,
      this.cancellation_amount,
      this.date_added,
      this.date_modified,
      this.status,
      this.service_types});

  Map<String, dynamic> toJson() {
    return {
      "vehicles_id": vehicles_id,
      "service_types_id": service_types_id,
      "name": name,
      "weight_allowed": weight_allowed,
      "number_of_parcels": number_of_parcels,
      "amount": amount,
      "tollgate_amount": tollgate_amount,
      "cancellation_amount": cancellation_amount,
      "date_added": date_added,
      "date_modified": date_modified,
      "status": status,
      "service_types": service_types,
    };
  }

  factory GetAllVehicalsModel.fromJson(Map<String, dynamic> json) {
    return GetAllVehicalsModel(
      vehicles_id: json["vehicles_id"] ?? -1,
      service_types_id: json["service_types_id"] ?? -1,
      name: json["name"] ?? '',
      weight_allowed: json["weight_allowed"] ?? '',
      number_of_parcels: json["number_of_parcels"] ?? '',
      amount: json["amount"] ?? '',
      tollgate_amount: json["tollgate_amount"] ?? '',
      cancellation_amount: json["cancellation_amount"] ?? '',
      date_added: json["date_added"] ?? '',
      date_modified: json["date_modified"] ?? '',
      status: json["status"] ?? '',
      service_types: ServiceTypes.fromJson(json["service_types"] ?? Map()),
    );
  }
//
}
