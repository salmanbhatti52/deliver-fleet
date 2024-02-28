// To parse this JSON data, do
//
//     final startSupportChatModels = startSupportChatModelsFromJson(jsonString);

import 'dart:convert';

StartSupportChatModels startSupportChatModelsFromJson(String str) => StartSupportChatModels.fromJson(json.decode(str));

String startSupportChatModelsToJson(StartSupportChatModels data) => json.encode(data.toJson());

class StartSupportChatModels {
    String? status;
    String? message;

    StartSupportChatModels({
        this.status,
        this.message,
    });

    factory StartSupportChatModels.fromJson(Map<String, dynamic> json) => StartSupportChatModels(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
