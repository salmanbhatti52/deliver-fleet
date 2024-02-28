// To parse this JSON data, do
//
//     final sendSupportChatModel = sendSupportChatModelFromJson(jsonString);

import 'dart:convert';

SendSupportChatModel sendSupportChatModelFromJson(String str) => SendSupportChatModel.fromJson(json.decode(str));

String sendSupportChatModelToJson(SendSupportChatModel data) => json.encode(data.toJson());

class SendSupportChatModel {
  String? status;
  String? message;

  SendSupportChatModel({
    this.status,
    this.message,
  });

  factory SendSupportChatModel.fromJson(Map<String, dynamic> json) => SendSupportChatModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
