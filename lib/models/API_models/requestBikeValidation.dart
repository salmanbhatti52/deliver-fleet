// To parse this JSON data, do
//
//     final validationRequestModel = validationRequestModelFromJson(jsonString);

import 'dart:convert';

ValidationRequestModel validationRequestModelFromJson(String str) =>
    ValidationRequestModel.fromJson(json.decode(str));

String validationRequestModelToJson(ValidationRequestModel data) =>
    json.encode(data.toJson());

class ValidationRequestModel {
  String? status;
  Data? data;

  ValidationRequestModel({
    this.status,
    this.data,
  });

  factory ValidationRequestModel.fromJson(Map<String, dynamic> json) =>
      ValidationRequestModel(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String status;

  Data({
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
