// To parse this JSON data, do
//
//     final getBookingDestinationStatus = getBookingDestinationStatusFromJson(jsonString);

import 'dart:convert';

GetBookingDestinationStatus getBookingDestinationStatusFromJson(String str) => GetBookingDestinationStatus.fromJson(json.decode(str));

String getBookingDestinationStatusToJson(GetBookingDestinationStatus data) => json.encode(data.toJson());

class GetBookingDestinationStatus {
    String? status;
    List<Datum>? data;

    GetBookingDestinationStatus({
        this.status,
        this.data,
    });

    factory GetBookingDestinationStatus.fromJson(Map<String, dynamic> json) => GetBookingDestinationStatus(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? bookingsDestinationsStatusId;
    String? name;
    String? dateAdded;
    dynamic dateModified;
    String? status;

    Datum({
        this.bookingsDestinationsStatusId,
        this.name,
        this.dateAdded,
        this.dateModified,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingsDestinationsStatusId: json["bookings_destinations_status_id"],
        name: json["name"],
        dateAdded: json["date_added"],
        dateModified: json["date_modified"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "bookings_destinations_status_id": bookingsDestinationsStatusId,
        "name": name,
        "date_added": dateAdded,
        "date_modified": dateModified,
        "status": status,
    };
}
