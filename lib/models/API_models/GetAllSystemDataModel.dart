class GetAllSystemDataModel {
  int? system_settings_id;
  String? type, description;

  GetAllSystemDataModel({this.system_settings_id, this.type, this.description});

  Map<String, dynamic> toJson() {
    return {
      "system_settings_id": system_settings_id,
      "type": type,
      "description": description,
    };
  }

  factory GetAllSystemDataModel.fromJson(Map<String, dynamic> json) {
    return GetAllSystemDataModel(
      system_settings_id: json["system_settings_id"],
      type: json["type"],
      description: json["description"],
    );
  }
//
}
