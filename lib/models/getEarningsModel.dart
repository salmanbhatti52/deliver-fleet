// To parse this JSON data, do
//
//     final getEarningsModel = getEarningsModelFromJson(jsonString);

import 'dart:convert';

GetEarningsModel getEarningsModelFromJson(String str) =>
    GetEarningsModel.fromJson(json.decode(str));

String getEarningsModelToJson(GetEarningsModel data) =>
    json.encode(data.toJson());

class GetEarningsModel {
  String? status;
  List<Datum>? data;

  GetEarningsModel({
    this.status,
    this.data,
  });

  factory GetEarningsModel.fromJson(Map<String, dynamic> json) =>
      GetEarningsModel(
        status: json["status"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  DateTime? dateAdded;
  String? totalAmount;
  int? totalBookings;

  Datum({
    this.dateAdded,
    this.totalAmount,
    this.totalBookings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dateAdded: DateTime.parse(json["date_added"]),
        totalAmount: json["total_amount"],
        totalBookings: json["total_bookings"],
      );

  Map<String, dynamic> toJson() => {
        "date_added": dateAdded!.toIso8601String(),
        "total_amount": totalAmount,
        "total_bookings": totalBookings,
      };
}
