// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? pinId;
  bool? verified;
  String? msisdn;
  int? attemptsRemaining;

  VerifyOtpModel({
    this.pinId,
    this.verified,
    this.msisdn,
    this.attemptsRemaining,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        pinId: json["pinId"],
        verified: json["verified"],
        msisdn: json["msisdn"],
        attemptsRemaining: json["attemptsRemaining"],
      );

  Map<String, dynamic> toJson() => {
        "pinId": pinId,
        "verified": verified,
        "msisdn": msisdn,
        "attemptsRemaining": attemptsRemaining,
      };
}
