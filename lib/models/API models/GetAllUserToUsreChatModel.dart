import 'package:Deliver_Rider/models/API%20models/LogInModel.dart';

class GetAllUserToUserChatModel {
  int? chat_messages_id, sender_id, receiver_id;
  String? sender_type,
      receiver_type,
      message_type,
      message,
      send_date,
      send_time,
      date_added,
      date_read,
      status;

  LogInModel? sender_data;
  LogInModel? receiver_data;

  GetAllUserToUserChatModel({
    this.chat_messages_id,
    this.sender_id,
    this.receiver_id,
    this.sender_type,
    this.receiver_type,
    this.message_type,
    this.message,
    this.send_date,
    this.send_time,
    this.date_added,
    this.date_read,
    this.status,
    this.receiver_data,
    this.sender_data,
  });

  Map<String, dynamic> toJson() {
    return {
      "chat_messages_id": chat_messages_id,
      "sender_id": sender_id,
      "receiver_id": receiver_id,
      "sender_type": sender_type,
      "receiver_type": receiver_type,
      "message_type": message_type,
      "message": message,
      "send_date": send_date,
      "send_time": send_time,
      "date_added": date_added,
      "date_read": date_read,
      "status": status,
      "receiver_data": receiver_data,
      "sender_data": sender_data,
    };
  }

  factory GetAllUserToUserChatModel.fromJson(Map<String, dynamic> json) {
    return GetAllUserToUserChatModel(
      chat_messages_id: json["chat_messages_id"] ?? -1,
      sender_id: json["sender_id"] ?? -1,
      receiver_id: json["receiver_id"] ?? -1,
      sender_type: json["sender_type"] ?? '',
      receiver_type: json["receiver_type"] ?? '',
      message_type: json["message_type"] ?? '',
      message: json["message"] ?? '',
      send_date: json["send_date"] ?? '',
      send_time: json["send_time"] ?? '',
      date_added: json["date_added"] ?? '',
      date_read: json["date_read"] ?? '',
      status: json["status"] ?? '',
      sender_data: LogInModel.fromJson(json["sender_data"] ?? Map()),
      receiver_data: LogInModel.fromJson(json["receiver_data"] ?? Map()),
    );
  }
//
}
