// To parse this JSON data, do
//
//     final getEarningsModel = getEarningsModelFromJson(jsonString);

import 'dart:convert';

GetEarningsModel getEarningsModelFromJson(String str) => GetEarningsModel.fromJson(json.decode(str));

String getEarningsModelToJson(GetEarningsModel data) => json.encode(data.toJson());

class GetEarningsModel {
    String? status;
    Data? data;

    GetEarningsModel({
        this.status,
        this.data,
    });

    factory GetEarningsModel.fromJson(Map<String, dynamic> json) => GetEarningsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
    };
}

class Data {
    Month1? month1;

    Data({
        this.month1,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        month1: Month1.fromJson(json["Month 1"]),
    );

    Map<String, dynamic> toJson() => {
        "Month 1": month1!.toJson(),
    };
}

class Month1 {
    List<Week>? week1;
    List<Week>? week2;

    Month1({
        this.week1,
        this.week2,
    });

    factory Month1.fromJson(Map<String, dynamic> json) => Month1(
        week1: List<Week>.from(json["Week 1"].map((x) => Week.fromJson(x))),
        week2: List<Week>.from(json["Week 2"].map((x) => Week.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Week 1": List<dynamic>.from(week1!.map((x) => x.toJson())),
        "Week 2": List<dynamic>.from(week2!.map((x) => x.toJson())),
    };
}

class Week {
    DateTime? dateAdded;
    String? totalAmount;
    int? totalBookings;

    Week({
        this.dateAdded,
        this.totalAmount,
        this.totalBookings,
    });

    factory Week.fromJson(Map<String, dynamic> json) => Week(
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
