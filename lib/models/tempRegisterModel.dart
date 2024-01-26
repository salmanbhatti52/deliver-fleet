// To parse this JSON data, do
//
//     final tempRegisterModel = tempRegisterModelFromJson(jsonString);

import 'dart:convert';

TempRegisterModel tempRegisterModelFromJson(String str) => TempRegisterModel.fromJson(json.decode(str));

String tempRegisterModelToJson(TempRegisterModel data) => json.encode(data.toJson());

class TempRegisterModel {
    String? status;
    String? message;

    TempRegisterModel({
        this.status,
        this.message,
    });

    factory TempRegisterModel.fromJson(Map<String, dynamic> json) => TempRegisterModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
