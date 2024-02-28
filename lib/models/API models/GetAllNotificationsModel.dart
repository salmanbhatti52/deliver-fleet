class SenderOfNotification {
  String? first_name, last_name, profile_pic;

  SenderOfNotification({this.last_name, this.profile_pic, this.first_name});

  factory SenderOfNotification.fromJson(Map<String, dynamic> json) {
    return SenderOfNotification(
        first_name: json["first_name"] ?? '',
        last_name: json["last_name"] ?? '',
        profile_pic: json["profile_pic"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": first_name,
      "last_name": last_name,
      "profile_pic": profile_pic,
    };
  }
}

class GetAllNotificationsModel {
  int? notifications_id, senders_id, receivers_id;
  String? message, added_at, read_at, notifications_type, status;
  SenderOfNotification? sender;

  GetAllNotificationsModel({
    this.message,
    this.status,
    this.senders_id,
    this.receivers_id,
    this.added_at,
    this.notifications_id,
    this.read_at,
    this.sender,
    this.notifications_type,
  });

  factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsModel(
      notifications_id: json["notifications_id"] ?? -1,
      senders_id: json["senders_id"] ?? -1,
      receivers_id: json["receivers_id"] ?? -1,
      message: json["message"] ?? '',
      added_at: json["added_at"] ?? '',
      read_at: json["read_at"] ?? '',
      status: json["status"] ?? '',
      notifications_type: json["notifications_type"] ?? '',
      sender: SenderOfNotification.fromJson(json["sender"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "notifications_id": notifications_id,
      "senders_id": senders_id,
      "receivers_id": receivers_id,
      "message": message,
      "added_at": added_at,
      "read_at": read_at,
      "notifications_type": notifications_type,
      "status": status,
      "sender": sender,
    };
  }
}
